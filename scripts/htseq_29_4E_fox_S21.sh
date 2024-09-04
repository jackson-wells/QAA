#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=htseq
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/htseq_29_4E_fox_S21_%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/htseq_29_4E_fox_S21_%j.txt 

conda activate QAA

/usr/bin/time -v htseq-count --stranded=yes \
    /projects/bgmp/jwel/bioinfo/QAA/data/star/29_4E_fox_S21Aligned.out.sam \
    /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf

/usr/bin/time -v htseq-count --stranded=reverse \
    /projects/bgmp/jwel/bioinfo/QAA/data/star/29_4E_fox_S21Aligned.out.sam \
    /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf