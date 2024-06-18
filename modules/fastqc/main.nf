process fastqc {
    tag "qc"

    container "biocontainers/fastqc:v0.11.9_cv8"

    publishDir params.raw_qc_results, mode: "copy"

    input:
    path raw_reads

    output:
    path "*.zip", emit: raw_qc_channel

    script:
    """
    fastqc ${raw_reads} 
    """
}