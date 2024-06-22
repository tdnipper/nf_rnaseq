// Define the ribosomal file
ribofile = file("${moduleDir}/human_rRNAs.fasta")

process bbduk {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    publishDir "logs/bbduk", mode: "move", pattern: "*stats.txt"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("*ribodepleted.fastq.gz"), emit: ribodepleted_reads
    path "*_stats.txt", emit: logs

    script:
    """
    bbduk.sh in1=${reads[0]} in2=${reads[1]} out1=${sample}_R1_ribodepleted.fastq.gz out2=${sample}_R2_ribodepleted.fastq.gz ref=${ribofile} stats=${sample}_stats.txt
    """
}
