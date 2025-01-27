#!/bin/bash

# Step 1: Set the main directory using .research_config
# Extract the path to LOCAL_TIAN_2024_DATA_DIR from .research_config
MAIN_DIR=$(source ~/.research_config; echo $LOCAL_TIAN_2024_DATA_DIR)

# Check if MAIN_DIR is set
if [ -z "$MAIN_DIR" ]; then
  echo "Error: MAIN_DIR is not set. Check .research_config file."
  exit 1
fi

# Step 1.1: Create the main directory and raw subdirectory
RAW_DIR="${MAIN_DIR}raw/"
mkdir -p "$RAW_DIR"

# Check if necessary tools are installed
if ! command -v prefetch &> /dev/null || ! command -v fastq-dump &> /dev/null; then
  echo "Error: prefetch or fastq-dump not found. Ensure SRA Toolkit is installed."
  exit 1
fi

# Step 1.2: Prefetch SRR files
cd "$RAW_DIR" || exit
prefetch SRR31856734
prefetch SRR31856747

# Step 1.3: Dump SRR files into FASTQ format (split mode) and ensure target directories exist
for SRR_ID in SRR31856734 SRR31856747; do
  mkdir -p "$RAW_DIR/$SRR_ID"
  fastq-dump --split-files "$RAW_DIR/$SRR_ID" -O "$RAW_DIR/$SRR_ID"
done

# Step 1.4: Rename FASTQ files to Cell Ranger compatible format
for SRR_ID in SRR31856734 SRR31856747; do
  cd "$RAW_DIR/$SRR_ID" || exit
  if [ -f "${SRR_ID}_1.fastq" ]; then
    mv "${SRR_ID}_1.fastq" "${SRR_ID}_S1_L001_R1_001.fastq"
  else
    echo "Warning: ${SRR_ID}_1.fastq not found!"
  fi
  if [ -f "${SRR_ID}_2.fastq" ]; then
    mv "${SRR_ID}_2.fastq" "${SRR_ID}_S1_L001_R2_001.fastq"
  else
    echo "Warning: ${SRR_ID}_2.fastq not found!"
  fi
done

# Step 1.5: Download and extract the GRCh38 transcriptome database
cd "$RAW_DIR" || exit
if [ ! -f "refdata-gex-GRCh38-2020-A.tar.gz" ]; then
  wget https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz
fi
if [ ! -d "refdata-gex-GRCh38-2020-A" ]; then
  tar -zxvf refdata-gex-GRCh38-2020-A.tar.gz
fi
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

echo "All tasks completed successfully!"
