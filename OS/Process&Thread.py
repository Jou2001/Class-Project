from datetime import datetime,timezone,timedelta
import os
import time
import multiprocessing
import threading

input_data = []
sort_data = [[]]
ans = []

def GetTime():
  dt1 = datetime.utcnow().replace(tzinfo=timezone.utc) # Get utc time
  dt2 = dt1.astimezone(timezone(timedelta(hours=8))) # Transfer time zone to UTC+8
  return dt2

def OutTxt(file_name, time, num, sort_ans,):
  file_name = file_name + "_output" + num + ".txt"
  with open(file_name, 'w') as output_file:
    output_file.write("Sort :\n")
    for j in range(len(sort_ans)):
      output_file.write(str(sort_ans[j]) + "\n")
    output_file.write("CPU Time : " + str(time) + "\n")
    output_file.write("Output Time : " + str(GetTime()))

def BubbleSort(data, size, tmp):
  for i in range(size-1):
    for j in range(size-1-i):
      if data[j] > data[j+1]:
        data[j], data[j+1] = data[j+1], data[j]

  tmp.append(data)

def MergeSort(left, right, tmp_ans):
  left_size = len(left)
  right_size = len(right)
  l, r = 0, 0
  items = []

  while l < left_size and r < right_size:
    if left[l] <= right[r]:
      items.append(left[l])
      l += 1
    else:
      items.append(right[r])
      r += 1
  
  if l == left_size:
    items.extend(right[r:])
  else:
    items.extend(left[l:])

  tmp_ans.append(items)

def BubbleMergeSort(data, tmp_ans):
  global sort_data, ans
  sort_data.clear()
  for i in range(len(data)):
    BubbleSort(data[i], len(data[i]), ans)
    sort_data.append(ans.pop(0))

  while len(sort_data) != 1:
    Left = sort_data.pop(0)
    Right = sort_data.pop(0)
    MergeSort(Left, Right, ans)
    sort_data.append(ans.pop(0))

  tmp_ans.append(sort_data.pop(0))

def ReadFile(name):
  file_name = name + ".txt"
  f = open(file_name, "r")
  for line in f:
    input_data.append(int(line))

def SplitIntoKParts(k):
  result = [[] for _ in range(k)]
  size, i = len(input_data), 0
  for j in range(k):
    part_size = int(size // k + int(j >= k - size % k))
    for p in range(part_size):
      result[j].append(input_data[i])
      i += 1

  return result

def Method1(name, problem):
  global ans
  start = time.time()
  BubbleSort(input_data, len(input_data), ans)
  end = time.time() - start
  OutTxt(name, end, str(problem), ans.pop(0))

def Method2(name, problem, k):
  tmp = multiprocessing.Manager()
  tmp_ans = tmp.list()
  parts = SplitIntoKParts(k)
  start = time.time()
  p1 = multiprocessing.Process(target = BubbleMergeSort, args = (parts, tmp_ans))
  p1.start()
  p1.join()
  end = time.time() - start
  OutTxt(name, end, str(problem), tmp_ans.pop(0))

def Method3(name, problem, k):
  tmp = multiprocessing.Manager()
  tmp_ans = tmp.list()
  parts = SplitIntoKParts(k)
  process = []
  process_2 = []
  start = time.time()

  for i in range(k):
    p = multiprocessing.Process(target=BubbleSort, args=(parts[i], len(parts[i]),tmp_ans))
    process.append(p)
    process[i].start()

  for i in range(len(process)):
    process[i].join()

  while len(tmp_ans) != 1:
    for i in range(len(tmp_ans) // 2):
      p = multiprocessing.Process(target=MergeSort, args=(tmp_ans.pop(0), tmp_ans.pop(0), tmp_ans))
      process_2.append(p)
      process_2[i].start()
        
    for j in range(len(process_2)):
      process_2[j].join()
    process_2.clear()

  end = time.time() - start
  OutTxt(name, end, str(problem), tmp_ans.pop(0))

def Method4(name, problem, k):
  tmp_ans = []
  parts = SplitIntoKParts(k)
  threads = []
  threads_2 = []

  start = time.time()
  for i in range(k):
    p = threading.Thread(target=BubbleSort, args=(parts[i], len(parts[i]),tmp_ans))
    threads.append(p)
    threads[i].start()

  for i in range(k):
    threads[i].join()

  while len(tmp_ans) != 1:
    for i in range(len(tmp_ans) // 2):
      p = threading.Thread(target=MergeSort, args=(tmp_ans.pop(0), tmp_ans.pop(0), tmp_ans))
      threads_2.append(p)
      threads_2[i].start()

    for j in range(len(threads_2)):
      threads_2[j].join()
    threads_2.clear()

  end = time.time() - start
  OutTxt(name, end, str(problem), tmp_ans.pop(0))

def Initial():
  input_data.clear()
  sort_data.clear()
  ans.clear()

if __name__ == '__main__':
  file_name = ""
  how_many, method = 0, 0
  exist = False

  while not exist:
    file_name = input("請輸入檔案名稱(0 [Quit]): ")
    while not exist and not os.path.exists(file_name + ".txt"):
      if file_name == "0": exist = True
      else: file_name = input("請輸入檔案名稱(0 [Quit]): ")

    if not exist:
      Initial()

      method = input("請輸入方法編號 (1, 2, 3, 4): ")
      while not method.isdigit() or (method != '1' and method != '2' and method != '3' and method != '4'):
        method = input("請輸入方法編號 (1, 2, 3, 4): ")
      method = int(method)

      if method != 1:
        how_many = input("請輸入要切幾份： ")
        while not how_many.isdigit() :
          how_many = input("請輸入要切幾份： ")
        how_many = int(how_many)

      ReadFile(file_name)
      if method == 1:
        Method1(file_name, method)

      elif method == 2:
        Method2(file_name, method, how_many)

      elif method == 3:
        Method3(file_name, method, how_many)

      elif method == 4:
        Method4(file_name, method, how_many)