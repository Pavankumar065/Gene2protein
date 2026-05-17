# RAD51 Gene Analysis — Bioinformatics Assignment

**Gene:** RAD51 | **Ensembl ID:** ENSG00000051180 | **Location:** chr15q15.1 (GRCh38)
**Category:** Cancer | **Function:** DNA double-strand break repair via homologous recombination

---

## Overview

This repository contains all files for the RAD51 gene assignment covering four tasks:

1. IGV visualization of the RAD51 locus
2. Listing all transcripts using R / `ensembldb`
3. Listing all protein products using R / `ensembldb`
4. Generating protein-to-genome coordinate maps for each protein product

---

## File Structure

```
RAD51_assignment/
├── README.md                          ← You are here
├── MASTER_run_all.R                   ← Run this to execute all tasks at once
├── 00_IGV_instructions.R              ← Task 1: IGV setup and navigation guide
├── 01_RAD51_transcripts.R             ← Task 2: List all transcripts
├── 02_RAD51_proteins.R                ← Task 3: List all protein products
├── 03_RAD51_protein_genome_map.R      ← Task 4: Protein-to-genome mapping
└── RAD51_Assignment_Report.html       ← Full visual report (open in browser)
```

### Output files generated when scripts are run

```
RAD51_transcripts.csv                          ← All transcripts (Task 2)
RAD51_proteins_summary.csv                     ← Protein summary table (Task 3)
RAD51_proteins.fasta                           ← Protein sequences in FASTA format (Task 3)
RAD51_<PROTEIN_ID>_protein_to_genome_map.csv   ← Per-protein genome map (Task 4)
RAD51_<PROTEIN_ID>_per_residue_map.csv         ← Per-amino-acid genome map (Task 4)
RAD51_all_proteins_genome_map.csv              ← Combined map for all proteins (Task 4)
```

---

## Requirements

### R packages

```r
# CRAN
install.packages("BiocManager")

# Bioconductor
BiocManager::install(c("ensembldb", "EnsDb.Hsapiens.v86", "AnnotationFilter",
                        "GenomicRanges", "IRanges"))
```

- **R version:** ≥ 4.0 recommended
- **Ensembl database:** `EnsDb.Hsapiens.v86` (GRCh38, Ensembl release 86)
- **Reference:** [ensembldb coordinate mapping vignette](https://www.bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html)

### IGV (Task 1 only)

- Download from: https://igv.org/doc/desktop/
- Must be installed **locally** on your computer (not on Google Drive)
- Genome: **hg38 / GRCh38**

---

## How to Run

### Option A — Run everything at once

```r
source("MASTER_run_all.R")
```

This sources all three R scripts in order and prints progress to the console.

### Option B — Run tasks individually

```r
source("01_RAD51_transcripts.R")       # Task 2
source("02_RAD51_proteins.R")          # Task 3
source("03_RAD51_protein_genome_map.R") # Task 4
```

### Task 1 (IGV) — Manual steps

1. Open IGV and select genome **Human (hg38)**
2. In the search bar, enter: `chr15:40,700,000-40,760,000`
3. Load gene annotations: *File → Load from Server → Ensembl Genes*
4. Right-click the track → **Expanded** to see all isoforms
5. Save screenshot: *File → Save Image → `RAD51_IGV_view.png`*

See `00_IGV_instructions.R` for full step-by-step guidance.

---

## Gene Background

RAD51 encodes a core recombinase of the homologous recombination (HR) DNA repair pathway. Upon DNA double-strand breaks (DSBs), RAD51 forms nucleoprotein filaments on single-stranded DNA, mediating strand invasion into a homologous template for error-free repair. It is a paralogue of bacterial RecA.

**Clinical relevance:** Dysregulation of RAD51 is associated with genomic instability and susceptibility to breast and ovarian cancers. It is functionally linked to BRCA1 and BRCA2, which load RAD51 onto DSB sites.

| Property | Value |
|---|---|
| Gene symbol | RAD51 |
| Ensembl ID | ENSG00000051180 |
| UniProt ID | Q06609 |
| Chromosome | 15q15.1 |
| Strand | + (forward) |
| Genomic span | ~41.7 kb |
| Canonical protein | 339 aa, ~37.3 kDa |

---

## Reference

- Satya's course assignment instructions
- [ensembldb Bioconductor vignette — Coordinate Mapping](https://www.bioconductor.org/packages/release/bioc/vignettes/ensembldb/inst/doc/coordinate-mapping.html)
- [Ensembl entry for RAD51](https://www.ensembl.org/Homo_sapiens/Gene/Summary?g=ENSG00000051180)
- [UniProt Q06609](https://www.uniprot.org/uniprot/Q06609)
