library(tidyverse)
library(msigdbr)
library(org.Hs.eg.db)
library(ReactomePA)

## reactome + GO cellular component

#Function to perform Reactom GSEA

performreactGSEA <- function(res, alpha=0.05, stat = FALSE, t = FALSE) {
    # generate a sorted list according to stat
    if (stat) {sortlist <- res$stat} else if (t) {sortlist <- res$t} else {
        if (!is.null(res$lfc)) {sortlist <- res$lfc} else {sortlist <- res$logFC}
    }
    names(sortlist) <- res$ENTREZID
    
    set.seed(42)
    y <- gsePathway(sort(sortlist, decreasing = TRUE), pvalueCutoff=alpha,
        pAdjustMethod="BH", verbose=FALSE)
    y
}

performKEGGGSEA <- function(res, alpha=0.05, stat = FALSE, t = FALSE) {
    # generate a sorted list according to stat
    if (stat) {sortlist <- res$stat} else if (t) {sortlist <- res$t} else {
        if (!is.null(res$lfc)) {sortlist <- res$lfc} else {sortlist <- res$logFC}
    }
    names(sortlist) <- res$ENTREZID
    
    set.seed(42)
    y <- gseMKEGG(sort(sortlist, decreasing = TRUE), pvalueCutoff=alpha,
        pAdjustMethod="BH", verbose=FALSE)
    y
}


# Function to perform MSigDB Hallmark/ CC GSEA

hs_H <- msigdbr(species = "Homo sapiens", category = "H")

hs_CC <- msigdbr(species = "Homo sapiens", category = "C5", subcategory = "CC")

hs_BP <- msigdbr(species = "Homo sapiens", category = "C5", subcategory = "BP")

performmsigdbGSEA <- function(res, alpha=0.05, type = "H", stat=FALSE, t = FALSE) {
    
    if (stat) {sortlist <- res$stat} else if (t) {sortlist <- res$t} else {
        if (!is.null(res$lfc)) {sortlist <- res$lfc} else {sortlist <- res$logFC}
    }
    names(sortlist) <- res$ENTREZID
    
    if (type == "H") {
        t2g <- hs_H %>% dplyr::select(gs_name, entrez_gene)
    } else if (type == "CC") {
        t2g <- hs_CC %>% dplyr::select(gs_name, entrez_gene)
    } else if (type == "BP") {
        t2g <- hs_BP %>% dplyr::select(gs_name, entrez_gene)
    }
    
    set.seed(42)
    y <- GSEA(sort(sortlist, decreasing = TRUE), 
        TERM2GENE= t2g, verbose=FALSE,  
        pvalueCutoff = alpha)
    y
}

