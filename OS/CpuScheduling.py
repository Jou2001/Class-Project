import os

class Info:
  def __init__(self):
    self.ID = 0
    self.CPU_Brust = 0
    self.Arrival_Time = 0
    self.Priority = 0
    self.Exit_Time = 0
    self.Turnaround_Time = 0
    self.Waiting_Time = 0
    self.Remaining_Time = 0
    self.Ratio = 0

class GanttInfo:
  def __init__(self):
    self.name = ""
    self.list = []

def OutTxt(file_name, ans, Gantt, method):
  file_name = "out_" + file_name
  with open(file_name, 'w') as output_file:
    output_file.write(method)
    for i in range(len(Gantt)):
      output_file.write( "\n" + '=={:>12}==\n'.format(Gantt[i].name))
      for j in range(len(Gantt[i].list)):
        output_file.write(Gantt[i].list[j])
    output_file.write("\n===========================================================\n\n")
    output_file.write("Waiting Time\n" + "ID")
    for j in range(len(Gantt)):
      output_file.write("\t" + format(Gantt[j].name))
    output_file.write("\n===========================================================")
    for j in range(len(ans[0])):
      output_file.write("\n" + str(ans[0][j].ID))
      for i in range(len(ans)):
        output_file.write("\t" + str(ans[i][j].Waiting_Time))
    output_file.write("\n===========================================================\n\n")
    output_file.write("Turnaround Time\n" + "ID")
    for j in range(len(Gantt)):
        output_file.write("\t" + Gantt[j].name)
    output_file.write("\n===========================================================")
    for j in range(len(ans[0])):
      output_file.write("\n" + str(ans[0][j].ID))
      for i in range(len(ans)):
        output_file.write("\t" + str(ans[i][j].Turnaround_Time))
    output_file.write("\n===========================================================\n\n")

def ReadFile(file_name):
  process_list = []
  f = open(file_name, "r")
  method, time_slice = f.readline().split()
  f.readline()
  for line in f.readlines():
    temp = Info()
    if line.strip() != "":
      ID, CPU, Arrival, Priority = line.split()
      temp.ID = int(ID)
      temp.CPU_Brust = int(CPU)
      temp.Arrival_Time = int(Arrival)
      temp.Priority = int(Priority)
      temp.Remaining_Time = int(CPU)
      process_list.append(temp)
  return method, time_slice, process_list

def DecimalTo36(decimal):
  if decimal >= 0 and decimal <= 9:
    return str(decimal)
  else:
    return str(chr(ord('A') + decimal - 10))

def GetTurnaroundTime(process):
  for i in range (len(process)):
    turnaround_time = process[i].Exit_Time - process[i].Arrival_Time
    process[i].Turnaround_Time = turnaround_time

def GetWaitingTime(process):
  for i in range(len(process)):
      waiting_time = process[i].Turnaround_Time - process[i].CPU_Brust
      process[i].Waiting_Time = waiting_time

def GetInfo(process):
  tmp = []
  for i in range(len(process)):
    temp_Info = Info()
    temp_Info.ID = process[i].ID
    temp_Info.Arrival_Time = process[i].Arrival_Time
    temp_Info.CPU_Brust = process[i].CPU_Brust
    temp_Info.Priority = process[i].Priority
    temp_Info.Remaining_Time = process[i].Remaining_Time
    tmp.append(temp_Info)
  return tmp

def FCFS(process, ans_process, Gantt):
  temp = GanttInfo()
  temp.name = "FCFS"
  ready_q = []
  now = 0
  done = 0
  i = 0
  
  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.ID))

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

    now_process = ready_q.pop(0)
    now += now_process.CPU_Brust
    now_process.Exit_Time = now
    done += 1
    for j in range(now_process.CPU_Brust):
      temp.list.append(DecimalTo36(now_process.ID))

  Gantt.append(temp)
  GetTurnaroundTime(process_list)
  GetWaitingTime(process_list)
  process_list = sorted(process_list, key= lambda x: (x.ID))
  ans_process.append(process_list)
  return ans_process, Gantt
  
def RR(process, ans_process, Gantt, time):
  temp = GanttInfo()
  temp.name = "RR"
  ready_q = []
  ans = []

  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.ID))
  now = 0
  done = 0
  i = 0

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

    now_process = ready_q.pop(0)

    if now_process.Remaining_Time <= time:
      now += now_process.Remaining_Time
      now_process.Exit_Time = now
      for j in range(now_process.Remaining_Time):
        temp.list.append(DecimalTo36(now_process.ID))
      now_process.Remaining_Time = 0
      ans.append(now_process)
      done += 1
    else:
      now += time
      now_process.Remaining_Time -= time
      for j in range(time):
        temp.list.append(DecimalTo36(now_process.ID))
    
    while i < len(process_list) and process_list[i].Arrival_Time <= now:
      ready_q.append(process_list[i])
      i += 1
    if now_process.Remaining_Time > 0:
      ready_q.append(now_process)

  Gantt.append(temp)
  GetTurnaroundTime(ans)
  GetWaitingTime(ans)
  ans = sorted(ans, key= lambda x: (x.ID))
  ans_process.append(ans)
  return ans_process, Gantt

def SJF(process, ans_process, Gantt):
  temp = GanttInfo()
  temp.name = "SJF"
  ready_q = []
  ans = []

  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.CPU_Brust, x.ID))
  now = 0
  done = 0
  i = 0

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

    ready_q = sorted(ready_q, key= lambda x: (x.CPU_Brust, x.Arrival_Time, x.ID))
    now_process = ready_q.pop(0)

    now += now_process.CPU_Brust
    now_process.Exit_Time = now
    ans.append(now_process)
    done += 1
    for j in range(now_process.CPU_Brust):
      temp.list.append(DecimalTo36(now_process.ID))
    
  Gantt.append(temp)
  GetTurnaroundTime(ans)
  GetWaitingTime(ans)
  ans = sorted(ans, key= lambda x: (x.ID))
  ans_process.append(ans)
  return ans_process, Gantt

def SRTF(process, ans_process, Gantt, time):
  temp = GanttInfo()
  temp.name = "SRTF"
  ready_q = []
  ans = []

  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.ID))
  now = 0
  done = 0
  i = 0

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

    ready_q = sorted(ready_q, key= lambda x: (x.Remaining_Time, x.Arrival_Time, x.ID))
    now_process = ready_q.pop(0)

    now += 1
    now_process.Remaining_Time -= 1
    temp.list.append(DecimalTo36(now_process.ID))

    if now_process.Remaining_Time == 0:
      now_process.Exit_Time = now
      ans.append(now_process)
      done += 1

    else :ready_q.append(now_process)

  Gantt.append(temp)
  GetTurnaroundTime(ans)
  GetWaitingTime(ans)
  ans = sorted(ans, key= lambda x: (x.ID))
  ans_process.append(ans)
  return ans_process, Gantt

def HRRN(process, ans_process, Gantt):
  temp = GanttInfo()
  temp.name = "HRRN"
  ready_q = []
  ans = []
  
  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.ID))
  now = 0
  done = 0
  i = 0

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

    for k in range(len(ready_q)):
      ready_q[k].Ratio = (now - ready_q[k].Arrival_Time + ready_q[k].CPU_Brust) / ready_q[k].CPU_Brust
    ready_q = sorted(ready_q, key= lambda x: (-x.Ratio, x.Arrival_Time, x.ID))

    now_process = ready_q.pop(0)
    now += now_process.CPU_Brust
    now_process.Exit_Time = now
    ans.append(now_process)
    done += 1
    for j in range(now_process.CPU_Brust):
      temp.list.append(DecimalTo36(now_process.ID))

  Gantt.append(temp)
  GetTurnaroundTime(ans)
  GetWaitingTime(ans)
  ans = sorted(ans, key= lambda x: (x.ID))
  ans_process.append(ans)
  return ans_process, Gantt

def PPRR(process, ans_process, Gantt, time):
  temp = GanttInfo()
  temp.name = "PPRR"
  ready_q = []
  ans = []
  
  tmp = GetInfo(process)
  process_list = sorted(tmp, key= lambda x: (x.Arrival_Time, x.Priority, x.ID))
  now = 0
  done = 0
  i = 0

  while done != len(process_list):
    if i != len(process_list):
      k = i
      while len(ready_q) == 0 and k < len(process_list) and now < process_list[k].Arrival_Time:
        for j in range(now, process_list[k].Arrival_Time):
          temp.list.append("-")
        now = process_list[k].Arrival_Time
        break

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        now = process_list[i].Arrival_Time
        i += 1

    ready_q = sorted(ready_q, key= lambda x: (x.Priority))
    
    now_process = ready_q.pop(0)

    if i == len(process_list):
      if len(ready_q) == 0 or now_process.Priority < ready_q[0].Priority:
        now += now_process.Remaining_Time
        now_process.Exit_Time = now
        ans.append(now_process)
        done += 1
        for j in range(now_process.Remaining_Time):
          temp.list.append(DecimalTo36(now_process.ID))
        now_process.Remaining_Time = 0

      elif now_process.Priority == ready_q[0].Priority:
        if now_process.Remaining_Time <= time:
          now += now_process.Remaining_Time
          now_process.Exit_Time = now
          ans.append(now_process)
          done += 1
          for j in range(now_process.Remaining_Time):
            temp.list.append(DecimalTo36(now_process.ID))
          now_process.Remaining_Time = 0
        else:
          now += time
          now_process.Remaining_Time -= time
          for j in range(time):
            temp.list.append(DecimalTo36(now_process.ID))
          if now_process.Remaining_Time > 0:
            ready_q.append(now_process)

    else :

      if (process_list[i].Arrival_Time <= now+time and now_process.Priority == process_list[i].Priority) or now+time <= process_list[i].Arrival_Time:
        if now_process.Remaining_Time <= time:
          now += now_process.Remaining_Time
          for j in range(now_process.Remaining_Time):
            temp.list.append(DecimalTo36(now_process.ID))
          now_process.Remaining_Time = 0
        else:
          now += time
          now_process.Remaining_Time -= time
          for j in range(time):
            temp.list.append(DecimalTo36(now_process.ID))
      
      elif now+time > process_list[i].Arrival_Time:
        if (process_list[i].Arrival_Time - now > now_process.Remaining_Time):
          do = now_process.Remaining_Time
        else:
          do = process_list[i].Arrival_Time - now
        now_process.Remaining_Time = now_process.Remaining_Time - do
        for j in range(do):
          temp.list.append(DecimalTo36(now_process.ID))
        now += do

      while i < len(process_list) and process_list[i].Arrival_Time <= now:
        ready_q.append(process_list[i])
        i += 1

      if now_process.Remaining_Time > 0:
        ready_q.append(now_process)

      elif now_process.Remaining_Time == 0:
        now_process.Exit_Time = now
        ans.append(now_process)
        done += 1


  Gantt.append(temp)
  GetTurnaroundTime(ans)
  GetWaitingTime(ans)
  ans = sorted(ans, key= lambda x: (x.ID))
  ans_process.append(ans)
  return ans_process, Gantt

def method1(process, ans_process, Gantt, file_name):
  ans_process, Gantt = FCFS(process, ans_process, Gantt)
  OutTxt(file_name, ans_process, Gantt, "FCFS")

def method2(process, ans_process, Gantt, file_name, time):
  ans_process, Gantt = RR(process, ans_process, Gantt, time)
  OutTxt(file_name, ans_process, Gantt, "RR")

def method3(process, ans_process, Gantt, file_name):
  ans_process, Gantt = SJF(process, ans_process, Gantt)
  OutTxt(file_name, ans_process, Gantt, "SJF")

def method4(process, ans_process, Gantt, file_name, time):
  ans_process, Gantt = SRTF(process, ans_process, Gantt, time)
  OutTxt(file_name, ans_process, Gantt, "SRTF")

def method5(process, ans_process, Gantt, file_name):
  ans_process, Gantt = HRRN(process, ans_process, Gantt)
  OutTxt(file_name, ans_process, Gantt, "HRRN")

def method6(process, ans_process, Gantt, file_name, time):
  ans_process, Gantt = PPRR(process, ans_process, Gantt, time)
  OutTxt(file_name, ans_process, Gantt, "Priority RR")

def All(process, ans_process, Gantt, file_name, time):
  ans_process, Gantt = FCFS(process, ans_process, Gantt)
  ans_process, Gantt = RR(process, ans_process, Gantt, time)
  ans_process, Gantt = SJF(process, ans_process, Gantt)
  ans_process, Gantt = SRTF(process, ans_process, Gantt, time)
  ans_process, Gantt = HRRN(process, ans_process, Gantt)
  ans_process, Gantt = PPRR(process, ans_process, Gantt, time)
  OutTxt(file_name, ans_process, Gantt, "All")

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
      process = []
      Gantt = []
      ans_process = []
      method, time_slice, process = ReadFile(file_name)

      if method == "1":
        method1(process, ans_process, Gantt, file_name)
      elif method == "2":
        method2(process, ans_process, Gantt, file_name, int(time_slice))
      elif method == "3":
        method3(process, ans_process, Gantt, file_name)
      elif method == "4":
        method4(process, ans_process, Gantt, file_name, int(time_slice))
      elif method == "5":
        method5(process, ans_process, Gantt, file_name)
      elif method == "6":
        method6(process, ans_process, Gantt, file_name, int(time_slice))
      elif method == "7":
        All(process, ans_process, Gantt, file_name, int(time_slice))