include {fastqc} from "./modules/fastqc/main.nf"
include {bbduk} from "./modules/bbduk/main.nf"
include {bbsplit_index} from "./modules/bbsplit/index/main.nf"
include {bbsplit_align} from "./modules/bbsplit/align/main.nf"
include {test} from "./test.nf"
include {star_index} from "./modules/star/index/main.nf"
include {star_align} from "./modules/star/align/main.nf"
include {star_removal} from "./modules/star/align/main.nf"

// Define static locations for input files for now
raw_files_ch = Channel.fromFilePairs(params.raw_reads, checkIfExists: true)

workflow  {
    raw_fastqc = fastqc(raw_files_ch)
    bbduk_output = bbduk(raw_files_ch)
    index_ready = bbsplit_index() // make the index for bbsplit first
    bbduk_files = bbduk_output.ribodepleted_reads.groupTuple() // group all bbduk outputs to pass at once
    bbduk_ch = bbduk_files.combine(index_ready.index) // add index dir to each tuple for reuse
    decon_reads = bbsplit_align(bbduk_ch)
    starIndex = star_index(decon_reads.done.collect())
    starAlign = star_align(decon_reads.decon_reads, starIndex.index)
}