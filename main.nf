include {initial_qc} from "./subworkflows/fastqc_qc.nf"
raw_files = Channel.fromFilePairs(params.raw_reads)

workflow {
    
    // initial_qc(raw_files)
    // raw_files.view()

}