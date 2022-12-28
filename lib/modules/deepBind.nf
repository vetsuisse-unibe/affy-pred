process deepBind {
    label 'med'
    publishDir "$results_dir", mode: 'copy'
    container 'kipoi/kipoi-docker:sharedpy3keras2tf1-slim'

    input:
    path bedFile
    path faFile
    val(model)
    val(results_dir)
    val(prot)

    output:
    path("*.tsv")

    script:
    """
    kipoi predict DeepBind/$params.species/$prot/$model --dataloader_args='{'intervals_file': \'$bedFile\', 'fasta_file': \'$faFile\'}' -o 'DeepBind_${params.species}_${prot}_${model}.tsv'
    """

}
