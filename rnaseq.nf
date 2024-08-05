include {fastqc} from "./modules/fastqc/main.nf"
include {trim} from "./modules/fastp/main.nf"
include {bbduk} from "./modules/bbduk/main.nf"
include {bbsplit_index} from "./modules/bbsplit/index/main.nf"
include {bbsplit_align} from "./modules/bbsplit/align/main.nf"
include {star_index} from "./modules/star/index/main.nf"
include {star_align} from "./modules/star/align/main.nf"
include {star_removal} from "./modules/star/align/main.nf"
include {interleave_for_streme} from "./modules/MEME/main.nf"
include {subsample_for_streme} from "./modules/MEME/main.nf"
include {get_streme_motifs} from "./modules/MEME/main.nf"

// Define static locations for input files for now
raw_files_ch = Channel.fromFilePairs(params.raw_reads, checkIfExists: true)

workflow  {
    raw_fastqc = fastqc(raw_files_ch)

    trimmed_files = trim(raw_files_ch)
    bbduk_output = bbduk(trimmed_files.reads)

    index_ready = bbsplit_index() // make the index for bbsplit first
    bbduk_files = bbduk_output.ribodepleted_reads.groupTuple() // group all bbduk outputs to pass at once
    ch_bbduk = bbduk_files.combine(index_ready.index) // add index dir to each tuple for reuse
    ch_decon_reads = bbsplit_align(ch_bbduk)

    starIndex = star_index(ch_decon_reads.done.collect())
    starAlign = star_align(ch_decon_reads.decon_reads, starIndex.index)
    
    ch_stream_files = interleave_for_streme(ch_decon_reads.decon_reads, starAlign.bam.collect())
    ch_subsample_files = subsample_for_streme(ch_stream_files)
    streme_motifs = get_streme_motifs(ch_subsample_files)
}