library(tidyverse)
library(patchwork)
library(ggplotify)
library(pheatmap)
library(cowplot)
library("depmap")
library(clusterProfiler)
library(org.Hs.eg.db)
library(ggrepel)
library(msigdbr)
library(ReactomePA)
library(DESeq2)
library(limma)



        # colors
purple <- "#65338d"
pink <- "#d21f75"
green <- "#569d79"
blue <- "#4770b3"
darkblue <- "#033d9c"
darkyellow <- "#e57438"

gr1 <- "black"
gr2 <- "gray40"
gr3 <- "gray80"

#Wnt high/low
wnth_c <- gr2
wntl_c <- gr3

# cms colors
cms1_c <- "#F0E442" #yellow
cms2_c <- "#56B4E9" #blue
cms3_c <- "#CC79A7" #pink
cms4_c <- "#009E73" #green

# MSI colors
msih_c <- gr1
msil_c <- gr2
mss_c <- gr3

# APC truncation colors
apct0 <- gr3
apct1 <- gr2
apct2 <- gr1

# gene heatmap
ghm_high <- pink
ghm_mid <- "white"
ghm_low <- blue

# pathway heatmap
phm_high <- purple
phm_mid <- "white"
phm_low <- green

# HCT/RKO
hct_c <- purple
rko_c <- pink
# APC/WT
apc_c <- blue
wt_c <- "black"
# AAVS1/LARS2
aavs1_c <- gr2
lars2_c <- darkyellow
# Wnt3a
wnt3a_c <- green

# dotplotcols
dp_bg <- gr3
dp_mid <- "black"
dp_high <- green

# proximal distal
prox_c <- darkyellow
dist_c <- blue
rectum_c <- darkblue 

tcga_axin2_threshold <- 10.5
depmap_axin2_threshold <- 4.5

pathways_interest <- data.frame(Description =  c("Mitochondrial translation",
"Mitochondrial protein import",
"Mitochondrial tRNA aminoacylation",
"Mitochondrial Fatty Acid Beta-Oxidation",
"Mitochondrial biogenesis",
"Cholesterol biosynthesis",
"Chromatin organization",
"SLC-mediated transmembrane transport",
"Metabolism of amino acids and derivatives",
"Respiratory electron transport",
"mRNA Splicing",
"Eukaryotic translation",
"Cell Cycle, Mitotic",
"Protein ubiquitination",
"Nucleobase biosynthesis",
"Citric acid cycle (TCA cycle)",
"Cellular response to hypoxia",
### Cellular component
"GOCC_RESPIRASOME",
"GOCC_MITOCHONDRIAL_MATRIX",
"GOCC_CYTOSOLIC_RIBOSOME",
"GOCC_SPLICEOSOMAL_COMPLEX",
"GOCC_ORGANELLAR_RIBOSOME",
"GOCC_CYTOCHROME_COMPLEX"),
    type = c("Mitochondrial",
        "Mitochondrial",
        "Mitochondrial",
        "Mitochondrial",
        "Mitochondrial", 
        "Metabolic",
        "General",
        "Metabolic",
        "Metabolic",
        "Mitochondrial",
        "General",
        "General",
        "General",
        "General",
        "General",
        "Mitochondrial",
        "Metabolic",
        ### Cellular component
        "Mitochondrial",
        "Mitochondrial",
        "General",
        "General",
        "Mitochondrial",
        "Mitochondrial"))

genes_interest <- data.frame(SYMBOL = #c(#"SLC16A1","SLC16A3", 
    c("HK1", "HK2", "HK3", "G6PD", "GAPDH", "LDHA", 
    "PKM",
    "OPA1", "VDAC1", "LARS2", "MRPS31", "MTIF2",
    "IDH2", "PDHA1", "SUCLG1", "SUCLG2",
    "SLC1A5", "GOT2", "GLS"),
    pathway = c("Glycolysis", "Glycolysis", "Glycolysis", "Glycolysis", "Glycolysis", "Glycolysis", "Glycolysis", 
        #"Glycolysis", "Glycolysis", "Glycolysis",
        "Mitochondria", "Mitochondria", "Mitochondria", "Mitochondria", "Mitochondria",
        "TCA", "TCA", "TCA", "TCA",
        "AminoA", "AminoA", "AminoA")) %>%
    dplyr::mutate(label = SYMBOL)

# pathway colors 
glyco_c <- purple
mito_c <- pink
tca_c <- green
amino_c <- blue


# Pathways for dependency enrichment

### Reactome
pathways_interest_dep <-c("Mitochondrial translation",
"Mitochondrial protein import",
"Mitochondrial tRNA aminoacylation",
"Mitochondrial biogenesis",
"Chromatin organization",
"Respiratory electron transport",
"mRNA Splicing",
"Eukaryotic translation",
"Cell Cycle, Mitotic",
"Protein ubiquitination",
"Nucleobase biosynthesis",
"TCA cycle",
"Nucleobase biosynthesis",
"Transcription",
"Cellular response to hypoxia",
"Nucleobase biosynthesis",
"Oxygen-dependent proline hydroxylation of Hypoxia-inducible Factor Alpha",
"GOCC_RESPIRASOME",
"GOCC_MITOCHONDRIAL_MATRIX",
"GOCC_CYTOSOLIC_RIBOSOME",
"GOCC_SPLICEOSOMAL_COMPLEX",
"GOCC_ORGANELLAR_RIBOSOME",
"GOCC_CYTOCHROME_COMPLEX")
