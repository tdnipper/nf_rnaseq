process rename {
    input:
    tuple val(sample), path (reads)

    output:
    path("*.gz"), emit: files

    script:
    """
    rename.py ${reads}
    """    
}