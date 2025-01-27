#!/bin/bash

MAIN_DIR=$(source ~/.research_config; echo $LOCAL_TIAN_2024_DATA_DIR)

# Verify that MAIN_DIR is set
if [ -z "$MAIN_DIR" ]; then
  echo "Error: MAIN_DIR is not set. Check .research_config file."
  exit 1
fi

RAW_DIR="${MAIN_DIR}raw/"
REFDATA_DIR="${RAW_DIR}refdata-gex-GRCh38-2020-A/"

# Step 2: Create processed directory
PROCESSED_DIR="${MAIN_DIR}processed/"
mkdir -p "$PROCESSED_DIR"
cd "$PROCESSED_DIR"

# Check if Cell Ranger is installed
if ! command -v cellranger &> /dev/null; then
  echo "Error: cellranger command not found."
  exit 1
fi

# Step 2.1: Run Cell Ranger count for each SRR
for SRR_ID in SRR31856734 SRR31856747; do
  cellranger count --id="${SRR_ID}" \
                   --transcriptome="$REFDATA_DIR" \
                   --fastqs="${RAW_DIR}/${SRR_ID}" \
                   --sample="${SRR_ID}" \
                   --create-bam=true \
                   --force
done

echo "Processing complete!"