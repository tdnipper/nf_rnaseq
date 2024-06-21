hybrid_genome_ch = Channel.fromPath("${projectDir}/modules/bbsplit/index/hybrid_genome.fasta")
myco_genome_ch = Channel.fromPath("${projectDir}/modules/bbsplit/index/myco_genome.fasta")


process bbsplit_index{
    tag "index"
    tag "decon"

    container "staphb/bbtools"

    input:
    path hybrid_genome_file
    path myco_genome_file

    output:
    path ("bbsplit"), emit: index

    script:
    """
    bbsplit.sh ref_nonmyco=${hybrid_genome_file} ref_myco=${myco_genome_file} -Xmx30g
    """
}