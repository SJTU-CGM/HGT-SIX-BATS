# HGT-SIX-BATS
Horizontal gene transfer of six high quality bats genomes.

Here we use the pipeline for one example (Danio rerio) to find the reliable HGTs.

This pipeline could be applied to ANY OTHER SPECEIS.

####################################################
### Identification of HGTs in any specie genomes ###
###         Example: Danio rerio                 ###
####################################################

### System requirements:
    (1) Linux operation system, memory 4GB or up
    (2) Perl 5.8.5, Python 3.8 or up
    (3) Software needed: BLAST (2.10.1), Tandom repeat finder (4.10.0), cd-hit-est (4.6),  etc.
    (4) Codes required:
    	A. analysis pipeline: HGT_pipeline.sh
	B. source code: all files in src/ 

### Installation guide:
    Obtain the analysis pipeline (HGT_pipeline.sh) and all files in src/

### Demo: Identify HGTs in fish genome, the above pipeline is an example
    (1) Datasets needed:
        A. genomes/: eukaryotic genomes
    	B. data/: Danio_rerio.fa(NCBI) reference genome
      C. nt (Nucleotide Collection, June 18th, 2020 edition) database 
    (2) Intermediate results:
    	A. segment/: short fragments

### Instructions for use:
    Prepare required datasets and code files, and keep them in right directories like that in demo.
    Then, follow the pipeline step by step

### Tips:
    Only pipeline and source code are displayed here.
    To get more detailed datasets and intermediate results, please visit this site: http://cgm.sjtu.edu.cn/
