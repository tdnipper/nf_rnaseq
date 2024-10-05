# Nextflow RNA-seq analysis pipeline
## Overview
[Cappable-seq](https://www.neb.com/en-us/protocols/2018/01/19/cappable-seq-for-prokaryotic-transcription-start-site-determination) in cells infected with influenza virus returns data regarding how 5' triphosphorylated RNA changes during infection.
This is a pilot experiment attempting to quantify those changes and identify transcripts that change. Originally these data were analyzed using a combination of python/bash scripts, this is a nextflow pipeline doing the same thing in a much more scalable and reproducible manner. This pipeline takes de-multiplexed reads from the UWBC core and QCs, trims, aligns, and counts reads eventually returning data that can be used in DEseq2 to quantify changes during infection. To map reads to both the influenza genome and the human genome, this pipeline includes a custom influenza virus (WSN strain)/human hybrid with accompanying gtf.

## Running the pipeline
Raw data must be in a raw_data directory in the root directory of the pipeline. CPU #s and other program specific settings can be configured manually in the nextflow.config file. Once ready, run the pipeline using `nextflow run main.nf`.

## Procedure
Reads are first QC'd using `FastQC`. After QC, reads are trimmed using `fastp`and subject to two decontamination steps. The first remove contaminating mycoplasma reads using `bbsplit` to map to either the mycoplasma genome or the combined influenza/human genome and the rRNA are removed using `bbduk` and an accompanying human rRNA sequence file. After decontamination, reads are mapped to the human/influenza viru sgenome using `STAR`, and then quantified using STAR's GeneCounts method. This generates a matrix that should be combined with other samples to send to DESeq2. `merge_star_counts.py` combined all samples into a matrix ready for DESeq2. `star_count_reads.R` quantified the reads in infected cells relative to mock-treated cells, producing the final results.
>[!NOTE]
>Quantification at the transcript level using a pseudoaligner like `Salmon` is usually preferrable to quantifying at the gene level with an aligner like `STAR` in well-annotated genomes because of increased accuracy and speed. However, our first attempt at the cappable-seq protocol had us fragment RNA meaning that the length based offsets used in `Salmon` quantification would skew our result. The transcripts sequenced in this pilot experiment are all the same length, approximately 150bp of the 5' end. `Salmon` functionality will follow in later experiments that skip this fragmentation step.
>[!WARNING]
>Motif finding using `STREME` is a work in progress despite being included at the end of the workflow. It isn't fully working yet and is under active development.
