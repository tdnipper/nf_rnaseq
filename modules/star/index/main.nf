genomeFile = file(params.hybrid_genome_file)
annotationFile = file(params.annotation_file)

process star_index {
    
    container "quay.io/tdnipper/star_samtools"

    input:
    val(signal)

    output:
    path "star_index/", type: "dir", emit: index

    script:
    """
    STAR --runMode genomeGenerate --runThreadN ${params.cpus} --genomeDir star_index --genomeFastaFiles ${genomeFile} --sjdbGTFfile ${annotationFile} 
    """
    
}
