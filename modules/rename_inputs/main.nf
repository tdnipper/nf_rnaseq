process rename {
    input:
    tuple val(sample), path (reads)

    output:
    tuple val(sample), path("*.gz"), emit: files

    script:
    """
    rename.py ${reads[0]}
    rename.py ${reads[1]}
    """    
}