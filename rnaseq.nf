include {fastqc} from "./modules/fastqc/main.nf"
include {bbduk} from "./modules/bbduk/main.nf"
include {bbsplit_index} from "./modules/bbsplit/index/main.nf"
include {bbsplit_align} from "./modules/bbsplit/align/main.nf"

// Define static locations for key files for now
raw_files_ch = Channel.fromFilePairs("/home/ubuntu/blockvolume/cappable_seq_rna_seq/raw_data/*_R{1,2}.fastq.gz")
hybrid_genome_ch = Channel.fromPath("${projectDir}/modules/bbsplit/index/hybrid_genome.fasta", checkIfExists: true)
myco_genome_ch = Channel.fromPath("${projectDir}/modules/bbsplit/index/myco_genome.fasta", checkIfExists: true)

workflow  {
    // raw_fastqc = fastqc(raw_files_ch)
    bbduk = bbduk(raw_files_ch)
    index_ready = bbsplit_index(hybrid_genome_ch, myco_genome_ch)
    decon_reads = bbsplit_align(bbduk.ribodepleted_reads, index_ready.index)

}