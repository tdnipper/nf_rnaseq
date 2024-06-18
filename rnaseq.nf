include {fastqc} from "./modules/fastqc/main.nf"

workflow  {
    def raw_files = Channel.fromPath(params.raw_reads)
    raw_fastqc = fastqc(raw_files)
}

log