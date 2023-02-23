# Vector of unique IDs from a sequence database, NCBI accession followed by version number 
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")


# Loading rentrez package
library(rentrez)


# Passing unique IDs to the "Nucleotide" NCBI database & fetching sequences in fasta format
Bburg <- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")


# Examine Bburg object (3 seqs of 16S gene of Borrelia burgdorferi (Lyme Disease bacteria)
print(Bburg)


# Creating a new object to separate each sequence into diff elements (3 total in list)
Sequences <- strsplit(Bburg, split = "\n\n")
print(Sequences)


# Converting Sequences to a data frame from a list object
Sequences <- unlist(Sequences)


# Using regular expressions to separate the sequences from the headers
header <- gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
seq <- gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)
Sequences <- data.frame(Name = header, Sequence = seq)


# Remove newline characters from Sequences dataframe using regular expressions
Sequences$Sequence <- gsub("\\n", "", as.character(Sequences$Sequence))


# Output Sequences dataframe
write.csv(Sequences, "Sequences.csv", row.names = FALSE)
