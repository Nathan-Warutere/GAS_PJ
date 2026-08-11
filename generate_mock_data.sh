#!/bin/bash
# ==============================================================================
# S. pyogenes Mock Data & Database Reference Generator
# Run this script using: bash generate_mock_data.sh
# ==============================================================================

echo "=== Creating Mock Raw-Data Directory and Subsampled FastQ Files ==="
mkdir -p Raw-Data

# Generate valid mock Forward Reads (R1)
cat << 'EOF' > Raw-Data/R1.fq.gz
@M001:1:000000000-A8YRL:1:1101:10000:1000 1:N:0:1
ATGACGACGATCGATCGATCGATCGATCGATCGATCGATCGATC
+
CCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
EOF

# Generate valid mock Reverse Reads (R2)
cat << 'EOF' > Raw-Data/R2.fq.gz
@M001:1:000000000-A8YRL:1:1101:10000:1000 2:N:0:1
GATGATCGATCGATCGATCGATCGATCGATCGATCGATCGTCAT
+
CCCCCGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
EOF

echo "=== Creating Mock Accessory Database Requirements ==="
# Create placeholder files to prevent BBTools or alternative setups from crashing
echo ">Illumina_Adapter_Sequence" > adapters.fa
echo "AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT" >> adapters.fa

echo ">human_hg38_mock_chromosome" > human_hg38.fa
echo "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN" >> human_hg38.fa

echo ">spyogenes_mock_reference" > spyogenes_ref.gbk
echo "LOCUS       MOCK_REF                60 bp    DNA     linear   BCT 11-AUG-2026" >> spyogenes_ref.gbk
echo "ORIGIN" >> spyogenes_ref.gbk
echo "        1 atgacgacga tcgatcgatc gatcgatcga tcgatcgatc gatcgatcga tcgatcgatc" >> spyogenes_ref.gbk
echo "//" >> spyogenes_ref.gbk

# Create mock databases to bypass software indexing limits during testing
mkdir -p minikraken2_v2 seroba_db
touch minikraken2_v2/hash.k2d minikraken2_v2/opts.k2d minikraken2_v2/taxo.k2d
touch seroba_db/annotation.txt

# Create structural files for comparative steps
mkdir -p Assembly_Output
echo ">scaffold_1" > Assembly_Output/scaffolds.fasta
echo "ATGACGACGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATCGATC" >> Assembly_Output/scaffolds.fasta
echo '##gff-version 3' > Assembly_Output/sample1.gff

# Create phenotypic layout mock tracking for Scoary
echo "Name,Trait_AMR" > clinical_traits.csv
echo "sample1,1" >> clinical_traits.csv

echo "=============================================================================="
echo "🎉 Mock test data environment successfully generated!"
echo "You can now run 'bash pipeline.sh' to safely test your repository framework."
echo "=============================================================================="

