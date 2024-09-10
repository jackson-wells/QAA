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
        #if not a header line
        if values[0].find("@"):
            #if not a secondary alignment
            if((int(values[1]) & 256) != 256):
                #if mapped
                if((int(values[1]) & 4) != 4):
                    mapCount += 1
                #if not mapped
                else:
                    unmapCount += 1

print("Mapped: " + str(mapCount))
print("Unmapped: " + str(unmapCount))