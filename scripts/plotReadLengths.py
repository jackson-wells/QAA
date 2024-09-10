#!/usr/bin/python

import argparse
import bioinfo
import gzip
import os
import matplotlib.pyplot as plt

def get_args():
    parser = argparse.ArgumentParser(description="IDE")
    parser.add_argument("-f1", help="R1 file", type=str, required=True)
    parser.add_argument("-f2", help="R2 file", type=str, required=True)
    parser.add_argument("-l", help="Library name", type=str, required=True)
    return parser.parse_args()

def get_lengths(file):
    tempLengths = []
    with gzip.open(file,"rt") as fh:
        for lineCount,line in enumerate(fh):
            line = line.strip('\n') # type: ignore
            if lineCount % 4 == 1: #if seq line
                tempLengths.append(len(line))
    return tempLengths

args = get_args()
file1 = str(args.f1)
file2 = str(args.f2)
library = str(args.l)
file1 = os.path.realpath(file1)
file2 = os.path.realpath(file2)
f1Lengths = get_lengths(file1)
f2Lengths = get_lengths(file2)


outputFile = library.replace(" ", "_") + "_readLength_hist.png" #new output file name
plt.style.use("seaborn-v0_8-deep")

plt.hist((f1Lengths,f2Lengths), bins=range(min(f1Lengths), max(f2Lengths) + 2, 2),label=["R1", "R2"]) # type: ignore
plt.ylabel("Count")
plt.xlabel("Read Length")
plt.yscale("log")
plt.title("Distribution of " + library + " Read Lengths")
plt.legend(loc='upper left')
plt.tight_layout()
plt.savefig("/projects/bgmp/jwel/bioinfo/QAA/data/readLengths/" + outputFile)