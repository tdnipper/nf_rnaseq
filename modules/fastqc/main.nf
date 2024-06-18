process fastqc {
    tag "qc"

    container "biocontainers/fastqc:v0.11.9_cv8"

    publishDir "${projectDir}/results/raw_fastqc", mode: "copy"

    input:
    path raw_reads

    output:
    path "*.zip", emit: raw_qc_channel

    script:
    """
    fastqc ${raw_reads} 
    """
}