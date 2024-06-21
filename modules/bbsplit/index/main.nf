process bbsplit_index{
    tag "index"
    tag "decon"

    container "staphb/bbtools"

    input:
    path hybrid_genome_file
    path myco_genome_file

    output:
    path "ref", emit: index

    script:
    """
    bbsplit.sh ref_nonmyco=${hybrid_genome_file} ref_myco=${myco_genome_file} -Xmx38g
    """
}