#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=fastqc
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/fastqc_trim_%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/fastqc_trim_%j.txt 

conda activate QAA

/usr/bin/time -v fastqc \
    -o /projects/bgmp/jwel/bioinfo/QAA/data/fastqc/trim \
    /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz \
    /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz

/usr/bin/time -v fastqc \
    -o /projects/bgmp/jwel/bioinfo/QAA/data/fastqc/trim \
    /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz \
    /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz