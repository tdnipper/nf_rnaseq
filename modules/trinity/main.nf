process trinity_transcriptome {

    maxForks = 1

    container "docker.io/trinityrnaseq/trinityrnaseq"

    publishDir "${workflow.projectDir}/output/trinity", mode: "symlink", pattern: "Trinity.fasta"

    input:
    val(bam_done)
    path(final_bam)

    output:
    path("Trinity.fasta"), emit:transcriptome

    script:
    """
    Trinity --genome_guided_bam ${final_bam} \
    --genome_guided_max_intron 10000 \
    --max_memory ${params.memory}G --CPU ${params.cpus}
    """
}