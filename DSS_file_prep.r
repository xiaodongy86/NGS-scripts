# take cov files and change file structure for input to DSS

options(echo=T)
args=commandArgs(trailingOnly=T)
print(args)

files=dir(pattern=paste0(args[1],"*.bismark.cov")
data <- read.delim(files[1], head=F)
data[,7] <- data[,5] + data[,6]
data <- data[,c(1,2,5,7)]
sample <- substr(as.character(files[1]), start = 1, stop = 12)
colnames(data)=c('Chr','Pos', paste0(sample, '_count_met'),paste0(sample,'_count_total'))

for(i in 2:length(files)){
file <- read.delim(files[i], head=F)
file[,7] <- file[,5] + file[,6]
file <- file[,c(1,2,5,7)]
sample <- substr(as.character(files[i]), start = 1, stop = 12)
colnames(file)=c('Chr','Pos', paste0(sample, '_count_met'),paste0(sample,'_count_total'))
temp <- merge(data,file, by=c('Chr','Pos'), all=T)
data=temp
}

write.table(data, file=paste0(substr(as.character(files[1], start=1, stop=4, "_output.bed"), 
	sep='\t', quote = F, col.names=T, row.names=F)
