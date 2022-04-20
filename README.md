# Supp_Imkeller_2021

# Software and supplementary information for the publication by Imkeller et al.

The directory contains the supplementary information as well as the software necessary to run the analysis and reproduce figures of the following publication: **Katharina Imkeller, Giulia Ambrosi, Nancy Klemm, Ainara Claveras Cabezudo, Luisa Henkel, Wolfgang Huber, Michael Boutros (2021). Metabolic balance in colorectal cancer is maintained by optimal Wnt signaling levels.**

## Folder structure

The repository is composed by a number of subdirectories, which will be introduced in the following. Please note that due to the large size of the TCGA and DepMap datasets, we do not include the data in the github repositories. You will however find all scripts to assemble the respective datasets in the subfolder `data_preparation/`.

### ./external_data/

The `external_data/` subfolder contains datasets that were generated in the context of the project and are not published anywhere else. The files `depmap_msi_status.txt.gz` and `zhan_cms.csv.gz` contain metainformation on depmap cell lines previously collected by Zhan et al. 2021 (https://doi.org/10.1002/ijc.33393). The file `RKO_APC_microarray_resultstable.RData` contains the results from the microarray experiment conducted in this study. The file `CRISPR_screen_gRNA_counts.csv.gz` contains raw gRBNA count data from the CRISPR screens conducted in this study.

In addition, you will have to download the following datasets into the `external_data/` folder in order to be able to run the complete analysis.

`wget http://linkedomics.org/cptac-colon/Human__CPTAC_COAD__PNNL__Proteome__TMT__03_01_2017__BCM__Gene__Tumor_Normal_log2FC.cct`

`wget http://linkedomics.org/cptac-colon/Human__CPTAC_COAD__UNC__RNAseq__HiSeq_RNA__03_01_2017__BCM__Gene__BCM_RSEM_UpperQuartile_log2.cct.gz`

`wget https://www.cell.com/cms/10.1016/j.cell.2019.03.030/attachment/87317e5c-393a-47d6-9c62-cb4fee1d653b/mmc1.xlsx`
Extract the B-clinicalData table from `mmc1.xlsx` as `NIHMS1524432-supplement-8.csv`.

### ./data_preparation/

**TCGA_metadata_mutations.Rmd**
The script uses the Bioconductor packages TCGAbiolinks and GenomicDataCommons to access RNA expression, mutational and metadata from the TCGA-COAD and TCGA-READ datasets. Raw RNA expression quantification files are downloaded into subdirectories of `./GDCdata/TCGA-READ/` and `./GDCdata/TCGA-COAD/`. The corresponding html file including package versions used in the manuscript is available as `TCGA_metadata_mutations.html`. The metadata and mutation data is stored in the files `../r_data/TCGA_COAD_READ_mutations_mutect.RData` and `../r_data/TCGA_COAD_READ_rnaseq_annotation.RData`.

**TCGA_all_counts_DESeq2.Rmd**
The script uses the Bioconductor packages DESeq2 to summarize RNA expression data from the previously downloaded raw expression measures. The corresponding html file including package versions used in the manuscript is available as `TCGA_all_counts_DESeq2.html`. Summarized normalized and raw RNA sequencing counts are stored in the files `../r_data/TCGA_allcounts_normalized.RData` and `../r_data/TCGA_allcounts_raw.RData`.

**TCGA_classify_CMS_CMSclassifier.Rmd**
The script uses the R packages CMSclassifier to classify TCGA-COAD and TCGA-READ samples into consensus molecular subtypes. The corresponding html file including package versions used in the manuscript is available as `TCGA_classify_CMS_CMSclassifier.html`. CMS classification results are stored in `../r_data/TCGA_CMS_classification_CMSclassifier.RData`.

**prepare_DepMap_data.Rmd**
The script uses the Bioconductor packages depmap to access RNA expression, mutational, gene dependency, proteomic and metadata from the depmap project. The corresponding html file including package versions used in the manuscript is available as `prepare_DepMap_data.html`. The depmap data concerning colorectal cancer cell lines is stored in `../r_data/depmap_rna_prot_crispr.RData`, `../r_data/depmap_metadata.RData` and `../r_data/depmap_mutations.RData`.

### ./differential_analysis/

Note that the Differential analysis scripts can only be run after classification of TCGA samples into Wnt-low and Wnt-high, which is implemented in the script `main_figures/Figure1.Rmd`.

**definitions_analysis_visualization.R**
R script containing variables that are frequently used in other analysis or visualization scripts (thresholds, sizes, colors....).

**wnt_low_high_differential_model.Rmd**
This script implements the quantification of differential transcript and protein expression as well as genetic dependency data in the different datasets. The results are stored in the following files:

TCGA transcriptomics: `../r_data/DESeq2_dds_wnthigh_wntlow_normal.RData`, `../r_data/DESeq2_res_high_low.RData`, `../r_data/DESeq2_res_high_norm.RData`, `../r_data/DESeq2_res_low_norm.RData`

TCGA proteomics: `../r_data/tcga_prot_res_high_low.RData`

DepMap transcriptomic: `../r_data/depmap_transcriptomics_limma_wntgroup.RData`

DepMap proteomic: `../r_data/depmap_proteomics_limma_wntgroup.RData`

DepMap gene dependency: `../r_data/depmap_dependency_limma_wntgroup.RData`


**gsea_functions.R**
This script contains the common definition of functions utilized for gene set enrichment analysis.

**wnt_low_high_gsea_gene_dependencies.Rmd**
Gene set enrichment analysis for genetic dependency data. This script also generates the subfigures of Figure S3.

**wnt_low_high_gsea_transcriptomic_proteomic.Rmd**
Gene set enrichment analysis for transcriptomic and proteomic data. This script also generates the subfigures of Figure S3.

**analyze_CRISPR_screen.Rmd**
This script quantifies differential gene essentiality in the APCtrunc and APCwt cell lines that were screened in our CRISPR screening experiment.

### ./r_data/

This folder is used to store all intermediate R objects generated and used in the scripts described above.

### ./main_figures/

The folder contains scripts to generate main figures from the previously performed computational analysis. Figure 5 is not included because it exclusively contains experimental data.

### ./supplementary material/

**crispr_screen_qc.Rmd** 
Script that produces the supplementary Figure related to CRISPR screen quality control.

**supplementary_figures.tex** 
LaTex file to generate the `supplementary_figures.pdf` file.

