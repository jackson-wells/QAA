#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=lenPlots
#SBATCH --nodes=1
#SBATCH --mem=225G
#SBATCH --time=5-00:00:00
#SBATCH --error=logs/lenPlots_%j.txt
#SBATCH --output=logs/lenPlots_%j.txt 

conda activate QAA

python /projects/bgmp/jwel/bioinfo/QAA/scripts/plotReadLengths.py \
    -f1 /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz \
    -f2 /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz \
    -l "Trimmed Undetermined"

python /projects/bgmp/jwel/bioinfo/QAA/scripts/plotReadLengths.py \
    -f1 /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz \
    -f2 /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz \
    -l "Trimmed 29_4E_fox"