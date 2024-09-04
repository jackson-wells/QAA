#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=1
#SBATCH --job-name=fastqc
#SBATCH --nodes=1
#SBATCH --time=5-00:00:00
#SBATCH --error=logs/fastqc_raw_%j.txt
#SBATCH --output=logs/fastqc_raw_%j.txt 

conda activate QAA

# fastqc -o data/fastqc/raw ./data/demux/10_2G_both_S8_L008_R1_001.fastq.gz ./data/demux/10_2G_both_S8_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/11_2H_both_S9_L008_R1_001.fastq.gz ./data/demux/11_2H_both_S9_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/1_2A_control_S1_L008_R1_001.fastq.gz ./data/demux/1_2A_control_S1_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/14_3B_control_S10_L008_R1_001.fastq.gz ./data/demux/14_3B_control_S10_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/15_3C_mbnl_S11_L008_R1_001.fastq.gz ./data/demux/15_3C_mbnl_S11_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/16_3D_mbnl_S12_L008_R1_001.fastq.gz ./data/demux/16_3D_mbnl_S12_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/17_3E_fox_S13_L008_R1_001.fastq.gz ./data/demux/17_3E_fox_S13_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/19_3F_fox_S14_L008_R1_001.fastq.gz ./data/demux/19_3F_fox_S14_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/21_3G_both_S15_L008_R1_001.fastq.gz ./data/demux/21_3G_both_S15_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/22_3H_both_S16_L008_R1_001.fastq.gz ./data/demux/22_3H_both_S16_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/2_2B_control_S2_L008_R1_001.fastq.gz ./data/demux/2_2B_control_S2_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/23_4A_control_S17_L008_R1_001.fastq.gz ./data/demux/23_4A_control_S17_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/24_4A_control_S18_L008_R1_001.fastq.gz ./data/demux/24_4A_control_S18_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/27_4C_mbnl_S19_L008_R1_001.fastq.gz ./data/demux/27_4C_mbnl_S19_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/28_4D_mbnl_S20_L008_R1_001.fastq.gz ./data/demux/28_4D_mbnl_S20_L008_R2_001.fastq.gz
/usr/bin/time -v fastqc -o data/fastqc/raw ./data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz ./data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/31_4F_fox_S22_L008_R1_001.fastq.gz ./data/demux/31_4F_fox_S22_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/32_4G_both_S23_L008_R1_001.fastq.gz ./data/demux/32_4G_both_S23_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/3_2B_control_S3_L008_R1_001.fastq.gz ./data/demux/3_2B_control_S3_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/34_4H_both_S24_L008_R1_001.fastq.gz ./data/demux/34_4H_both_S24_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/4_2C_mbnl_S4_L008_R1_001.fastq.gz ./data/demux/4_2C_mbnl_S4_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/6_2D_mbnl_S5_L008_R1_001.fastq.gz ./data/demux/6_2D_mbnl_S5_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/7_2E_fox_S6_L008_R1_001.fastq.gz ./data/demux/7_2E_fox_S6_L008_R2_001.fastq.gz
# fastqc -o data/fastqc/raw ./data/demux/8_2F_fox_S7_L008_R1_001.fastq.gz ./data/demux/8_2F_fox_S7_L008_R2_001.fastq.gz
/usr/bin/time -v fastqc -o data/fastqc/raw ./data/demux/Undetermined_S0_L008_R1_001.fastq.gz ./data/demux/Undetermined_S0_L008_R2_001.fastq.gz