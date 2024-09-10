
### Reflections
- Include a `>` when running htseq-count so that outputs don't have to be copy pasted to new files
- Fully read assignment prompt before beginning (so you don't run everyones files through FastQC)
- Consider R for future plots to avoid digging through python plotting documentation
- Continue writing process steps as done with this assignment

### Process

1. Reviewed the github and what needs doing. Already familiar with cutadapt and trimmomatic so likely will not have to look through too much of the documentation
2. New repo created, symbolic linked input directory and file
	`ln -s /projects/bgmp/shared/2017_sequencing/demultiplexed/ demux/`
	`ln -s /projects/bgmp/shared/Bi623/QAA_data_assignments.txt libraryAssingments.txt`
1. Created new conda environment
	`mamba create -n QAA fastqc=0.12.1 cutadapt=4.9 trimmmomatic=0.39`
4. Creating script to run fastqc
	`ls  -1 ./demux/* > runFastqc.sh`
		this was done to fast track adding file locations to the file, used vscode regex to move r2 files onto the same line
5. Creating script to run demux plotting code
6. Was made aware that I only had to run 4 fastq files, I ran all of them, whoops. Forget step 4 and step 5 lol Now reading the library assignments text file
7. running python script from demux part 1, forgot to rename output files, doing so manually as the sbatch script runs
8. Plots look very similar minus coloring and stylistic differences, need to re-run fastQC to time how long it takes to process the files 
9. FastQC runs much quicker than my code, big surprise
10. Updated personal code a bit to not use R1/2/3/4 as output plot file names
11. Running cutadapt now, using vignette command and supplied adapter sequences, first run appears good. remembered to add timing command 
12. cutadapt ran error free, creating trimmomatic script, referencing previous jobs Snakemake file
13. Running trimmomatic, 8 thread, phred33. created output directories for paired and unpaired files. 
14. Runs appear successful, preparing fastQC trim run script
15. Adding multiQC to conda environment just because
	`mamba install multiqc`
	`multiqc -o data/fastqc/trim data/fastqc/trim/*`
16. trimming looks good, skipping python code checking, moving onto STAR alignment 
	`mamba install star numpy htseq` (matplotlib installed to run python demux code (step 7))
17. Found latest mouse assembly files, checking with Leslie that these are correct and that we do not want masked assembly files. Copied down starGenerate and starAlign run scripts from Bi621/PS8
18. Running starGenerate, 2 failed runs due to compressed input files 
19. Running starAlign, no failed runs
20. Ran PS8 code on the output .sam files, updated the code to use argparse
	`python scripts/countMapped.py -f ./data/star/29_4E_fox_S21Aligned.out.sam > S29_4E_fox_S21.txt`
		Mapped: 9,327,578
		Unmapped: 271,016
	`python scripts/countMapped.py -f ./data/star/Undetermined_S0Aligned.out.sam > Undetermined_S0.txt`
		Mapped: 16,356,244
		Unmapped: 8,832,478
21. wrote script to run htseq-count, wrote all output to single log file (mistake), copy pasted needed outputs to their own files and calculated statistics
	`grep -v '^_' data/htseq/29_4E_fox_s21_fw.genecount | awk '{temp+=$2} END {print temp}'`
		179,976
	`grep -v '^_' data/htseq/29_4E_fox_s21_rv.genecount | awk '{temp+=$2} END {print temp}`
		3,859,630
	`grep -v '^_' data/htseq/Undetermined_S0_fw.genecount | awk '{temp+=$2} END {print temp}`
		292,237
	`grep -v '^_' data/htseq/Undetermined_S0_rv.genecount | awk '{temp+=$2} END {print temp}`
		6,616,501
 22. Read mapping counts don't seem to be lining up. Figured out I had used an old version of my code
 23. Wrote out a pair histogram plotting program based upon ICA3's histogram code which I liked the binning strategy of.
 24. Identified a better way to figure out where adapter sequences were 
 25. Writing out answers 
 
### Conda Environment(s) Utilized

[QAA.yml](environments/QAA.yml)
	Key Software Versions:
	- Cutadapt: 4.9
	- Trimmomatic: 0.39
	- FastQC: 0.12.1
	- MultiQC: 1.24.1
	- STAR: 2.7.11b
	- Matplotlib: 3.9.2
	- Htseq: 2.0.5
	- Numpy: 1.26.4

### Scripts Utilized
#### Python
[fastqIDE.py](scripts/fastqIDE.py)
- Takes in a compressed FastQ file and plots the average per base quality score

[countMapped.py](scripts/countMapped.py)
- Takes in a sam file and counts the occurrences of mapped and umapped reads

[plotReadLengths.py](scripts/plotReadLengths.py)
- Takes in two compressed FastQ files and plots a distribution of their read lengths 

#### Bash
[runFastqcRaw.sh](scripts/runFastqcRaw.sh)
- Executes slurm job to run FastQC on samples. 
- Outputs to `data/fastqc/raw`

[runFastqcTrim.sh](scripts/runFastqcTrim.sh)
- Executes slurm job to run FastQC on samples. 
- Outputs to `data/fastqc/trim`

[runFastqIDE.sh](scripts/runFastqIDE.sh)
- Executes slurm job to plot average per base quality score. 
- Outputs to `data/fasatqIDE`

[runCutadapt.sh](scripts/runCutadapt.sh)
- Executes slurm job to run both libraries through cutadapt. 
- Outputs to `data/cutadapt`

[runTrimmomatic.sh](scripts/runTrimmomatic.sh)
- Executes slurm job to run both libraries through trimmomatic. 
- Outputs to `data/trim/paired` & `data/trim/unpaired`

[runLengthPlots.sh](scripts/runLengthPlots.sh)
- Executes slurm job to run both libraries through plotReadLengths.py. 
- Outputs to `data/readLengths`

[starGenerate_QAA.sh](scripts/starGenerate_QAA.sh)
- Executes slurm job to run STAR generate to create areference assmebly of Mouse genome
- Outputs to `data/star/genome`

[starAlign_29_4E_fox_S21.sh](scripts/starAlign_29_4E_fox_S21.sh)
- Executes slurm job to run STAR align on the 29_4E_fox library.
- Outputs to `data/star`

[starAlign_Undetermined_S0.sh](scripts/starAlign_Undetermined_S0.sh)
- Executes slurm job to run STAR align on the Undetermined library.
- Outputs to `data/star`

[htseq_29_4E_fox_S21.sh](scripts/htseq_29_4E_fox_S21.sh)
- Executes slurm job to run htseq-count with `stranded=yes` & `stranded=reverse` flags on the 29_4E_fox library
- Outputs to `logs/`

[htseq_Undetermined_S0.sh](scripts/htseq_Undetermined_S0.sh)
- Executes slurm job to run htseq-count with `stranded=yes` & `stranded=reverse` flags on the Undetermined library
- Outputs to `logs/`

### Useful Unix Commands Utilized
`zcat <file> | grep '<adapter sequence>' | wc -l`
- This command outputs the count of sequences that contain the adapter sequence.

`zcat <file> | awk -v s="<adapter sequence>" 'i=index($0, s) {print i}' | awk '{position+=$0} END {print position/NR}'`
- This command outputs the average position of the adapter sequence in the input fastQ file. Awk is first used to identify the position where the adapter appears in each read. This is then piped to another awk that provides an average of the supplied positions.

`multiqc data/fastqc/raw/*`
- This command creates a MultiQC report from the FastQC reports housed in the input directory 
### SLURM Run Summaries
#### FastQC Raw
##### 29_4E_fox

	Command being timed: "fastqc -o data/fastqc/raw ./data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz ./data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz"
	User time (seconds): 40.44
	System time (seconds): 1.86
	Percent of CPU this job got: 89%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:47.02
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 204036
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 73231
	Voluntary context switches: 5361
	Involuntary context switches: 1600
	Swaps: 0
	File system inputs: 0
	File system outputs: 4576
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

##### Undetermined

	Command being timed: "fastqc -o data/fastqc/raw ./data/demux/Undetermined_S0_L008_R1_001.fastq.gz ./data/demux/Undetermined_S0_L008_R2_001.fastq.gz"
		User time (seconds): 119.21
		System time (seconds): 5.71
		Percent of CPU this job got: 98%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 2:06.80
		Average shared text size (kbytes): 0
		Average unshared data size (kbytes): 0
		Average stack size (kbytes): 0
		Average total size (kbytes): 0
		Maximum resident set size (kbytes): 198752
		Average resident set size (kbytes): 0
		Major (requiring I/O) page faults: 0
		Minor (reclaiming a frame) page faults: 82048
		Voluntary context switches: 10955
		Involuntary context switches: 3845
		Swaps: 0
		File system inputs: 0
		File system outputs: 5024
		Socket messages sent: 0
		Socket messages received: 0
		Signals delivered: 0
		Page size (bytes): 4096
		Exit status: 0

#### FastqIDE
##### 29_4E_fox R1
	Command being timed: "python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r 1 -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz"
		User time (seconds): 122.03
		System time (seconds): 0.10
		Percent of CPU this job got: 99%
		Elapsed (wall clock) time (h:mm:ss or m:ss): 2:02.44
		Average shared text size (kbytes): 0
		Average unshared data size (kbytes): 0
		Average stack size (kbytes): 0
		Average total size (kbytes): 0
		Maximum resident set size (kbytes): 62408
		Average resident set size (kbytes): 0
		Major (requiring I/O) page faults: 0
		Minor (reclaiming a frame) page faults: 13697
		Voluntary context switches: 75
		Involuntary context switches: 312
		Swaps: 0
		File system inputs: 0
		File system outputs: 0
		Socket messages sent: 0
		Socket messages received: 0
		Signals delivered: 0
		Page size (bytes): 4096
		Exit status: 0
##### 29_4E_fox R2
	Command being timed: "python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r 4 -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz"
	User time (seconds): 114.46
	System time (seconds): 0.11
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:54.84
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 61576
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 13972
	Voluntary context switches: 72
	Involuntary context switches: 306
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined R1
	Command being timed: "python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r 1 -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/Undetermined_S0_L008_R1_001.fastq.gz"
	User time (seconds): 357.58
	System time (seconds): 0.21
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:59.50
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 63596
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 13965
	Voluntary context switches: 281
	Involuntary context switches: 900
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined R2
	Command being timed: "python /projects/bgmp/jwel/bioinfo/QAA/scripts/fastqIDE.py -r 4 -f /projects/bgmp/jwel/bioinfo/QAA/data/demux/Undetermined_S0_L008_R2_001.fastq.gz"
	User time (seconds): 355.73
	System time (seconds): 0.21
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:56.73
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 63572
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 13488
	Voluntary context switches: 80
	Involuntary context switches: 896
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
#### Cutadapt
##### 29_4E_fox R1
	This is cutadapt 4.9 with Python 3.12.5
	Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz
	Processing single-end reads on 1 core ...
	Finished in 34.675 s (7.183 µs/read; 8.35 M reads/minute).
	
	=== Summary ===
	
	Total reads processed:               4,827,433
	Reads with adapters:                   361,886 (7.5%)
	Reads written (passing filters):     4,827,433 (100.0%)
	
	Total basepairs processed:   487,570,733 bp
	Total written (filtered):    482,046,570 bp (98.9%)
	
	.......
	
	Command being timed: "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R1_001.fastq.gz"
	User time (seconds): 34.54
	System time (seconds): 0.08
	Percent of CPU this job got: 92%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:37.51
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 28904
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 6199
	Voluntary context switches: 946
	Involuntary context switches: 128
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### 29_4E_fox R2
	This is cutadapt 4.9 with Python 3.12.5
	Command line parameters: -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz
	Processing single-end reads on 1 core ...
	Finished in 35.331 s (7.319 µs/read; 8.20 M reads/minute).
	
	=== Summary ===
	
	Total reads processed:               4,827,433
	Reads with adapters:                   400,819 (8.3%)
	Reads written (passing filters):     4,827,433 (100.0%)
	
	Total basepairs processed:   487,570,733 bp
	Total written (filtered):    481,884,323 bp (98.8%)
	
	.......

	Command being timed: "cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz ./data/demux/29_4E_fox_S21_L008_R2_001.fastq.gz"
	User time (seconds): 35.19
	System time (seconds): 0.07
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:35.42
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 28824
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 5692
	Voluntary context switches: 301
	Involuntary context switches: 110
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined R1
	This is cutadapt 4.9 with Python 3.12.5
	Command line parameters: -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R1_001.fastq.gz
	Processing single-end reads on 1 core ...
	Finished in 109.623 s (7.427 µs/read; 8.08 M reads/minute).
	
	=== Summary ===
	
	Total reads processed:              14,760,166
	Reads with adapters:                   543,021 (3.7%)
	Reads written (passing filters):    14,760,166 (100.0%)
	
	Total basepairs processed: 1,490,776,766 bp
	Total written (filtered):  1,484,746,362 bp (99.6%)
	
	........

	Command being timed: "cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -o data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R1_001.fastq.gz"
	User time (seconds): 108.66
	System time (seconds): 0.19
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:49.71
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 28792
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 6209
	Voluntary context switches: 480
	Involuntary context switches: 357
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined R2
	This is cutadapt 4.9 with Python 3.12.5
	Command line parameters: -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R2_001.fastq.gz
	Processing single-end reads on 1 core ...
	Finished in 112.329 s (7.610 µs/read; 7.88 M reads/minute).
	
	=== Summary ===
	
	Total reads processed:              14,760,166
	Reads with adapters:                   607,660 (4.1%)
	Reads written (passing filters):    14,760,166 (100.0%)
	
	Total basepairs processed: 1,490,776,766 bp
	Total written (filtered):  1,484,134,519 bp (99.6%)
	
	.........

	Command being timed: "cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -o data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz ./data/demux/Undetermined_S0_L008_R2_001.fastq.gz"
	User time (seconds): 111.70
	System time (seconds): 0.20
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:52.42
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 28912
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 6209
	Voluntary context switches: 490
	Involuntary context switches: 428
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

#### Trimmomatic
##### 29_4E_fox
	TrimmomaticPE: Started with arguments:
	 -phred33 -threads 8 /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R1_001.cut.unpaired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R2_001.cut.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
	Input Read Pairs: 4827433 Both Surviving: 4571904 (94.71%) Forward Only Surviving: 247896 (5.14%) Reverse Only Surviving: 3367 (0.07%) Dropped: 4266 (0.09%)
	TrimmomaticPE: Completed successfully

	.......

	Command being timed: "trimmomatic PE -phred33 -threads 8 /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R1_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/29_4E_fox_S21_L008_R2_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R1_001.cut.unpaired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/29_4E_fox_S21_L008_R2_001.cut.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
	User time (seconds): 238.21
	System time (seconds): 5.65
	Percent of CPU this job got: 213%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:54.17
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 428808
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 42096
	Voluntary context switches: 54307
	Involuntary context switches: 2002
	Swaps: 0
	File system inputs: 0
	File system outputs: 768
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined
	TrimmomaticPE: Started with arguments:
	 -phred33 -threads 8 /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R1_001.cut.unpaired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R2_001.cut.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
	Input Read Pairs: 14760166 Both Surviving: 12160071 (82.38%) Forward Only Surviving: 2511252 (17.01%) Reverse Only Surviving: 31174 (0.21%) Dropped: 57669 (0.39%)
	TrimmomaticPE: Completed successfully
	
	..........

	Command being timed: "trimmomatic PE -phred33 -threads 8 /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R1_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/cutadapt/Undetermined_S0_L008_R2_001.cut.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R1_001.cut.unpaired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/unpaired/Undetermined_S0_L008_R2_001.cut.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35"
	User time (seconds): 720.96
	System time (seconds): 18.16
	Percent of CPU this job got: 242%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 5:04.68
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 415860
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 55364
	Voluntary context switches: 152235
	Involuntary context switches: 2314
	Swaps: 0
	File system inputs: 0
	File system outputs: 1952
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

#### FastQC Trimmed
##### 29_4E_fox
	Command being timed: "fastqc -o /projects/bgmp/jwel/bioinfo/QAA/data/fastqc/trim /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz"
	User time (seconds): 62.53
	System time (seconds): 2.48
	Percent of CPU this job got: 97%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 1:06.63
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 197196
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 77718
	Voluntary context switches: 5183
	Involuntary context switches: 2640
	Swaps: 0
	File system inputs: 0
	File system outputs: 4848
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined
	Command being timed: "fastqc -o /projects/bgmp/jwel/bioinfo/QAA/data/fastqc/trim /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz"
	User time (seconds): 165.06
	System time (seconds): 6.87
	Percent of CPU this job got: 98%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 2:53.89
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 189064
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 87186
	Voluntary context switches: 11044
	Involuntary context switches: 5347
	Swaps: 0
	File system inputs: 0
	File system outputs: 5544
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
#### Star Generate
	/projects/bgmp/jwel/miniforge3/envs/QAA/bin/STAR-avx2 --runThreadN 8 --runMode genomeGenerate --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --genomeFastaFiles /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.dna.primary_assembly.fa --sjdbGTFfile /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf
	STAR version: 2.7.11b   compiled: 2024-07-03T14:39:20+0000 :/opt/conda/conda-bld/star_1720017372352/work/source
	Sep 04 12:14:35 ..... started STAR run
	Sep 04 12:14:35 ... starting to generate Genome files
	Sep 04 12:15:09 ..... processing annotations GTF
	Sep 04 12:15:21 ... starting to sort Suffix Array. This may take a long time...
	Sep 04 12:15:33 ... sorting Suffix Array chunks and saving them to disk...
	Sep 04 12:24:25 ... loading chunks from disk, packing SA...
	Sep 04 12:25:20 ... finished generating suffix array
	Sep 04 12:25:20 ... generating Suffix Array index
	Sep 04 12:28:03 ... completed Suffix Array index
	Sep 04 12:28:03 ..... inserting junctions into the genome indices
	Sep 04 12:30:15 ... writing Genome to disk ...
	Sep 04 12:30:15 ... writing Suffix Array to disk ...
	Sep 04 12:30:24 ... writing SAindex to disk
	Sep 04 12:30:25 ..... finished successfully

	.........

	Command being timed: "STAR --runThreadN 8 --runMode genomeGenerate --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --genomeFastaFiles /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.dna.primary_assembly.fa --sjdbGTFfile /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 4676.61
	System time (seconds): 44.46
	Percent of CPU this job got: 496%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 15:50.04
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 32375840
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 20567839
	Voluntary context switches: 18488
	Involuntary context switches: 9354
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
#### Star Align
##### 29_4E_fox
	/projects/bgmp/jwel/miniforge3/envs/QAA/bin/STAR-avx2 --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --outFileNamePrefix /projects/bgmp/jwel/bioinfo/QAA/data/star/29_4E_fox_S21
	STAR version: 2.7.11b   compiled: 2024-07-03T14:39:20+0000 :/opt/conda/conda-bld/star_1720017372352/work/source
	Sep 04 13:03:00 ..... started STAR run
	Sep 04 13:03:00 ..... loading genome
	Sep 04 13:03:08 ..... started mapping
	Sep 04 13:03:48 ..... finished mapping
	Sep 04 13:03:48 ..... finished successfully

	........

	Command being timed: "STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/29_4E_fox_S21_L008_R2_001.cut.paired.fastq.gz --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --outFileNamePrefix /projects/bgmp/jwel/bioinfo/QAA/data/star/29_4E_fox_S21"
	User time (seconds): 251.15
	System time (seconds): 11.86
	Percent of CPU this job got: 543%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:48.35
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 27359208
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 1212803
	Voluntary context switches: 31920
	Involuntary context switches: 4217
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined
	/projects/bgmp/jwel/miniforge3/envs/QAA/bin/STAR-avx2 --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --outFileNamePrefix /projects/bgmp/jwel/bioinfo/QAA/data/star/Undetermined_S0
	STAR version: 2.7.11b   compiled: 2024-07-03T14:39:20+0000 :/opt/conda/conda-bld/star_1720017372352/work/source
	Sep 04 13:02:48 ..... started STAR run
	Sep 04 13:02:48 ..... loading genome
	Sep 04 13:03:01 ..... started mapping
	Sep 04 13:07:42 ..... finished mapping
	Sep 04 13:07:42 ..... finished successfully

	.........

	Command being timed: "STAR --runThreadN 8 --runMode alignReads --outFilterMultimapNmax 3 --outSAMunmapped Within KeepPairs --alignIntronMax 1000000 --alignMatesGapMax 1000000 --readFilesCommand zcat --readFilesIn /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R1_001.cut.paired.fastq.gz /projects/bgmp/jwel/bioinfo/QAA/data/trim/paired/Undetermined_S0_L008_R2_001.cut.paired.fastq.gz --genomeDir /projects/bgmp/jwel/bioinfo/QAA/data/star/genome --outFileNamePrefix /projects/bgmp/jwel/bioinfo/QAA/data/star/Undetermined_S0"
	User time (seconds): 2131.39
	System time (seconds): 11.15
	Percent of CPU this job got: 728%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 4:54.09
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 27401100
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 1144637
	Voluntary context switches: 81966
	Involuntary context switches: 8025
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
#### Htseq-Count 
##### 29_4E_fox
	Command being timed: "htseq-count --stranded=reverse /projects/bgmp/jwel/bioinfo/QAA/data/star/29_4E_fox_S21Aligned.out.sam /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 685.55
	System time (seconds): 2.06
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 11:30.39
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 251020
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 55529
	Voluntary context switches: 162
	Involuntary context switches: 2514
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
##### Undetermined
	Command being timed: "htseq-count --stranded=reverse /projects/bgmp/jwel/bioinfo/QAA/data/star/Undetermined_S0Aligned.out.sam /projects/bgmp/jwel/bioinfo/QAA/data/ref/Mus_musculus.GRCm39.112.gtf"
	User time (seconds): 1410.05
	System time (seconds): 3.64
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 23:38.97
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 258364
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 56132
	Voluntary context switches: 264
	Involuntary context switches: 3595
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0

