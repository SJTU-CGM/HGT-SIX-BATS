#!/bin/bash

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Mammal.out > Mammal_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Primates.out > Primates_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Invert.out > Invert_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Rodents.out > Rodents_iden70_len200.out

#awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Bac.out > Bac_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Vert_rmfish.out > Vert_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Virus.out > Virus_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Plant_fugi.out > Phage_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_fish_rmcraps.out > fish_rmcraps_iden70_len200.out

awk '{if ($3>70 && $4 > 200) {print $0}}' blast_result_Phage.out > Phage_iden70_len200.out