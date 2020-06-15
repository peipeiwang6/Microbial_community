import sys,os
feature = open('metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017_locations.txt','r').readlines()
F = {}
Location = {}
for inl in feature[1:]:
	tem = inl.strip().split()
	if tem[3] == 'Fert':
		F[tem[0]] = '1\t' + '\t'.join(tem[6:86])
	if tem[3] == 'Unfert':
		F[tem[0]] = '0\t' + '\t'.join(tem[6:86])
	Location[tem[0]] = [tem[2],tem[3],tem[86],tem[87],tem[88]]

diversity = open('Rarefied_diversity_MMPRNT_G5_LC_LUX_016017.txt','r').readlines()
D = {}
for inl in diversity[1:]:
	tem = inl.strip().split('\t')
	D[tem[0]] = tem[1:]
	
out = open('Matrix_full_Richness.txt','w')
title = 'sampleID\tY\tFertstat\t'+ '\t'.join(feature[0].split()[6:86])
out.write(title + '\n')
for id in D:
		out.write('%s\t%s\t%s\n'%(id,D[id][0],F[id]))
		
out.close()

out = open('Matrix_full_InvSimpson.txt','w')
title = 'sampleID\tY\tFertstat\t'+ '\t'.join(feature[0].split()[6:86])
out.write(title + '\n')
for id in D:
		out.write('%s\t%s\t%s\n'%(id,D[id][1],F[id]))
		
out.close()

out = open('Matrix_full_Evenness.txt','w')
title = 'sampleID\tY\tFertstat\t'+ '\t'.join(feature[0].split()[6:86])
out.write(title + '\n')
for id in D:
		out.write('%s\t%s\t%s\n'%(id,D[id][2],F[id]))
		
out.close()




