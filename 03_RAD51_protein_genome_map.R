# ============================================================
# Assignment: RAD51 Gene Analysis
# Task 4: Generate protein-to-genome map for each protein product
# Gene: RAD51 | Ensembl ID: ENSG00000051180
# Category: Cancer | Function: DNA double-strand break repair
# Reference: https://www.bioconductor.org/packages/release/bioc/
#            vignettes/ensembldb/inst/doc/coordinate-mapping.html
# ============================================================

# ---- Install/Load Required Packages ----
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

bioc_pkgs <- c("ensembldb", "EnsDb.Hsapiens.v86",
               "AnnotationFilter", "GenomicRanges", "IRanges")
for (pkg in bioc_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE))
    BiocManager::install(pkg)
}

library(ensembldb)
library(EnsDb.Hsapiens.v86)
library(AnnotationFilter)
library(GenomicRanges)
library(IRanges)

# ---- Load the Ensembl Database ----
edb <- EnsDb.Hsapiens.v86

# ---- Define RAD51 Gene ----
RAD51_ENSEMBL_ID <- "ENSG00000051180"

cat("==========================================================\n")
cat("  RAD51 Gene - Protein to Genome Coordinate Mapping\n")
cat("  Ensembl ID: ENSG00000051180\n")
cat("  Reference genome: GRCh38 (hg38)\n")
cat("==========================================================\n\n")

# ---- Step 1: Retrieve all protein IDs for RAD51 ----
rad51_proteins <- proteins(
  edb,
  filter = GeneIdFilter(RAD51_ENSEMBL_ID),
  columns = c("protein_id", "tx_id", "gene_name", "protein_sequence")
)
rad51_prot_df <- as.data.frame(rad51_proteins)

cat(sprintf("Found %d protein product(s) for RAD51:\n", nrow(rad51_prot_df)))
for (i in seq_len(nrow(rad51_prot_df))) {
  cat(sprintf("  [%d] %s (transcript: %s, length: %d aa)\n",
              i,
              rad51_prot_df$protein_id[i],
              rad51_prot_df$tx_id[i],
              nchar(rad51_prot_df$protein_sequence[i])))
}
cat("\n")

# ---- Step 2: Generate protein-to-genome map for each protein ----
# Using ensembldb::proteinToGenome()
# This maps every amino acid position to its genomic coordinates

all_maps <- list()

for (i in seq_len(nrow(rad51_prot_df))) {
  prot_id  <- rad51_prot_df$protein_id[i]
  prot_len <- nchar(rad51_prot_df$protein_sequence[i])

  cat("----------------------------------------------------------\n")
  cat(sprintf("Mapping protein: %s\n", prot_id))
  cat(sprintf("Transcript     : %s\n", rad51_prot_df$tx_id[i]))
  cat(sprintf("Protein length : %d amino acids\n\n", prot_len))

  # Create an IRanges object spanning the full protein (1 to length)
  prot_range <- IRanges(start = 1, end = prot_len, names = prot_id)

  # Map protein coordinates to genome
  genome_map <- tryCatch(
    proteinToGenome(prot_range, edb),
    error = function(e) {
      cat(sprintf("  Warning: Could not map %s: %s\n", prot_id, e$message))
      return(NULL)
    }
  )

  if (!is.null(genome_map) && length(genome_map) > 0) {
    map_df <- as.data.frame(genome_map[[prot_id]])
    map_df$protein_id  <- prot_id
    map_df$tx_id       <- rad51_prot_df$tx_id[i]
    map_df$protein_len <- prot_len

    # Reorder columns for clarity
    map_df <- map_df[, c("protein_id", "tx_id", "protein_len",
                          "seqnames", "start", "end", "width",
                          "strand", "protein_start", "protein_end",
                          "cds_ok")]

    cat("  Genomic coordinates for protein regions:\n")
    print(map_df)
    cat("\n")

    all_maps[[prot_id]] <- map_df

    # Save individual protein map
    out_file <- sprintf("RAD51_%s_protein_to_genome_map.csv", prot_id)
    write.csv(map_df, file = out_file, row.names = FALSE)
    cat(sprintf("  Saved: %s\n\n", out_file))

  } else {
    cat("  No mapping results returned.\n\n")
  }
}

# ---- Step 3: Also map each individual amino acid (per-residue map) ----
cat("==========================================================\n")
cat("Per-residue protein-to-genome map (first protein only)\n")
cat("==========================================================\n\n")

first_prot_id  <- rad51_prot_df$protein_id[1]
first_prot_len <- nchar(rad51_prot_df$protein_sequence[1])

cat(sprintf("Protein: %s (%d aa)\n", first_prot_id, first_prot_len))
cat("Mapping each amino acid to its genomic codon coordinates...\n\n")

# Create per-residue IRanges (each AA = 1 unit in protein space)
residue_ranges <- IRanges(
  start = seq(1, first_prot_len),
  end   = seq(1, first_prot_len),
  names = rep(first_prot_id, first_prot_len)
)

residue_map <- tryCatch(
  proteinToGenome(residue_ranges, edb),
  error = function(e) {
    cat(sprintf("Warning: %s\n", e$message))
    return(NULL)
  }
)

if (!is.null(residue_map) && length(residue_map) > 0) {
  residue_df <- do.call(rbind, lapply(seq_along(residue_map), function(j) {
    df <- as.data.frame(residue_map[[j]])
    df$aa_position <- j
    df$protein_id  <- first_prot_id
    df
  }))

  cat(sprintf("Total residue-level mapping entries: %d\n\n", nrow(residue_df)))
  cat("First 20 residues:\n")
  print(head(residue_df[, c("aa_position", "seqnames", "start", "end",
                              "strand", "protein_id")], 20))

  write.csv(residue_df,
            file = sprintf("RAD51_%s_per_residue_map.csv", first_prot_id),
            row.names = FALSE)
  cat(sprintf("\nPer-residue map saved: RAD51_%s_per_residue_map.csv\n",
              first_prot_id))
}

# ---- Step 4: Combined output ----
if (length(all_maps) > 0) {
  combined_df <- do.call(rbind, all_maps)
  write.csv(combined_df,
            file = "RAD51_all_proteins_genome_map.csv",
            row.names = FALSE)
  cat("\nCombined map for all proteins saved: RAD51_all_proteins_genome_map.csv\n")

  cat("\nSummary of genomic coverage per protein:\n")
  for (pid in names(all_maps)) {
    m <- all_maps[[pid]]
    chr    <- unique(m$seqnames)
    strand <- unique(m$strand)
    gstart <- min(m$start)
    gend   <- max(m$end)
    cat(sprintf("  %s: chr%s:%d-%d (%s strand), %d exonic segment(s)\n",
                pid, chr, gstart, gend, strand, nrow(m)))
  }
}

cat("\n==========================================================\n")
cat("Coordinate mapping complete.\n")
cat("Output files:\n")
cat("  - RAD51_<PROTEIN_ID>_protein_to_genome_map.csv  (per protein)\n")
cat("  - RAD51_<PROTEIN_ID>_per_residue_map.csv        (residue-level)\n")
cat("  - RAD51_all_proteins_genome_map.csv             (combined)\n")
cat("==========================================================\n")

# ---- Session Info ----
sessionInfo()
