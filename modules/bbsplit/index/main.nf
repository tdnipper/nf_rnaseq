// Define the index directory
hybrid_genome_file = 
myco_genome_file = 

process bbsplit_index{
    tag "prep"

    container "staphb/bbtools"

    shell:
    """
    bbsplit.sh ref_nonmyco=${hybrid_genome_file} ref_myco=${myco_genome_file}
    """
}

process bbsplit_align {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("_nonmyco.fastq.gz")
}