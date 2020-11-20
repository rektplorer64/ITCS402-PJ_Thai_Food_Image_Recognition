import os
from tabulate import tabulate


print(os.path.basename(__file__))
dir = os.path.dirname(os.path.abspath(__file__))
print("Current Working Directory:", dir)

list = os.listdir(dir) # dir is your directory path
# print(list)

fileCountList = []
for folder in list:
    if folder == os.path.basename(__file__):
        continue

    subfolderPath = dir + '/' + folder

    fileCountList.append((folder, len(os.listdir(subfolderPath))))

# print(fileCountList)
number_files = len(list)
print(tabulate(fileCountList))
print("⭐ Total Classes:\t", len(fileCountList))
print("⭐ Total Images:\t\t", sum(map(lambda x: x[1], fileCountList)))