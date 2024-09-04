#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=python
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=logs/fastqIDE_%j.txt
#SBATCH --output=logs/fastqIDE_%j.txt 

conda activate QAA

/usr/bin/time -v python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r "1" -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/Undetermined_S0_L008_R1_001.fastq.gz
/usr/bin/time -v python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r "4" -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/Undetermined_S0_L008_R2_001.fastq.gz


/usr/bin/time -v python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r "1" -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz
/usr/bin/time -v python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r "4" -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz