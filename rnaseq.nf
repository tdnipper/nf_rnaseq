include fastqc from "./modules/fastqc/main.nf"

params {
    raw_reads = "./data/raw_reads/*.fastq.gz"
    trimmed_reads = "./data/trimmed_reads/*.fastq.gz"
    raw_qc_results = "./results/raw_qc"
}

workflow  {
    raw_fastqc = fastqc(raw_reads)
}