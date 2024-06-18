include {fastqc} from "./modules/fastqc/main.nf"

workflow  {
    raw_fastqc = fastqc(params.raw_reads)

}