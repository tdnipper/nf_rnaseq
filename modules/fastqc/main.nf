process fastqc {
    tag "qc"

    container "biocontainers/fastqc:v0.11.9_cv8"

    publishDir "${projectDir}/results/raw_fastqc", mode: "symlink"

    input:
    tuple val(sample), path (reads)

    output:
    path "*.zip"
    
    script:
    """
    fastqc ${reads} 
    """
}