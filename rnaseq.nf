include {fastqc} from "./modules/fastqc/main.nf"
include {bbduk} from "./modules/bbduk/main.nf"
include {bbsplit_index} from "./modules/bbsplit/index/main.nf"
include {bbsplit_align} from "./modules/bbsplit/align/main.nf"

raw_files_ch = Channel.fromFilePairs("/home/ubuntu/blockvolume/cappable_seq_rna_seq/raw_data/*_R{1,2}.fastq.gz")

workflow  {
    raw_fastqc = fastqc(raw_files_ch)
    bbduk(raw_files_ch)
    ribodepleted_ch = Channel.fromFilePairs(ribodepleted_reads)
    bbsplit(ribodepleted_reads)

}