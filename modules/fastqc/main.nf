process fastqc {
    tag "qc"

    container "biocontainers/biocontainers:v1.1.0_cv2"

    publishDir params.raw_qc_results, mode: "copy"

    input:
    path(raw_reads)

    output:
    path "*.zip" into raw_qc_results

    script:
    """
    fastqc ${raw_reads_R1} ${raw_reads_R2} -o ${raw_qc_results}
    """
}