process bbsplit_align {
    tag "preprocessing"
    tag "decon"

    container "quay.io/biocontainers/bbmap:38.22--h470a237_0"

    publishDir path: "${projectDir}/logs/bbsplit", mode: "symlink"

    input:
    tuple val(sample), path(r1), path(r2), path(index) //ribodepleted_reads from bbduk
    // path index, stageAs: "ref/" //index dir from bbsplit_index

    output:
    tuple val(sample), path("${sample}_1_nonmyco.fastq.gz"), path("${sample}_2_nonmyco.fastq.gz"), emit: decon_reads
    path "*.txt", emit: logs

    script:
    """
    bbsplit.sh in=${r1} in2=${r2} basename=${sample}_#_%.fastq.gz refstats=${sample}_stats.txt
    """
}
