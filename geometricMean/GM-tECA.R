# Reads a line of a FASTA 2line file.
read_FASTA_2line <- function(file, line) {
   fasta <- readLines(file)
   id <- fasta[line]
   seq_nucleotides <- fasta[line + 1]
   result <- list(seq_nucleotides = seq_nucleotides, id = id)
   return(result)
}

# Function to compute geometric average of codon values.
geom_avg_codons <- function(seq_nucleotides, table) {
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
      return(prod(values)^(1/length(values)))
}

# Reads data from CSV file to a data frame.
table <- read.csv("codon_tRNA_abundance.txt", sep = "\t", stringsAsFactors = FALSE)


###################################################################################################
# Working with first column.
table1 <- table

# Defines the first column as index.
rownames(table1) <- table1$Codon
table1$Codon <- NULL
table1$MT_tRNA_mapped_reads <- NULL
table1 <- table1 * 100

# Opens the file EPI in append mode.
file <- file("output/EPI_CDSs_GM-tECA.tsv", open = "a")

# Computes the number of rows at FASTA file.
numOfLines <- nrow(read.csv("Dm28c_CDS.fasta"))

# Reads the FASTA 2line file.
for (line in seq(from = 1, to = numOfLines, by = 2)) {
   fastaRecord <- read_FASTA_2line("Dm28c_CDS.fasta", line)

   # Computes the geometric average of codons values for the nucleotide sequence
   geometric_average <- geom_avg_codons(fastaRecord$seq_nucleotides, table1)

   # Prints the geometric average of codon values.
   cat(fastaRecord$id, "\t", geometric_average, "\n", file = file, append = TRUE)
}

# Closes the file.
close(file)


###################################################################################################
# Working with second column.
table2 <- table

# Defines the first column as index.
rownames(table2) <- table2$Codon
table2$Codon <- NULL
table2$EPI_tRNA_mapped_reads <- NULL
table2 <- table2 * 100

# Opens the file MT in append mode.
file <- file("output/MT_CDSs_GM-tECA.tsv", open = "a")

# Computes the number of rows at FASTA file.
numOfLines <- nrow(read.csv("Dm28c_CDS.fasta"))

# Reads the FASTA 2line file.
for (line in seq(from = 1, to = numOfLines, by = 2)) {
   fastaRecord <- read_FASTA_2line("Dm28c_CDS.fasta", line)

   # Computes the geometric average of codons values for the nucleotide sequence
   geometric_average <- geom_avg_codons(fastaRecord$seq_nucleotides, table2)

   # Prints the geometric average of codon values.
   cat(fastaRecord$id, "\t", geometric_average, "\n", file = file, append = TRUE)
}

# Closes the file.
close(file)
