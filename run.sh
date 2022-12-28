#Yeast example - Default
nextflow run main.nf --species "Saccharomyces_cerevisiae"  --model 'D00113.001_RNAcompete_Hrp1p' --results results --intervalFile inputdata/sacCer3.intervals_file

#Homo_sapiens example
#nextflow run main.nf --species "Homo_sapiens"  --model 'D00290.003_SELEX_ALX3' --results results --intervalFile regions_enh_E003.1.bed --fastaFile Hg19.fa
