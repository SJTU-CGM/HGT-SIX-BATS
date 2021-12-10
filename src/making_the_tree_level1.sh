#!/bin/bash

python3 ~/HGT_bats/python_file/find_hgt_level1.py fish_rmcraps_iden70_len200.out $1_iden70_len200.out $1_all_level1.out


cat $1_all_level1.out | awk '{print $1}' | uniq > tmp.txt
for accession in `cat tmp.txt`
do
  grep -m 1 $accession $1_all_level1.out | awk '{if ($7 < $8) {print $1"\t"$7"\t"$8}else{print$1"\t"$8"\t"$7}}'>> $1_top_level1_seq.bed
done
  
  
perl ../../src/getHGTseq.pl screen.fa $1_top_level1_seq.bed $1_level1.fa
  
rm tmp.txt