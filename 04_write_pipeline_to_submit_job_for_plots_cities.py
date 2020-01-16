import sys,os
### take the other dataset as test data
for files in ['Matrix_full_Evenness_KNN_impute.txt','Matrix_full_InvSimpson_KNN_impute.txt','Matrix_full_Richness_KNN_impute.txt']:
	for ML_type in ['city LC', 'city LUX','plot LUX_1','plot LUX_2','plot LUX_3','plot LUX_4','plot LC_1','plot LC_2','plot LC_3','plot LC_4']:
		y_name = files.split('Matrix_')[1].split('_KNN_impute.txt')[0]
		type = ML_type.split()[0]
		train = '_'.join(ML_type.split()[1].split(','))
		file_name = files.split('.txt')[0] + '_%s_%s_test_on_others.txt'%(type,train)
		sh_name = 'Model_%s_%s_%s_test_on_others_RF.sh'%(y_name,type,train)
		os.system('python 03_make_matrix_for_model_within_plot_test_on_other_plots.py %s %s'%(files,ML_type))
		out = open(sh_name,'w')
		out.write('#!/bin/sh --login\n#SBATCH --time=4:00:00\n#SBATCH --ntasks=1\n#SBATCH --cpus-per-task=8\n#SBATCH --mem=10G\n#SBATCH --job-name %s\n#SBATCH -e %s.e\n#SBATCH -o %s.o\ncd /mnt/scratch/peipeiw/Microbial\nmodule load Python/3.6.4\n'%(sh_name,sh_name,sh_name))
		out.write('python /mnt/home/peipeiw/Documents/Pathway_prediction/Github/ML-Pipeline_fixed_apply/ML-Pipeline/ML_regression_median_PCC.py -df %s -alg RF -y_name y -gs T -n 100 -cv_num 10 -test %s \n'%(file_name,file_name.split('.txt')[0] + '_test.txt'))
		out.close()
		
		
