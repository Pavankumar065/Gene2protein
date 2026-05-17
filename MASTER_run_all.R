# ============================================================
# RAD51 Gene Assignment - Master Script
# Run this file to execute all tasks in order
#
# Gene     : RAD51
# Ensembl  : ENSG00000051180
# Category : Cancer (DNA repair)
# Student  : [Your Name Here]
# Course   : [Your Course Code Here]
# Date     : [Today's Date]
# ============================================================

cat("\n")
cat("############################################################\n")
cat("##         RAD51 GENE ASSIGNMENT - MASTER RUNNER          ##\n")
cat("############################################################\n\n")

# ---- Task 1: IGV (manual - see 00_IGV_instructions.R) ----
cat("Task 1 (IGV): Open 00_IGV_instructions.R for step-by-step\n")
cat("              IGV setup and screenshot guide.\n")
cat("              Coordinates: chr15:40,700,000-40,760,000 (hg38)\n\n")

# ---- Task 2: List all transcripts ----
cat("############################################################\n")
cat("## TASK 2: Listing all RAD51 transcripts                  ##\n")
cat("############################################################\n\n")

source("01_RAD51_transcripts.R")

cat("\n\n")

# ---- Task 3: List all proteins ----
cat("############################################################\n")
cat("## TASK 3: Listing all RAD51 proteins                     ##\n")
cat("############################################################\n\n")

source("02_RAD51_proteins.R")

cat("\n\n")

# ---- Task 4: Protein to genome mapping ----
cat("############################################################\n")
cat("## TASK 4: Protein-to-genome coordinate mapping           ##\n")
cat("############################################################\n\n")

source("03_RAD51_protein_genome_map.R")

cat("\n\n")

# ---- Final summary ----
cat("############################################################\n")
cat("## ASSIGNMENT COMPLETE                                    ##\n")
cat("############################################################\n\n")

cat("Output files generated:\n")
cat("  Transcripts  : RAD51_transcripts.csv\n")
cat("  Proteins     : RAD51_proteins_summary.csv\n")
cat("               : RAD51_proteins.fasta\n")
cat("  Genome maps  : RAD51_<PROTEIN_ID>_protein_to_genome_map.csv\n")
cat("               : RAD51_<PROTEIN_ID>_per_residue_map.csv\n")
cat("               : RAD51_all_proteins_genome_map.csv\n\n")
cat("For IGV       : See 00_IGV_instructions.R\n\n")
