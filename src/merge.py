from sys import argv

with open(argv[1],"r+") as f:
  all_bed = [x.replace("\n","").split("\t") for x in f.readlines()]

change = 1
for i in range(len(all_bed)-1):
  if change == 0:
    change = 1
    continue
  if change == 1:
    if all_bed[i][0]==all_bed[i+1][0] and (int(all_bed[i+1][1]) >= int(all_bed[i][1]) and int(all_bed[i+1][1]) <= int(all_bed[i][2])):
      print(f"{all_bed[i][0]}\t{all_bed[i][1]}\t{all_bed[i+1][2]}")
      change = 0
    else:
      print(f"{all_bed[i][0]}\t{all_bed[i][1]}\t{all_bed[i][2]}")

i = len(all_bed)-1
if change == 1:
  print(f"{all_bed[i][0]}\t{all_bed[i][1]}\t{all_bed[i][2]}")
    
