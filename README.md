# Yao 2023 Data Repository

This repository contains code and data structure for importing and processing the **Yao 2023 single-cell RNA sequencing data**. The experiments in Yao et al. involve **19 runs** for conventional CRISPER KO screens conducted on **THP-1 cell line**. 

Data from the runs are labeled from **SRR22814695** to **SRR22814713**

The pipeline includes downloading raw data, converting to FASTQ files, preprocessing with **Cell Ranger**, and organizing processed data for downstream analysis.

---

## Directory Structure

After running the pipeline, the directory structure under the **`yao-2023`** directory is organized as follows:

```plaintext
yao-2023
├── raw
│   ├── SRR22814695
│   │   └── SRR22814695.sra
│   ├── SRR22814696
│   │   └── SRR22814695.sra
│   └── refdata-gex-GRCh38-2020-A
├── processed
│   ├── SRR22814695
│   │   ├── outs
│   │   │   ├── metrics_summary.csv
│   │   │   ├── filtered_feature_bc_matrix.h5
│   │   │   ├── molecule_info.h5
│   │   │   └── other_files...
│   ├── SRR22814696
│   │   ├── outs
│   │   │   ├── metrics_summary.csv
│   │   │   ├── filtered_feature_bc_matrix.h5
│   │   │   ├── molecule_info.h5
│   │   │   └── other_files...
```

---

## Pipeline Options

To run the entire pipeline (downloading and processing) in one step, use:
```bash
qsub -l m_mem_free=64G integrated_pipeline.sh
```

---

## How to Run

1. **Clone the repository**:
   ```bash
   git clone git@github.com:Katsevich-Lab/import-yao-2023.git
   cd import-yao-2023
   ```

2. **Set up the environment**:
   Ensure `.research_config` contains the following:
   ```bash
   export LOCAL_YAO_2023_DATA_DIR="/path/to/yao-2023/"
   ```

3. **Submit the job**:
   To run the entire pipeline (downloading and processing) in one step, use:
```bash
qsub -l m_mem_free=64G integrated_pipeline.sh
```

---

## Notes

- Ensure all dependencies are installed and accessible in your `$PATH`:
  - `prefetch`, `fastq-dump`, `cellranger`, and `wget`.
- Sufficient memory (≥64GB recommended) and disk space are required to process the data.

---

## Citation

If using this pipeline or data for your work, please cite:
- **Yao et al., 2023**: DOI: 10.1038/s41587-023-01964-9

---

### **END** 

---
