# trnaExpCodAdapt
tRNA Expression-Codon Adaptation


## GM-tECA

The **GM-tECA** (Geometric Mean of tRNA Expression Adaptation) is calculated using the following formula, which represents the geometric mean of the tRNA abundances that decode each codon in a coding sequence (CDS):

<img src="mediaGeometricaAdaptada.png" alt="Geometric average formula." height="150"/>

where:
* **n:** Total number of codons in the CDS.
* **codons:** Vector of length *n* indexed by codon sequences. Each item contains the tRNA abundance that pairs with the corresponding codon.
* **i:** Index in the vector *codons*.

To avoid numerical underflow during the calculation of the geometric mean, each value was multiplied by 100 before computing the product. This step was taken not just to avoid very small numbers, but to prevent the result from becoming smaller than what the computer can accurately represent using floating-point arithmetic. When multiplying many small values, the result can become so close to zero that it is rounded to zero by the computer, leading to inaccurate or undefined results. Scaling the values helps maintain numerical stability and ensures reliable computation.


**Higher GM-tECA values** indicate that the CDS is enriched in codons recognized by the most abundant tRNAs. **Lower GM-tECA values** imply the opposite.


## GM-tECA calculation protocol

### Requirements

Input files:
* **FASTA file:** Contains target coding sequences (CDSs) (e.g., Dm28c_CDSs.fasta). Format: standard FASTA with headers (e.g., ">geneID").
* **tRNA abundance data:** Derived from tRNA-seq experiments. File: tRNA_abundance.txt (tab-delimited, text format) (e.g., codon_tRNA_abundance.txt). Contains tRNA abundances that pair with their corresponding codons.


### Execution

To execute the scripts, run GM-tECA.bash and GM-tECA.R from directory geometricMean.


## Percentage of anticodon:codon base paring

To calculate the **percentage of target anticodon:codon pairing modes**, we employ the following formula: 

<img src="./mediaAritmetica.png" alt="Arithmetic average formula." height="150"/>

where:
* **n:** Total number of codons in the CDS.
* **codons:** Vector of length *n* indexed by codon sequences. If the corresponding codon matches the target anticodon:codon pairing mode, the value is 1. For all remaining codons, which are not targets of the same pairing, the value is 0.
* **i:** Index in the vector *codons*.


## Percentage of target anticodon:codon pairing mode calculation protocol

### Requirements

Input files:
* **FASTA file:** Contains target coding sequences (CDSs) (e.g., Dm28c_CDSs.fasta). Format: standard FASTA with headers (e.g., ">geneID").
* **Specific anticodon:codon pairing mode for the corresponding codons:** File: codonPresence_BaseParing.txt (tab-delimited, text format) (e.g., codonPresence_Inosine.txt). If the correponding codon matches the target anticodon:codon pairing mode, the value is 1. For all remaining codons, which are not targets of the same pairing, the value is 0.


### Execution

To execute the scripts, run anticodonCodonPairing_percentage.bash and anticodonCodonPairing_percentage.R from directory anticodonCodonPairing.
