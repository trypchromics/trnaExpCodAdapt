#!/usr/bin/env bash

# Sets up initial directories structure.
#mkdir output

# Makes symbolic link for input data: FASTA file of the CDSs.
#ln -s /project/jcunha/mnaseFaireGro/project/codon_usage/Dm28c/t.cruzi/input/Dm28c_CDS.fasta input/

# Certifies that we are working in the amazing Linux world.
#fromdos input/Dm28c_CDS.fasta

Rscript script/geometricMean.R <(head -2 input/Dm28c_CDS.fasta)

exit 0
