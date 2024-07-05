include {bbduk} from "./modules/bbduk/main.nf"

workflow remove_rRNA {
    take:
    raw_files = Channel.fromFilePairs(params.raw_reads)

    main:
    trimmed_reads = bbduk(raw_files)
}