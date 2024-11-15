CITN <- readRDS("/Users/aashar4/Documents/2022-2024/ManuscriptCITN12/scRNAseq/CITN_scRNAseq_from_Adam/PBMC_seurat_object_with_module_scores.RDS")
CITN@assays$RNA$scale.data <- NULL
SaveH5Seurat(CITN, overwrite = TRUE)
Convert("SeuratProject.h5Seurat", dest = "h5ad", assay = "RNA")