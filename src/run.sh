#!/bin/bash
../src/make_segment_kmer ../data/bmfish.fa
perl ../src/compareKmer.pl segment/genome_kmer.txt segment/segments_kmer_freq.txt segment/genome_segment_distance.txt

num=$(grep -v region segment/genome_segment_distance.txt |wc -l)
top=`expr $num / 5` # only top 1% kept
grep -v region segment/genome_segment_distance.txt |sort -rnk 2 |head -$top |awk '{print $1}' > segment/genome_segment_distance_pass.info

awk -F '-' '{print $1"\t"$2"\t"$3}' segment/genome_segment_distance_pass.info |sort -k1,1 -k2n,2 > segment/genome_segment_distance_pass.bed
cat segment/genome_segment_distance_pass.bed | grep -oP "(?<=>).*" > segment/genome_segment_distance_pass_change.bed
perl ../src/getHGTseq.pl segment/chomped_scaf.fna segment/genome_segment_distance_pass_change.bed segment/screen.fa
