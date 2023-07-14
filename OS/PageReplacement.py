import os

class Info:
  def __init__(self):
    self.string = ""
    self.frame = []
    self.fault = False
    self.replacement = False

class Method:
  def __init__(self):
    self.name = ""

def ReadFile( file_name ):
  f = open( file_name, "r" )
  method, frame = f.readline().split()
  reference = []
  reference = f.readline()
  if reference[len(reference)-1] == '\n':
    reference = reference[:-1]

  return method, int(frame), reference

def CompareMinCount(queue, count):
  temp = []
  num = 0
  
  for i in range(len(queue)):
    for k in range(len(count)):
      if count[k][0] == queue[i] and count[k][1] != 0:
        temp.append(count[k])

  if len(temp) != 0 : count = temp[0][1]
  for i in range(len(temp)):
    if (temp[i][1] < count ):
      count = temp[i][1]
      num = i
  if count == temp[0][1]:
    return temp[0][0]
  else:
    return temp[num][0]

def CompareMaxCount(queue, count):
  temp = []
  num = 0
  
  for i in range(len(queue)):
    for k in range(len(count)):
      if count[k][0] == queue[i] and count[k][1] != 0:
        temp.append(count[k])

  if len(temp) != 0 : count = temp[0][1]
  for i in range(len(temp)):
    if (temp[i][1] > count ):
      count = temp[i][1]
      num = i
  if count == temp[0][1]:
    return temp[0][0]
  else:
    return temp[num][0]

def OutTxt( ans, frame, file_name, name ):
  file_name = "out_" + file_name
  with open( file_name, 'w' ) as output_file:
    for i in range( len( name ) ):
      page_fault = 0
      page_replace = 0
      output_file.write( '--------------' + name[i].name + '-----------------------\n' )
      for j in range( len(ans[i]) ):
        output_file.write(ans[i][j].string + "\t")
        for k in range( len(ans[i][j].frame)-1, -1, -1):
          output_file.write( ans[i][j].frame[k] )
        if ans[i][j].fault :
          output_file.write("\tF")
          page_fault += 1
        if ans[i][j].replacement:
          page_replace += 1
        output_file.write( '\n' )
      output_file.write( "Page Fault = " + str(page_fault) + "  Page Replaces = " + str(page_replace) + "  Page Frames = " + str(frame) + '\n')
      if len(name) > 1 and i != len(name) - 1 : output_file.write('\n')

def FIFO( frame, reference, ans ):
  queue = []
  temp_ans = []
  for i in range( len(reference) ):
    temp = Info()
    temp.string = reference[i]
    if len(queue) < frame: 
      if reference[i] not in queue:
        queue.append(reference[i])
        temp.fault = True
    else:
      if reference[i] not in queue:
        queue.pop(0)
        queue.append(reference[i])
        temp.fault = True
        temp.replacement = True
    temp.frame = queue.copy()
    temp_ans.append(temp)

  ans.append(temp_ans)
  return ans

def LRU( frame, reference, ans ):
  queue = []
  temp_ans = []
  for i in range( len(reference) ):
    temp = Info()
    temp.string = reference[i]
    if len(queue) < frame: 
      if reference[i] not in queue:
        queue.append(reference[i])
        temp.fault = True
    else:
      if reference[i] not in queue:
        temp.replacement = True
        queue.pop(0)
        queue.append(reference[i])
        temp.fault = True
      else :
        queue.remove(reference[i])
        queue.append( reference[i])

    temp.frame = queue.copy()
    temp_ans.append(temp)

  ans.append(temp_ans)
  return ans    

def LFUFIFO( frame, reference, ans ):
  queue = []
  temp_ans = []
  count = []

  for i in range( len(reference) ):
    temp = Info()
    temp.string = reference[i]
    if len(queue) < frame: 
      if reference[i] not in queue:
        queue.append(reference[i])
        temp.fault = True
  
    else:
      if reference[i] not in queue:
        info = CompareMinCount(queue, count)
        for k in range(len(count)):
          if count[k][0] == info:
            count[k][1] = 0
            queue.pop(queue.index(info))
            queue.append(reference[i])
            temp.fault = True
            temp.replacement = True
            break
        
      else:
        for k in range(len(count)):
          if count[k][0] == reference[i]:
            count[k][1] += 1 

    if  len(count) == 0:
      num = []
      num.append(reference[i])
      num.append(1)
      count.append(num)
    else:
      have_same = False
      for k in range(len(count)):
        if count[k][0] == reference[i]:
          count[k][1] += 1
          have_same = True
          break
      if not have_same:
        num = []
        num.append(reference[i])
        num.append(1)
        count.append(num)
          
    count.sort(key=lambda x:(x[1], x[0] ))    
    temp.frame = queue.copy()
    temp_ans.append(temp)

  ans.append(temp_ans)
  return ans

def MFUFIFO( frame, reference, ans ):
  queue = []
  temp_ans = []
  count = []

  for i in range( len(reference) ):
    temp = Info()
    temp.string = reference[i]
    if len(queue) < frame: 
      if reference[i] not in queue:
        queue.append(reference[i])
        temp.fault = True
  
    else:
      if reference[i] not in queue:
        info = CompareMaxCount(queue, count)
        for k in range(len(count)):
          if count[k][0] == info:
            count[k][1] = 0
            queue.pop(queue.index(info))
            queue.append(reference[i])
            temp.fault = True
            temp.replacement = True
            break
        
      else:
        for k in range(len(count)):
          if count[k][0] == reference[i]:
            count[k][1] += 1 

    if  len(count) == 0:
      num = []
      num.append(reference[i])
      num.append(1)
      count.append(num)
    else:
      have_same = False
      for k in range(len(count)):
        if count[k][0] == reference[i]:
          count[k][1] += 1
          have_same = True
          break
      if not have_same:
        num = []
        num.append(reference[i])
        num.append(1)
        count.append(num)
          
    count.sort(key=lambda x:(-x[1], x[0] ))  
    temp.frame = queue.copy()
    temp_ans.append(temp)

  ans.append(temp_ans)
  return ans

def LFULRU( frame, reference, ans ):
  queue = []
  temp_ans = []
  count = []

  for i in range( len(reference) ):
    temp = Info()
    temp.string = reference[i]
    if len(queue) < frame: 
      if reference[i] not in queue:
        queue.append(reference[i])
        temp.fault = True
  
    else:
      if reference[i] not in queue:
        info = CompareMinCount(queue, count)
        for k in range(len(count)):
          if count[k][0] == info:
            count[k][1] = 0
            queue.pop(queue.index(info))
            queue.append(reference[i])
            temp.fault = True
            temp.replacement = True
            break
        
      else:
        for k in range(len(count)):
          queue.remove(reference[i])
          queue.append(reference[i])
          if count[k][0] == reference[i]:
            count[k][1] += 1 

    if  len(count) == 0:
      num = []
      num.append(reference[i])
      num.append(1)
      count.append(num)
    else:
      have_same = False
      for k in range(len(count)):
        if count[k][0] == reference[i]:
          count[k][1] += 1
          have_same = True
          break
      if not have_same:
        num = []
        num.append(reference[i])
        num.append(1)
        count.append(num)
          
    count.sort(key=lambda x:(x[1], x[0] ))    
    temp.frame = queue.copy()
    temp_ans.append(temp)

  ans.append(temp_ans)
  return ans


def method1( frame, reference, ans, name_list ) :
  name = Method()
  name.name = "FIFO"
  name_list.append(name)
  ans = FIFO( frame, reference, ans )
  return ans, frame, name_list

def method2( frame, reference, ans, name_list ) :
  name = Method()
  name.name = "LRU"
  name_list.append(name)
  ans = LRU( frame, reference, ans )
  return ans, frame, name_list

def method3( frame, reference, ans, name_list ) :
  name = Method()
  name.name = "Least Frequently Used Page Replacement"
  name_list.append(name)
  ans = LFUFIFO( frame, reference, ans )
  return ans, frame, name_list

def method4( frame, reference, ans, name_list ) :
  name = Method()
  name.name = "Most Frequently Used Page Replacement "
  name_list.append(name)
  ans = MFUFIFO( frame, reference, ans )
  return ans, frame, name_list

def method5( frame, reference, ans, name_list ) :
  name = Method()
  name.name = "Least Frequently Used LRU Page Replacement"
  name_list.append(name)
  ans = LFULRU( frame, reference, ans )
  return ans, frame, name_list

def method6( frame, reference, ans, name_list ) :
  ans, frame, name_list = method1( frame, reference, ans, name_list )
  ans, frame, name_list = method2( frame, reference, ans, name_list )
  ans, frame, name_list = method3( frame, reference, ans, name_list )
  ans, frame, name_list = method4( frame, reference, ans, name_list )
  ans, frame, name_list = method5( frame, reference, ans, name_list )
  return ans, frame, name_list

if __name__ == '__main__':
  exist = False

  while not exist:
    file_name = input("Please enter File Name (eg. input1, input1.txt, (0 [Quit]): ")
    if file_name != "0" and ".txt" not in file_name: file_name += ".txt"
    while not exist and not os.path.exists(file_name):
      if file_name == "0": 
        exist = True
      else: 
        print("Do not have this file.")
        file_name = input("Please enter File Name (eg. input1, input1.txt, (0 [Quit]): ")
        if file_name != "0" and ".txt" not in file_name: file_name += ".txt"

    if not exist:
      ans = []
      name_list = []
      method, page_frame, page_reference = ReadFile(file_name)

      if method == "1":
        ans, frame, name_list = method1( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )
      elif method == "2":
        ans, frame, name_list = method2( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )
      elif method == "3":
        ans, frame, name_list = method3( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )
      elif method == "4":
        ans, frame, name_list = method4( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )
      elif method == "5":
        ans, frame, name_list = method5( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )
      elif method == "6":
        ans, frame, name_list = method6( page_frame, page_reference, ans, name_list )
        OutTxt( ans, frame, file_name, name_list )