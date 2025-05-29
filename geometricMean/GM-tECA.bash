#!/usr/bin/env bash

# Creating a directory to obtain GM-tECA values.
mkdir output

# Certifying that we are working in the amazing Linux world.
#fromdos Dm28c_CDS.fasta

Rscript geometricMean/GM-tECA.R <(head -2 Dm28c_CDS.fasta)

exit 0
