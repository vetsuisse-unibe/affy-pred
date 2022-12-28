#!/usr/bin/env nextflow

def printVersion(String version) {
    println(
        """
        ==============================================
                DeepBind Pipeline version ${version}
        ==============================================
        """.stripIndent()
    )
}

def helpMenu() {
    println(
        """
        The workflow requires the following mandatory arguments:
        --species The species of the sample. This must be one of
                Arabidopsis_thaliana
                Aspergillus_nidulans
                Caenorhabditis_elegans
                Drosophila_melanogaster
                Gallus_gallus
                Homo_sapiens  
                Leishmania_major - 
                Mus_Musculus
                Naegleria_gruberi
                Nematostella_vectensis
                Neurospora_crassa
                Ostreococcus_tauri
                Physcomitrella_patens
                Phytophthora_ramorum
                Plasmodium_falciparum
                Rhizopus_oryzae	
                Saccharomyces_cerevisiae
                Schistosoma_mansoni
                Tetraodon_nigroviridis
                Thalassiosira_pseudonana
                Trichomonas_vaginalis
                Trypanosoma_brucei
                Xenopus_tropicalis
    --model_pattern The model pattern starts with D followed by protein identifier and experiment ex: D00290.003_SELEX_ALX3 
    --interval_file genomic regions  in bed format with the three columns defining a region (contig/chr name, begin and end position)
    --outdir path to output dir
    --fastaFile The reference genome sequence file (optional)

        """
    )
}

def errorSpecies() {
    println(
        """
        The input species must be one of the following:
        --species The species of the sample. This must be one of
                Arabidopsis_thaliana
                Aspergillus_nidulans
                Caenorhabditis_elegans
                Drosophila_melanogaster
                Gallus_gallus
                Homo_sapiens  
                Leishmania_major - 
                Mus_Musculus
                Naegleria_gruberi
                Nematostella_vectensis
                Neurospora_crassa
                Ostreococcus_tauri
                Physcomitrella_patens
                Phytophthora_ramorum
                Plasmodium_falciparum
                Rhizopus_oryzae	
                Saccharomyces_cerevisiae
                Schistosoma_mansoni
                Tetraodon_nigroviridis
                Thalassiosira_pseudonana
                Trichomonas_vaginalis
                Trypanosoma_brucei
                Xenopus_tropicalis
        """
    )
    System.exit(1)
}

def errorModel(String model, String species) {
    println(
        """
        "The model ${model} is not valid for ${species}. See https://kipoi.org/groups/DeepBind/ for more models"
        """
    )
    System.exit(1)
}
