# Nextflow RNA-seq analysis pipeline
## Overview
[Cappable-seq](https://www.neb.com/en-us/protocols/2018/01/19/cappable-seq-for-prokaryotic-transcription-start-site-determination) in cells infected with influenza virus returns data regarding how 5' triphosphorylated RNA changes during infection.
This is a pilot experiment attempting to quantify those changes and identify transcripts that change. Originally these data were analyzed using a combination of python/bash scripts, this is a nextflow pipeline doing the same thing in a much more scalable and reproducible manner. This pipeline takes de-multiplexed reads from the UWBC core and QCs, trims, aligns, and counts reads eventually returning data that can be used in DEseq2 to quantify changes during infection.

## Running the pipeline
Raw data must be in a raW_data directory in the root directory of the pipeline. CPU #s and other program specific settings can be configured manually in the nextflow.config file. Once ready, run the pipeline using `nextflow run main.nf`.

