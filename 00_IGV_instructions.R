# ============================================================
# Assignment: RAD51 Gene Analysis
# Task 1: IGV View of RAD51 Gene
# Gene: RAD51 | Ensembl ID: ENSG00000051180 | Chr 15q15.1
# ============================================================

# ----------------------------------------------------------
# HOW TO VIEW RAD51 IN IGV (Integrative Genomics Viewer)
# ----------------------------------------------------------
#
# STEP 1: Download & Install IGV
#   - Visit: https://igv.org/doc/desktop/
#   - Download the version for your OS (Windows/Mac/Linux)
#   - Install locally on your computer (NOT Google Drive)
#
# STEP 2: Launch IGV and set genome
#   - Open IGV
#   - Go to: Genomes > Load Genome from Server
#   - Select: Human (hg38) / GRCh38
#
# STEP 3: Navigate to RAD51
#   Option A (Gene symbol):
#     - In the search bar at the top, type:  RAD51
#     - Press Enter
#
#   Option B (Ensembl ID):
#     - Type:  ENSG00000051180
#     - Press Enter
#
#   Option C (Genomic coordinates):
#     - Type:  chr15:40,700,000-40,760,000
#     - Press Enter  (this shows the full RAD51 locus)
#
# STEP 4: Add gene annotation track
#   - Go to: File > Load from Server
#   - Under "Annotations" > select "Ensembl Genes" or "UCSC Genes"
#   - The gene structure (exons, introns, UTRs) will appear
#
# STEP 5: Zoom and explore
#   - Use +/- to zoom in/out
#   - Right-click on the gene track > "Expanded" to see all transcripts
#   - You should see multiple transcript isoforms of RAD51
#
# STEP 6: Take a screenshot
#   - File > Save Image (PNG or SVG)
#   - Name it:  RAD51_IGV_view.png
#
# ----------------------------------------------------------
# RAD51 GENOMIC INFORMATION (for reference)
# ----------------------------------------------------------
#
#   Gene symbol      : RAD51
#   Ensembl ID       : ENSG00000051180
#   Chromosome       : 15
#   Cytogenetic band : 15q15.1
#   Strand           : +  (forward)
#   Genome build     : GRCh38 / hg38
#   Approx. location : chr15:40,700,000 - 40,760,000
#
#   Biological role  :
#     RAD51 is a key recombinase involved in homologous
#     recombination (HR) repair of DNA double-strand breaks (DSBs).
#     It forms nucleoprotein filaments on ssDNA, enabling strand
#     invasion and template-guided repair. Mutations/dysregulation
#     are associated with breast/ovarian cancer susceptibility.
#
# ----------------------------------------------------------
# EXPECTED IGV VIEW
# ----------------------------------------------------------
#
#   You should see:
#   [ Chromosome 15 ideogram bar at top ]
#
#   Gene track will show:
#   - Thick blue boxes = CDS exons (coding sequence)
#   - Thin boxes       = UTR regions (5' and 3')
#   - Horizontal lines = introns (with directional arrows showing strand)
#   - Multiple rows    = different transcript isoforms
#
#   Transcript isoforms visible (approx.):
#   - RAD51-201 (ENST00000366868) — principal coding isoform
#   - RAD51-202, -203, -204, -205 — alternative isoforms
#   - Some non-coding/retained intron isoforms
#
# ----------------------------------------------------------
# OPTIONAL: Load additional data tracks
# ----------------------------------------------------------
#
#   For richer visualization, also load:
#   1. ClinVar variants:
#      File > Load from Server > Variants > ClinVar
#
#   2. gnomAD variants:
#      File > Load from Server > Variants > gnomAD
#
#   3. ENCODE regulatory data:
#      File > Load from Server > Regulation > ENCODE
#
# ----------------------------------------------------------
