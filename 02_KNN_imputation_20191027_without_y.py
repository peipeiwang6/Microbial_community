import sys,os
sys.path.append('/mnt/home/peipeiw/Documents/Genome_selection/Genotype_matrix/Script_Christina/impute_KNN/Imputer.py/imputer/')
from imputer import Imputer
import pandas as pd
from copy import deepcopy
import numpy as np
impute = Imputer()
file = sys.argv[1]
df = pd.read_csv(file, sep='\t', index_col = 0, header = 0,low_memory=False)
#df_filted = df.loc[df.count(1) > df.shape[1]/2, df.count(0) > df.shape[0]/2]
df_filted = df.iloc[:,1:]
colname = df_filted.columns.tolist()
df1 = deepcopy(df_filted)
df2 = deepcopy(df_filted)
df3 = deepcopy(df_filted)
df4 = deepcopy(df_filted)	
df5 = deepcopy(df_filted)	
for col in colname:
	df1 = pd.DataFrame(impute.knn(X=df1, column=col, k=3),index=df_filted.index, columns = df_filted.columns)
	df2 = pd.DataFrame(impute.knn(X=df2, column=col, k=4),index=df_filted.index, columns = df_filted.columns)
	df3 = pd.DataFrame(impute.knn(X=df3, column=col, k=5),index=df_filted.index, columns = df_filted.columns)
	df4 = pd.DataFrame(impute.knn(X=df4, column=col, k=6),index=df_filted.index, columns = df_filted.columns)
	df5 = pd.DataFrame(impute.knn(X=df5, column=col, k=7),index=df_filted.index, columns = df_filted.columns)

res = (df1+df2+df3+df4+df5)/5
res.insert(0,"Y",df['Y'],True)
res.to_csv(sys.argv[1].split('.txt')[0]+'_KNN_impute.txt', index=True, header=True,sep="\t")
