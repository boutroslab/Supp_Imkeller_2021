generate_table <- function(name_list){
    # name of the file
    table_filename = name_list[1] 
    # cell line
    cellline_name = name_list[2] 
    # replicate
    replicate_name = name_list[3] 
    return_table = data.frame(read.table(as.character(table_filename), header=TRUE))
    names(return_table) <- c("sgRNA", paste(cellline_name, replicate_name, sep="_"))
    return(return_table)
}

file_list = list(
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/HCT116_screen/2017-03-02-HJH3HBGX2/EXTRACTED_readcount/pLibrary.txt", "HCT_library", "R1"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/HCT116_screen/2017-03-02-HJH3HBGX2/EXTRACTED_readcount/HCTAPCt17R1.txt", "HCT_APC_T17", "R1"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/HCT116_screen/2017-03-02-HJH3HBGX2/EXTRACTED_readcount/HCTapcT17R2.txt", "HCT_APC_T17", "R2"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/HCT116_screen/2017-03-02-HJH3HBGX2/EXTRACTED_readcount/HCTwtT14R1.txt", "HCT_WT_T14", "R1"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/HCT116_screen/2017-03-02-HJH3HBGX2/EXTRACTED_readcount/HCTwtT14R2.txt", "HCT_WT_T14", "R2"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/RKO_screen_re_seq/2017-04-18-HLCLLBGX2/EXTRACTED_readcount/RKO_WT_T20R1.txt", "RKO_WT_T20", "R1"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/RKO_screen_re_seq/2017-04-18-HLCLLBGX2/EXTRACTED_readcount/RKO_WT_T20R2.txt", "RKO_WT_T20", "R2"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/RKO_screen_re_seq/2017-04-18-HLCLLBGX2/EXTRACTED_readcount/RKOsgAPC_T20R1.txt", "RKOsgAPC_T20", "R1"),
    list("/home/katharina/Documents/raw_data/screens/GA_APC_lof/RKO_screen_re_seq/2017-04-18-HLCLLBGX2/EXTRACTED_readcount/RKOsgAPC_T20R2.txt", "RKOsgAPC_T20", "R2")
)

list_return_tables <- lapply(file_list, generate_table)
complete_table <- Reduce(function(...) merge(...,all=TRUE, by="sgRNA"),list_return_tables)  %>%
    separate(sgRNA, into = c("gene", "sequence"), sep="_", remove = FALSE)

complete_table$class <- "other"
complete_table[grepl("chr10Promiscuous",complete_table$sgRNA), 
    'class'] <- "Essential"

core_essential <- levels(
    read.table(
        "/home/katharina/Documents/raw_data/control_datasets/core_essential_genesCEGv2.txt")$V1)

for(gene in core_essential){
    complete_table[grepl(gene,complete_table$sgRNA), 
        'class'] <- "Essential"
}

complete_table <- complete_table %>%
    dplyr::rename(plasmid_library_R1 = HCT_library_R1,
        HCT116_APC_T17_R1 = HCT_APC_T17_R1,
        HCT116_APC_T17_R2 = HCT_APC_T17_R2,
        HCT116_WT_T14_R1 = HCT_WT_T14_R1,
        HCT116_WT_T14_R2 = HCT_WT_T14_R2,
        RKO_APC_T20_R1 = RKOsgAPC_T20_R1,
        RKO_APC_T20_R2 = RKOsgAPC_T20_R2)

write_csv(complete_table, "../external_data/CRISPR_screen_gRNA_counts.csv")