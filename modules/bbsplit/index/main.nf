process bbsplit_index{
    tag "index"
    tag "decon"

    container "quay.io/biocontainers/bbmap:38.22--h470a237_0"

    input:
    path hybrid_genome_file
    path myco_genome_file
    val(sample) // require input from finished bbduk to prevent memory error

    output:
    path "ref/", emit: index, type: "dir"
    script:
    """
    bbsplit.sh ref_nonmyco=${hybrid_genome_file} ref_myco=${myco_genome_file}
    """
}