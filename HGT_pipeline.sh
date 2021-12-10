#!/bin/bash

################################
### pipeline to identify HGTs ##
### example: Danio rerio(NCBI)##
################################

###  Directroy prepration
mkdir bmfish data src 

#####################################################################################
### step 1: split the genome and screen short segments based on k-mer frequencies ###
#####################################################################################
# fragment length: 1kbp; overlap 200bp
# reference genome: 

cd bmfish
mkdir segments new_blast_result

bash run.sh

###################################################################
### step 2: divide the nt database into DRG and CRG subdatabase ###
###################################################################
## CRG
# get the gilist of the CRG (close related group): for Danio rerio we choose  as the close related group
mkdir gilist 
cd gilist
# using the taxonkik(http://github.com/shenwei356/taxonkit/releases/download/v0.6.0/taxonkit_linux_amd64.tar.gz) and csvtk(http://github.com/shenwei356/csvtk/releases/download/v0.20.0/csvtk_linux_amd64.tar.gz) tools to get the CRG gilist
./taxonkit list -j 2 --ids 7898 --indent "" --data-dir /share/data/db/taxonomy/ > ray_finned_fish.list
cat /share/data/db/taxonomy/nucl_gb.accession2taxid | ./csvtk -t grep -f taxid -P ray_finned_fish.list | ./csvtk -t cut -f accession.version > ray_finned_fish.taxid.acc.txt
./taxonkit list -j 2 --ids 7952 --indent "" --data-dir /share/data/db/taxonomy/ > craps.list
cat /share/data/db/taxonomy/nucl_gb.accession2taxid | ./csvtk -t grep -f taxid -P craps.list | ./csvtk -t cut -f accession.version > craps.taxid.acc.txt
# using blastdb_aliastool to get the sub nt database of CRG(nt_fish_rmcraps, Ray finned fish without craps)
cat craps.taxid.acc.txt ray_fin dned_fish.taxid.acc.txt | sort | uniq -u > fish_remove_craps.taxid.acc.txt
blastdb_aliastool -seqidlist fish_remove_craps.taxid.acc.txt -db /share/data/db/nt/nt -dbtype nucl  -out nt_fish_rmcraps -title nt_fish_rmcraps

## DRG
# using the ncbi taxonomy division.dmp information, we divide the nt database into 9 subdatabase:
### Bacteria : nt_Bac
### Vertebrates : nt_Vert
### Invertebrates : nt_Invert
### Mammals : nt_Mammal
### Phages : nt_Phage
### Plants and Fungi : nt_Plant_fungi
### Primates : nt_Primates
### Rodents : nt_Rodents
### Viruses : nt_Virus

# for  Danio rerio, we need remove ray_finned_fish from Vertebrates as one DRG
./taxonkit list -j 2 --ids 7742 --indent "" --data-dir /share/data/db/taxonomy/ > Vert.list
cat /share/data/db/taxonomy/nucl_gb.accession2taxid | ./csvtk -t grep -f taxid -P Vert.list | ./csvtk -t cut -f accession.version > Vert.taxid.acc.txt
cat Vert.taxid.acc.txt ray_finned_fish.taxid.acc.txt | sort | uniq -u > Vert_remove_fish.taxid.acc.txt
blastdb_aliastool -seqidlist Vert_remove_fish.taxid.acc.txt -db /share/data/db/nt/nt -dbtype nucl  -out nt_Vert_rmfish -title nt_Vert_rmfish

###############################################
### step 3: screen  potential HGT sequences ###
###############################################

## find the potential HGT from Vertebrates and Invertebrates (It could be applies to other specie groups in the same way) 
cd bmfish/new_blast_result/
# using blast for alignment
blastn -query screen.fa -db ~/fish_hgt/gilist/nt_fish_rmcraps -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_fish_rmcraps.out 
blastn -query screen.fa -db ~/fish_hgt/gilist/nt_Vert_rmfish -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_Vert_rmfish.out 
blastn -query screen.fa -db ~/data/nt_Invert -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_Invert.out 
blastn -query screen.fa -db ~/data/nt_Mammal -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_Mammal.out 
blastn -query screen.fa -db ~/data/nt_Rodents -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_Rodents.out 
blastn -query screen.fa -db ~/data/nt_Primates -evalue 1e-5 -max_target_seqs 5 -outfmt 6 -out blast_result_Primates.out 
# screen the sequences with length > 200, identity > 70%.
bash screen_len200_iden70.sh 
#find the sequences in DRG but not in CRG
cat Mammal_iden70_len200.out Primates_iden70_len200.out Rodents_iden70_len200.out Vert_iden70_len200.out > Vert_iden70_len200.out
bash making_the_tree_level1.sh Vert
bash making_the_tree_level1.sh Invert
#screen the sequences aligned to at least two DRG seuqences 
bash find_more_reliable.sh Vert
bash find_more_reliable.sh Invert
# conjoin the sequence segments, remove redundant sequences, and remove 50% repeat sequences (trf) to get final HGT sequences. (details see cluster_overlap_pipeline.sh)
bash cluter_overlap_pipeline.sh 
