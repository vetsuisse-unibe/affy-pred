#!/usr/bin/env nextflow 

/*
===============================================================
                    DeepBind Pipeline
===============================================================
*/

//Pipeline version 
version = '1.0'

// DSL 2
nextflow.enable.dsl=2

// include helper functions
include {printVersion; helpMenu;errorSpecies;errorModel} from './lib/misc.nf'
include {createMap;refGenome} from './lib/refModel.nf'
include {deepBind} from './lib/modules/deepBind'

/*************** HELP ***************/

//help menu 
if (params.help){
        printVersion(version)
        helpMenu()
        System.exit(0)
}

if (params.version){
        printVersion(version)
        System.exit(0)
}

/***************Validate on number of parameters ***************/
try{
    assert (params.species && params.model && params.intervalFile && params.results): helpMenu()
}
catch(AssertionError e){
    println "The program needs parameters for --species --model and --intervalFile"
    System.exit(1)
}

/*************** Input Validations ***************/
//create lists for species and available deepBind models  
deepBindModelMap = createMap(params.modelFile)

// validate if provided species has deepBind models 
println params.species in deepBindModelMap.keySet().toArray() ?  "Input Species: ${params.species}" : errorSpecies()

// is it a valid deepBind model 
println params.model in deepBindModelMap.get(params.species).values().flatten() ? "Input Model: ${params.model}" : errorModel(params.model,params.species)

//is it RBP or TF
deepBindModelMap.get(params.species).keySet().toArray().each{ t -> 
    deepBindModelMap.get(params.species)[t].each{ e -> 
        //println e
        // if (e ==~ /D00296\.006_SELEX_AR/) { // Human - TF
        // if (e ==~ /D00096\.001_RNAcompete_DAZAP1/) { // Human - RBP
        if (e ==~ /${params.model}/) {
            // println "Setting params.prot to ${t}"
            params.prot=t
        }
    }
}

/*************Data Options************************/
//choose the reference genome based on input species name
refParams=refGenome(params.species, params.refdb)
if (!params.fastaFile) {
    if (refParams.isEmpty()){
            println "The reference genome for the species " + params.species + "is currently not available"
            println "The reference sequence genome database has fasta file for Saccharomyces_cerevisiae "
            System.exit(1)
        } else {
            params.genome=refParams[0]
            params.provider=refParams[1]
            params.fastaFile="./data/genomes_dir/${params.genome}/${params.genome}.fa"
            println "Fasta file used is" + params.fastaFile
            println "Reference version used for " + params.species + ":" + params.genome 
            println "Genome reference proivder " + params.provider + ": genome database"
        }
}

/*************** Main Wokflow ***************/
// launch
workflow {
    faFile = file(params.fastaFile) //get file reference to genome
    bedFile = file(params.intervalFile) //get file reference to interval file
    deepBind(bedFile, faFile, params.model, params.results, params.prot) // launch deepBind
}
// success
workflow.onComplete {
    println "Pipeline completed at: ${workflow.complete}"
    println "Time to complete workflow execution: ${workflow.duration}"
    println "Execution status: " + (workflow.success ? "Succesful! \nYou can find your results in " + params.results : 'Failed')
}
// error
workflow.onError {
    println "Oops... Pipeline execution stopped with the following message: ${workflow.errorMessage}"
}


