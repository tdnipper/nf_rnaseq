params.raw_files = Channel.fromFilePairs("/home/ubuntu/blockvolume/cappable_seq_rna_seq/raw_data/*_R{1,2}.fastq.gz")

params.ribofile = "${moduleDir}/ribofile.fasta"

process bbduk {
    tag "preprocessing"
    tag "decon"

    container "staphb/bbtools"

    input:
    tuple (file1, file2)

    output:
    ribodepleted_reads

    script:
    """
    bbduk.sh 
    """
}