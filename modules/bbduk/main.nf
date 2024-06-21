process bbduk {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    publishDir "logs/bbduk", mode: "move", pattern: "*_stats.txt"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("*_ribodepleted.fastq.gz"), emit: ribodepleted_reads
    path "*_stats.txt", emit: logs
    stdout

    script:
    """
    bbduk.sh in1=${reads[0]} in2=${reads[1]} out1=${sample}_R1_ribodepleted.fastq.gz out2=${sample}_R2_ribodepleted.fastq.gz ref=${ribofile} stats=${sample}_stats.txt
    """
}
