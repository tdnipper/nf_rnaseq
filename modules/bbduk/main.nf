// Define the ribosomal file
ribofile = file("${moduleDir}/human_rRNAs.fasta")

process bbduk {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    def logs = "logs/bbduk"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("*_ribodepleted.fastq.gz"), emit: ribodepleted_reads
    path "log/bbduk/*", emit: logs

    script:
    """
    mkdir -p $logs
    bbduk.sh in1=${reads[0]} in2=${reads[1]} out1=${sample}_R1_ribodepleted.fastq.gz out2=${sample}_R2_ribodepleted.fastq.gz ref=${ribofile} stats=log/bbduk/${sample}_stats.txt
    """
}
