#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/star_generate%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/star_generate%j.txt 

conda activate QAA

/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
--genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome \
--genomeFastaFiles /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.dna.primary_assembly.fa \
--sjdbGTFfile /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf
