#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=trimmomatic
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/trimmomatic_%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/trimmomatic_%j.txt 

conda activate QAA

/usr/bin/time -v trimmomatic PE -phred33 -threads 8 \
        /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R1_001.cut.unpaired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R2_001.cut.unpaired.fastq.gz \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35


/usr/bin/time -v trimmomatic PE -phred33 -threads 8 \
        /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R1_001.cut.unpaired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz \
        /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R2_001.cut.unpaired.fastq.gz \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35