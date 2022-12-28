# AffinityPred
## About
This repository contains a pipeline prototype for TF affinity binding sites for a given genome interval of a sample.

## Dependencies

1. Java - virtual machine to run workflow
2. Nextflow - workflow pipeline engine
3. Docker - used for running containerised Kipoi deepBind prediction (http://kipoi.org/groups/) 

*Optional*

4. Genomepy - used for reference genome download

## How to use
### Quick test
### Test the workflow script with default parameters
```
sh run.sh or ./run.sh
```
The default parameters are 
1. --species "Saccharomyces_cerevisiae" 
2. --model "D00113.001_RNAcompete_Hrp1p" is for a RNA binding protien  (https://www.yeastgenome.org/locus/S000005483)
3. --reults 'results'  directory where the affinity scores are stored in a tsv file
4. --intervalFile a toy bed file defining the chromosomal intervals.
The ./data/genomes_dir has a toy Saccharomyces_cerevisiae genome file which used along with the interval file to predict affinity score in the interval

### Help
The script can be run in the following manner for detailed help
```
nextflow run main.nf --help
```
### Run the workflow  with external genome reference sequence 
```
nextflow run main.nf --species "Homo_sapiens"  --model 'D00290.003_SELEX_ALX3' --results results  --fastaFile Hg19.fa --intervalFile regions_enh_E003.1.bed 
```
Here user arguments are supplied with --parameters  
1. --species The species from which Transcription factor (TF) or RNA Binding Protein (RBP) the model is defined
2. --model DeepBind model 
3. --results name of the directory where the results are stored. 
4. --fastaFile  reference sequence in fasta format
5. --intervalFile co-ordinates in  BED format to extract the nucleotide sequences from fasta file for the prediction

* To download human reference genome via docker container
```
docker run -v ~/dev/nextflow/AffinityPred-test/data/genomes_dir:/app genomepy genomepy install hg19 -p UCSC -g '/app'
```
The details of docker image building is available in the docker directory. 

### To run nextflow
```
nextflow run main.nf --species "Saccharomyces_cerevisiae"  --model 'D00113.001_RNAcompete_Hrp1p' --results results --intervalFile inputdata/sacCer3.intervals_file
```

