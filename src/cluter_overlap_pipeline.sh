#!/bin/bash
module load cd-hit/4.8.1
module load BLAST+/2.10.1


    cd ~/bmfish/new_blast_result/
    #find more reliable   
    mkdir conjoin_final
    cd conjoin_final
    cp ../non_redundant/Vert_much_nomasked_level1.fa ./Vert_much_level1.fa
    cp ../non_redundant/Invert_much_nomasked_level1.fa ./Invert_much_level1.fa
    #conjoin the seuquences f
    grep -oP "(?<=>).*" Vert_much_level1.fa | awk -F "-" '{print $1"-"$2"-"$3"\t"$4"\t"$5}' > Vert_level1.bed
    awk -F "-" '{print $1"\t"$2"\t"$3}' Vert_level1.bed | sort -k1,1 -k2n,2 | awk '{print $1"\t"$2+$4-1"\t"$2+$5-1}' > Vert_top_level1_seq_merge.bed
    python ~/src/merge.py Vert_top_level1_seq_merge.bed > Vert_top_level1_merged_seq.bed
    chomp.pl ~/data/bmfish.fa
    perl ~/src/getHGTseq.pl ~/data/bmfish.fa Vert_top_level1_merged_seq.bed  Vert_much_nomasked_level1.fa
    
    grep -oP "(?<=>).*" Invert_much_level1.fa | awk -F "-" '{print $1"-"$2"-"$3"\t"$4"\t"$5}' > Invert_level1.bed
    awk -F "-" '{print $1"\t"$2"\t"$3}' Invert_level1.bed | sort -k1,1 -k2n,2 | awk '{print $1"\t"$2+$4-1"\t"$2+$5-1}' > Invert_top_level1_seq_merge.bed
    python ~/src/merge.py Invert_top_level1_seq_merge.bed > Invert_top_level1_merged_seq.bed
    perl ~/src/getHGTseq.pl ~/data/bmfish.fa Invert_top_level1_merged_seq.bed  Invert_much_nomasked_level1.fa
    #redundant seqs cluster
    cd-hit-est -i Invert_much_nomasked_level1.fa -o Invert_much_nomasked_level1_cluster.fa -c 0.8
    cd-hit-est -i Vert_much_nomasked_level1.fa -o Vert_much_nomasked_level1_cluster.fa -c 0.8
    #remove 50% trf repeats
    mkdir trf_repeat_mask
    cd trf_repeat_mask
    trf ../Vert_much_nomasked_level1_cluster.fa 2 7 7 80 10 50 500 -m
    trf ../Invert_much_nomasked_level1_cluster.fa 2 7 7 80 10 50 500 -m
    rm *.html
    perl ~/src/chomp.pl Vert_much_nomasked_level1_cluster.fa.2.7.7.80.10.50.500.mask
    perl ~/src/chomp.pl Invert_much_nomasked_level1_cluster.fa.2.7.7.80.10.50.500.mask

    python3 ~/src/remove_masked.py Vert_much_nomasked_level1_cluster.fa.2.7.7.80.10.50.500.mask 0.5 > Vert_much_masked_50per_level1.fa
    python3 ~/src/remove_masked.py Invert_much_nomasked_level1_cluster.fa.2.7.7.80.10.50.500.mask 0.5 > Invert_much_masked_50per_level1.fa
    
    grep ">" Vert_much_masked_50per_level1.fa > tmp.txt
    for accession in `cat tmp.txt`
    do
      grep -m 1 -A 1 $accession ../Vert_much_nomasked_level1_cluster.fa >> ../Vert_much_remove50masekd_nomasked_level1_cluster.fa
    done
    
    grep ">" Invert_much_masked_50per_level1.fa > tmp.txt
    for accession in `cat tmp.txt`
    do
      grep -m 1 -A 1 $accession ../Invert_much_nomasked_level1_cluster.fa >> ../Invert_much_remove50masekd_nomasked_level1_cluster.fa
    done
    
    rm tmp.txt
     

 
