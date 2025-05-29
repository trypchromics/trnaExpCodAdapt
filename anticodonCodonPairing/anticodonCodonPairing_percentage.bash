#!/usr/bin/env bash

# Sets up initial directories structure.
mkdir output


# Certifies that we are working in the amazing Linux world.
#fromdos Dm28c_CDS.fasta

Rscript anticodonCodonPairing/anticodonCodonPairing_percentage.R

exit 0
