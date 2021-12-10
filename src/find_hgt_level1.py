#%% import packages
import pandas as pd
import numpy as np
from sys import argv
#%% read_data
if not len(argv) == 4:
    print("Argument Error:\n find_hgt.py [close_blast.out] [far_blast.out] [output:hgt_level1.out]")
    exit(1)

df_close = pd.read_table(argv[1],sep = "\t",header=None)
df_far = pd.read_table(argv[2],sep = "\t",header=None) 
 
# %%  get the difference list and intersection list of two accessions.
accession_close = df_close.iloc[:,0:1][0].values.tolist()
accession_far = df_far.iloc[:,0:1][0].values.tolist()
intersection_accession = list(set(accession_far).intersection(set(accession_close)))
hgt_accession_level1 = list(set(accession_far).difference(set(accession_close)))
# %%save the level1 hgt out , level1: in the far group and not in the close group 
df_far.index = accession_far
df_close.index = accession_close
df_far.loc[hgt_accession_level1].to_csv(argv[3],sep = "\t",index = False,header=None)