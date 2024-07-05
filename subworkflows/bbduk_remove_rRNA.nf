include {bbduk} from "./modules/bbduk/main.nf"

workflow remove_rRNA {
    take:
    raw_files 

    main:
    trimmed_reads = bbduk(raw_files)

    emit:
    trimmed_reads
}