dat <- read.table('metadata_full_MMPRNT_G5.LC_LUX_trunc_rar_016017_locations.txt',sep='\t',head=T,stringsAsFactors=F)
dat <- dat[,c(1,3,67:69)]
out <- matrix(rep(NaN,360),30,12)	
colnames(out) <- c('Values','Train','PCC_on_LC','PCC_on_LC_1','PCC_on_LC_2','PCC_on_LC_3','PCC_on_LC_4','PCC_on_LUX','PCC_on_LUX_1','PCC_on_LUX_2','PCC_on_LUX_3','PCC_on_LUX_4')
n = 1
for(files in c('full_Evenness','full_InvSimpson','full_Richness')){
	type = 'plot'
	for(train in c('LC_1','LC_2','LC_3','LC_4','LUX_1','LUX_2','LUX_3','LUX_4')){
		out[n,1] = files
		out[n,2] = train
		score_f = paste('Matrix_',files,'_KNN_impute_',type,'_',train,'_test_on_others.txt_RF_scores.txt',sep='')
		test_f = paste('Matrix_',files,'_KNN_impute_',type,'_',train,'_test_on_others_test.txt',sep='')
		score <- read.table(score_f,head=T,sep='\t',stringsAsFactors=F)
		test <- read.table(test_f,head=F,sep='\t',stringsAsFactors=F)
		test_id <- merge(test,dat,by.x='V1',by.y='sampleID')
		test_in_train_plot <- test_id[test_id[,5]==train,c(1,5)]
		test_in_test_plot <- test_id[test_id[,5]!=train,c(1,5)]
		score_test_in_train <- merge(test_in_train_plot,score,by.x='V1',by.y='sampleID')
		score_test <- merge(test_in_test_plot,score,by.x='V1',by.y='sampleID')
		PCC_test_in_train_plot <- c()
		for(i in 6:ncol(score_test_in_train)){
			PCC_test_in_train_plot <- c(PCC_test_in_train_plot,cor.test(score_test_in_train[,3],score_test_in_train[,i])[4])
			}
		train_col <- which(colnames(out)==paste('PCC_on_',train,sep=''))
		out[n,train_col] <- median(as.numeric(PCC_test_in_train_plot))
		for(plots in unique(score_test[,2])){
			PCC_test <- c()
			subdat <- score_test[score_test[,2]==plots,]
			for(i in 6:ncol(score_test)){
				PCC_test <- c(PCC_test,cor.test(subdat[,3],subdat[,i])[4])
				}
			test_col <- which(colnames(out)==paste('PCC_on_',plots,sep=''))
			out[n,test_col] <- median(as.numeric(PCC_test))
			}
		n = n+ 1
		}
	type = 'city'
	for(train in c('LC','LUX')){
		out[n,1] = files
		out[n,2] = train
		score_f = paste('Matrix_',files,'_KNN_impute_',type,'_',train,'_test_on_others.txt_RF_scores.txt',sep='')
		test_f = paste('Matrix_',files,'_KNN_impute_',type,'_',train,'_test_on_others_test.txt',sep='')
		score <- read.table(score_f,head=T,sep='\t',stringsAsFactors=F)
		test <- read.table(test_f,head=F,sep='\t',stringsAsFactors=F)
		test_id <- merge(test,dat,by.x='V1',by.y='sampleID')
		test_in_train_plot <- test_id[test_id[,2]==train,c(1,2)]
		test_in_test_plot <- test_id[test_id[,2]!=train,c(1,2)]
		score_test_in_train <- merge(test_in_train_plot,score,by.x='V1',by.y='sampleID')
		score_test <- merge(test_in_test_plot,score,by.x='V1',by.y='sampleID')
		PCC_test_in_train_plot <- c()
		for(i in 6:ncol(score_test_in_train)){
			PCC_test_in_train_plot <- c(PCC_test_in_train_plot,cor.test(score_test_in_train[,3],score_test_in_train[,i])[4])
			}
		train_col <- which(colnames(out)==paste('PCC_on_',train,sep=''))
		out[n,train_col] <- median(as.numeric(PCC_test_in_train_plot))
		PCC_test <- c()
		for(i in 6:ncol(score_test)){
			PCC_test <- c(PCC_test,cor.test(score_test[,3],score_test[,i])[4])
			}
		test_col <- which(colnames(out)==paste('PCC_on_',unique(score_test[,2]),sep=''))
		out[n,test_col] <- median(as.numeric(PCC_test))
		n = n+ 1
		}
	}
write.table(out,'Results_PCC_on_test_data.txt',sep='\t',quote=F,row.names=F,col.names=T)