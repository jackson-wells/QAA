#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=cutadapt
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/cutadapt_%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/cutadapt_%j.txt 

conda activate QAA

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R1_001.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R2_001.fastq.gz