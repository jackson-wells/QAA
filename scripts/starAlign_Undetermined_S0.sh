#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --job-name=star
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=/projects/bgmp/jwel/bioinfo/QAA/logs/starAlign_Undetermined_S0_%j.txt
#SBATCH --output=/projects/bgmp/jwel/bioinfo/QAA/logs/starAlign_Undetermined_S0_%j.txt 

conda activate QAA

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
--outFilterMultimapNmax 3 \
--outSAMunmapped Within KeepPairs \
--alignIntronMax 1000000 --alignMatesGapMax 1000000 \
--readFilesCommand zcat \
--readFilesIn /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz  \
--genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome \
--outFileNamePrefix /projects/bgmp/jwel/bioinfo/QAA/data/star/Undetermined_S0
