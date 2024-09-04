#!/usr/bin/python 

import argparse

def get_args():
    parser = argparse.ArgumentParser(description="mapCounts")
    parser.add_argument("-f", help="Name of input file", type=str, required=True)
    return parser.parse_args()

args = get_args()
file = str(args.f)

mapCount = 0
unmapCount = 0

with open(file,"r") as fh:
    for line in fh:
        line = line.strip('\n')
        values = line.split("\t")
        if values[0].find("@"):
            if((int(values[1]) & 4) != 4 ) and ((int(values[1]) & 8) != 8):
                mapCount += 1
            else:
                unmapCount += 1

print("Mapped: " + str(mapCount))
print("Unmapped: " + str(unmapCount))