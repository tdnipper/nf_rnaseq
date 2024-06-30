process bbsplit_align {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    publishDir path: "${projectDir}/logs/bbsplit", mode: "move"

    input:
    tuple val(sample), path(reads) //ribodepleted_reads from bbduk
    path(index) //index dir from bbsplit_index

    output:
    tuple val(sample), path("${sample}_1_nonmyco.fastq.gz"), path("${sample}_2_nonmyco.fastq.gz"), emit: decon_reads
    path "*.txt"

    script:
    """
    bbsplit.sh in=${reads[0]} in2=${reads[1]} basename=${sample}_#_%.fastq.gz refstats=${sample}_stats.txt threads=6
    """
}

