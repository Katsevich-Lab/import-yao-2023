# Tian 2024 Data Repository

This repository contains code and data structure for importing and processing the **Tian 2024 single-cell RNA sequencing data**. The experiments in Tian et al. involve **two similar single-cell RNA sequencing (scRNA-seq) experiments** conducted on **Human PBMC (Peripheral Blood Mononuclear Cells)** from 16 individuals. 

Data from the two experiments are labeled as:
- **SRR31856734** 
- **SRR31856747**

The pipeline includes downloading raw data, converting to FASTQ files, preprocessing with **Cell Ranger**, and organizing processed data for downstream analysis.

---

## Directory Structure

After running the pipeline, the directory structure under the **`tian-2024`** directory is organized as follows:

```plaintext
tian-2024
├── raw
│   ├── SRR31856734
│   │   ├── SRR31856734_S1_L001_R1_001.fastq
│   │   └── SRR31856734_S1_L001_R2_001.fastq
│   ├── SRR31856747
│   │   ├── SRR31856747_S1_L001_R1_001.fastq
│   │   └── SRR31856747_S1_L001_R2_001.fastq
│   └── refdata-gex-GRCh38-2020-A
├── processed
│   ├── SRR31856734
│   │   ├── outs
│   │   │   ├── metrics_summary.csv
│   │   │   ├── filtered_feature_bc_matrix.h5
│   │   │   ├── molecule_info.h5
│   │   │   └── other_files...
│   ├── SRR31856747
│   │   ├── outs
│   │   │   ├── metrics_summary.csv
│   │   │   ├── filtered_feature_bc_matrix.h5
│   │   │   ├── molecule_info.h5
│   │   │   └── other_files...
├── README.md
```

---

## Pipeline Options

You can run the pipeline either in a single step or split into two steps:

### **Option 1: One-Step Execution**
To run the entire pipeline (downloading and processing) in one step, use:
```bash
qsub -l m_mem_free=64G integrated_pipeline.sh
```

### **Option 2: Two-Step Execution**
You can also run the pipeline in two separate steps:

#### **Step 1: Download Data**
```bash
qsub 1_download_data.sh
```

#### **Step 2: Process Data**
After the data has been downloaded, process it with:
```bash
qsub -l m_mem_free=64G 2_process_data.sh
```

---

## How to Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/<your-repo>/tian-2024.git
   cd tian-2024
   ```

2. **Set up the environment**:
   Ensure `.research_config` contains the following:
   ```bash
   export LOCAL_TIAN_2024_DATA_DIR="/path/to/tian-2024/"
   ```

3. **Submit the job**:
   Use one of the pipeline options above to run the workflow.

---

## Notes

- Ensure all dependencies are installed and accessible in your `$PATH`:
  - `prefetch`, `fastq-dump`, `cellranger`, and `wget`.
- Sufficient memory (≥64GB) and disk space are required to process the data.

---

## Citation

If using this pipeline or data for your work, please cite:
- **Tian et al., 2024**: DOI: 10.1038/s41588-024-02019-8

---

### **END** 

---