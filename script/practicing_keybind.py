# a simple python script for practicing the new keymap

import random

strSym = "+= -= *= /= &= |= != + - * / & | <> () [] {} : := -> => ! @ # $ %"
# strSym = "-= -- - _ __ ="

def shuffle_string(str):
    list = str.split()
    random.shuffle(list)
    return list

OutSym = shuffle_string(strSym)

while True:
    outList = []
    outputLen = 4 #even number only
    popLen = int(outputLen / 2)

    if len(OutSym) < popLen:
        print('section complete, continue?(y/n):')
        if (input() == 'n'):
            print('thank you')
            exit()
        else:
            OutSym = shuffle_string(strSym)

    for _ in range(popLen):
        outList.append(OutSym.pop())
        outList.append("{:.2f}".format(random.uniform(0, 99)))

    for v in outList:
        print(v, end = ' ')
    print(' ')

    inList = input().split()
    for i in range(outputLen):
        if inList[i] == outList[i] and len(inList) == outputLen:
            if i == outputLen - 1:
                print("correct, next:\n")
        else:
            print("error!\n")
            break
