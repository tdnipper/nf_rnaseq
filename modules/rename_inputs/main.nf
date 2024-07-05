process rename {
    input:
    raw_files

    output:
    path("*.gz"), emit: files

    script:
    """
    python rename.py
    """    
}