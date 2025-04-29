# Reads a line of a FASTA 2line file.
read_FASTA_2line <- function(file, line) {
   fasta <- readLines(file)
   id <- fasta[line]
   seq_nucleotides <- fasta[line + 1]
   result <- list(seq_nucleotides = seq_nucleotides, id = id)
   return(result)
}

# Function to compute arithmetic average of codon values.
arithm_avg_codons <- function(seq_nucleotides, table) {
   codons <- strsplit(seq_nucleotides, "")[[1]]
   codons <- matrix(codons, ncol = 3, byrow = TRUE)
   codons <- apply(codons, 1, paste, collapse = "")
   codons <- codons[-length(codons)]
   values <- sapply(codons, function(codon) {
      if (codon %in% rownames(table)) {
         value <- table[codon, ]
         return(as.numeric(value))
      } else
         return(NA)
   })
   values <- unlist(values)
   values <- values[!is.na(values)]
   if (length(values) == 0)
      return(NA)
   else
      return(mean(values))
}

# Reads data from CSV file to a data frame.
table <- read.csv("input/input_codon_ACC.txt", sep = "\t", stringsAsFactors = FALSE)


###################################################################################################
# Defines the first column as index.
rownames(table) <- table$Codon

# Opens the output file in append mode.
file <- file("output/arithmeticAverage_PAO1.tsv", open = "a")

# Computes the number of lines at the FASTA file.
numOfLines <- nrow(read.csv("input/CDSs_output.fasta"))

# Reads the FASTA 2line file.
for (line in seq(from = 1, to = numOfLines, by = 2)) {
   fastaRecord <- read_FASTA_2line("input/CDSs_output.fasta", line)

   # Computes the arithmetic average of codons values for the nucleotide sequence.
   arithmetic_average <- arithm_avg_codons(fastaRecord$seq_nucleotides, table)

   # Prints the arithmetic average of codon values.
   cat(fastaRecord$id, "\t", arithmetic_average, "\n", file = file, append = TRUE)
}

# Closes the file.
close(file)

# See eventual warnings that were generated.
warnings()
