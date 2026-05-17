# ============================================================
# Assignment: RAD51 Gene Analysis
# Task 2: List all transcripts for RAD51 gene
# Gene: RAD51 | Ensembl ID: ENSG00000051180
# Category: Cancer | Function: DNA double-strand break repair
# ============================================================

# ---- Install/Load Required Packages ----
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Install required Bioconductor packages if not already installed
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

# ---- Query All Transcripts for RAD51 ----
cat("==========================================================\n")
cat("  RAD51 Gene - Transcript Listing\n")
cat("  Ensembl ID: ENSG00000051180\n")
cat("==========================================================\n\n")

# Retrieve transcripts using GeneIdFilter
rad51_transcripts <- transcripts(
  edb,
  filter = GeneIdFilter(RAD51_ENSEMBL_ID),
  columns = c(
    "tx_id",           # Transcript Ensembl ID
    "tx_name",         # Transcript name
    "tx_biotype",      # Biotype (protein_coding, lncRNA, etc.)
    "tx_seq_start",    # Transcript start position
    "tx_seq_end",      # Transcript end position
    "tx_cds_seq_start",# CDS start
    "tx_cds_seq_end",  # CDS end
    "seq_name",        # Chromosome
    "seq_strand",      # Strand
    "gene_name"        # Gene symbol
  )
)

# ---- Display Results ----
cat("Total number of transcripts found:", length(rad51_transcripts), "\n\n")

# Convert to data frame for easier viewing
rad51_tx_df <- as.data.frame(rad51_transcripts)

# Print all transcripts
print(rad51_tx_df[, c("tx_id", "tx_name", "tx_biotype",
                       "seqnames", "start", "end", "strand")])

cat("\n")

# ---- Summary by Biotype ----
cat("----------------------------------------------------------\n")
cat("Transcript count by biotype:\n")
print(table(rad51_tx_df$tx_biotype))
cat("----------------------------------------------------------\n\n")

# ---- Detailed View ----
cat("Detailed transcript information:\n\n")
for (i in seq_len(nrow(rad51_tx_df))) {
  cat(sprintf("  [%d] Transcript ID : %s\n", i, rad51_tx_df$tx_id[i]))
  cat(sprintf("      Name          : %s\n", rad51_tx_df$tx_name[i]))
  cat(sprintf("      Biotype       : %s\n", rad51_tx_df$tx_biotype[i]))
  cat(sprintf("      Location      : chr%s:%d-%d (%s strand)\n",
              rad51_tx_df$seqnames[i],
              rad51_tx_df$start[i],
              rad51_tx_df$end[i],
              ifelse(rad51_tx_df$strand[i] == 1, "+", "-")))
  cds_start <- rad51_tx_df$tx_cds_seq_start[i]
  cds_end   <- rad51_tx_df$tx_cds_seq_end[i]
  if (!is.na(cds_start) && !is.na(cds_end)) {
    cat(sprintf("      CDS           : %d-%d (length: %d bp)\n",
                cds_start, cds_end, cds_end - cds_start + 1))
  } else {
    cat("      CDS           : Not applicable (non-coding)\n")
  }
  cat("\n")
}

# ---- Save Results to CSV ----
output_file <- "RAD51_transcripts.csv"
write.csv(rad51_tx_df, file = output_file, row.names = FALSE)
cat(sprintf("Results saved to: %s\n", output_file))

# ---- Session Info ----
cat("\nSession Information:\n")
sessionInfo()
