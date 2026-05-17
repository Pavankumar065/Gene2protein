# ============================================================
# Assignment: RAD51 Gene Analysis
# Task 3: List all proteins for RAD51 gene
# Gene: RAD51 | Ensembl ID: ENSG00000051180
# Category: Cancer | Function: DNA double-strand break repair
# ============================================================

# ---- Install/Load Required Packages ----
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

bioc_pkgs <- c("ensembldb", "EnsDb.Hsapiens.v86", "AnnotationFilter")
for (pkg in bioc_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE))
    BiocManager::install(pkg)
}

library(ensembldb)
library(EnsDb.Hsapiens.v86)
library(AnnotationFilter)

# ---- Load the Ensembl Database ----
edb <- EnsDb.Hsapiens.v86

# ---- Define RAD51 Gene ----
RAD51_ENSEMBL_ID <- "ENSG00000051180"

cat("==========================================================\n")
cat("  RAD51 Gene - Protein Listing\n")
cat("  Ensembl ID: ENSG00000051180\n")
cat("==========================================================\n\n")

# ---- Query All Proteins for RAD51 ----
# Proteins are retrieved via protein() using gene filter
rad51_proteins <- proteins(
  edb,
  filter = GeneIdFilter(RAD51_ENSEMBL_ID),
  columns = c(
    "protein_id",          # Ensembl Protein ID (ENSP...)
    "protein_sequence",    # Amino acid sequence
    "tx_id",               # Linked transcript ID
    "gene_id",             # Gene ID
    "gene_name"            # Gene symbol
  )
)

# ---- Display Results ----
cat("Total number of protein products found:", nrow(rad51_proteins), "\n\n")

# Convert to data frame
rad51_prot_df <- as.data.frame(rad51_proteins)

# Print summary table (without full sequence for readability)
summary_df <- rad51_prot_df[, c("protein_id", "tx_id", "gene_name")]
summary_df$sequence_length_aa <- nchar(rad51_prot_df$protein_sequence)
print(summary_df)

cat("\n")

# ---- Detailed Protein Information ----
cat("----------------------------------------------------------\n")
cat("Detailed protein information:\n\n")

for (i in seq_len(nrow(rad51_prot_df))) {
  seq_len_aa <- nchar(rad51_prot_df$protein_sequence[i])
  cat(sprintf("  [%d] Protein ID      : %s\n", i, rad51_prot_df$protein_id[i]))
  cat(sprintf("      Transcript ID   : %s\n",      rad51_prot_df$tx_id[i]))
  cat(sprintf("      Gene            : %s (%s)\n",
              rad51_prot_df$gene_name[i], RAD51_ENSEMBL_ID))
  cat(sprintf("      Length          : %d amino acids\n", seq_len_aa))
  cat(sprintf("      Mol. Weight ~   : %.1f kDa\n", seq_len_aa * 0.110))

  # Show first 60 aa of sequence as preview
  seq_preview <- substr(rad51_prot_df$protein_sequence[i], 1, 60)
  cat(sprintf("      Sequence (1-60) : %s...\n", seq_preview))
  cat("\n")
}

# ---- Also retrieve protein domain information ----
cat("----------------------------------------------------------\n")
cat("Protein domain annotations (UniProt features):\n\n")

tryCatch({
  rad51_prot_domains <- proteins(
    edb,
    filter = GeneIdFilter(RAD51_ENSEMBL_ID),
    columns = c("protein_id", "uniprot_id", "uniprot_db", "uniprot_mapping_type")
  )
  print(as.data.frame(rad51_prot_domains)[, c("protein_id", "uniprot_id",
                                               "uniprot_db",
                                               "uniprot_mapping_type")])
}, error = function(e) {
  cat("  Note: UniProt annotations not available in this EnsDb version.\n")
  cat("  Use Ensembl BioMart or UniProt directly for domain data.\n")
})

cat("\n")

# ---- Save Results ----
# Save summary (without full sequences)
summary_output <- rad51_prot_df[, c("protein_id", "tx_id", "gene_name")]
summary_output$sequence_length_aa <- nchar(rad51_prot_df$protein_sequence)
write.csv(summary_output, file = "RAD51_proteins_summary.csv", row.names = FALSE)
cat("Summary saved to: RAD51_proteins_summary.csv\n")

# Save full sequences in FASTA format
fasta_file <- "RAD51_proteins.fasta"
fasta_lines <- c()
for (i in seq_len(nrow(rad51_prot_df))) {
  header <- sprintf(">%s|%s|RAD51|Homo sapiens",
                    rad51_prot_df$protein_id[i],
                    rad51_prot_df$tx_id[i])
  # Split sequence into 60-character lines (standard FASTA)
  seq   <- rad51_prot_df$protein_sequence[i]
  seq_lines <- regmatches(seq, gregexpr(".{1,60}", seq))[[1]]
  fasta_lines <- c(fasta_lines, header, seq_lines)
}
writeLines(fasta_lines, con = fasta_file)
cat(sprintf("Protein sequences saved in FASTA format to: %s\n", fasta_file))

# ---- Session Info ----
cat("\nSession Information:\n")
sessionInfo()
