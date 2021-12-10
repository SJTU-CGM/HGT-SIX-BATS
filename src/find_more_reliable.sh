#!/bin/bash

cd ~/fish_hgt/bmfish/new_blast_result/
#find more reliable
mkdir non_redundant
cp $1_all_level1.out ./non_redundant/
cd non_redundant
cat $1_all_level1.out | awk '{print $1}' | uniq > tmp.txt
for accession in `cat tmp.txt`
do
  origin_num=`grep $accession $1_all_level1.out | awk '{print $2}' | uniq | wc -l`
  if [ $origin_num != 1 ]
  then
  grep -m 1 $accession $1_all_level1.out >> $1_much_origin_1.out
  else
  grep -m 1 $accession $1_all_level1.out >> $1_one_origin_1.out
  fi
done

cat $1_much_origin_1.out | awk '{print $1}' | uniq > tmp.txt
for accession in `cat tmp.txt`
do
  grep -m 1 -A 1 $accession ../$1_level1.fa >> $1_much_nomasked_level1.fa
done    