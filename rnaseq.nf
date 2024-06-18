include {fastqc} from "./modules/fastqc/main.nf"
include {bbduk} from "./modules/bbduk/main.nf"

def raw_files = Channel.fromPath(params.raw_reads)
def trimmed_reads = "./data/trimmed_reads"
def ribodepleted_files = Channel.from(bbduk(raw_reads))

workflow  {
    raw_fastqc = fastqc(raw_files)
    bbduk(raw_reads)
}