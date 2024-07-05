process test {
    input:
    tuple val(sample), path(r1), path(r2)

    output:
    stdout

    script:
    """
    echo ${sample}
    echo ${r1}
    echo ${r2}
    """

}

process samtools_test {
    container "tdnipper/bioinformatics:star"

    script:
    """
    samtools --version
    """
}