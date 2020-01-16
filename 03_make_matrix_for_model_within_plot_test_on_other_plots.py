import sys,os
import numpy as np
import random
feature = open('metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017_locations.txt','r').readlines()
Location = {}
for inl in feature[1:]:
	tem = inl.strip().split()
	Location[tem[0]] = [tem[2],tem[3],tem[66],tem[67],tem[68]]

inp = open(sys.argv[1],'r').readlines()
type = sys.argv[2] # 'city','plot'
train = sys.argv[3].split(',')
os.system('cp %s %s'%(sys.argv[1], sys.argv[1].split('.txt')[0] + '_%s_%s_test_on_others.txt'%(type,'_'.join(train))))
out = open(sys.argv[1].split('.txt')[0] + '_%s_%s_test_on_others_test.txt'%(type,'_'.join(train)),'w')
if type == 'plot':
	Train = []
	train_plot = train[0]
	city = train_plot.split('_')[0]
	output = open(sys.argv[1].split('.txt')[0] + '_%s_%s_test_on_others.txt'%(type,'_'.join(train)),'w')
	output.write(inp[0])
	for inl in inp[1:]:
		id = inl.split('\t')[0]
		if Location[id][0] == city:
			output.write(inl)
			if Location[id][4] == train_plot:
				Train.append(id)
			else:
				out.write(id + '\n')
	hold = np.random.choice(Train, int(len(Train)/10), replace=False)
	for id in hold:
		out.write(id + '\n')
	output.close()
		
if type == 'city':
	Train = []
	train_city = train[0]
	for inl in inp[1:]:
		id = inl.split('\t')[0]
		if Location[id][0] == train_city:
			Train.append(id)
		else:
			out.write(id + '\n')
	hold = np.random.choice(Train, int(len(Train)/10), replace=False)
	for id in hold:
		out.write(id + '\n')
		
out.close()

