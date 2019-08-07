#!/bin/bash

set -ev

# prep genome lib
../STAR-Fusion/ctat-genome-lib-builder/prep_genome_lib.pl --genome_fa minigenome.fa --gtf minigenome.gtf --fusion_annot_lib CTAT_HumanFusionLib.mini.dat.gz --annot_filter_rule AnnotFilterRule.pm

# run CTAT fusion tools via the STAR-F entry point
../STAR-Fusion/STAR-Fusion --left_fq rnaseq_1.fastq.gz --right_fq rnaseq_2.fastq.gz --genome_lib_dir ctat_genome_lib_build_dir --FusionInspector validate --denovo_reconstruct

