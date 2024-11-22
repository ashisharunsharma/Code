Cytokine <- read.csv('Raw_data_PASC_AS.csv', header = T, row.names = 1)
dim(Cytokine)

Cytokine <- subset(Cytokine, Time != "T0" & Time != "T1")
dim(Cytokine)

Cytokine_values <- Cytokine[,c(4:35)]

colorPalette <- c("blue","blue","blue","blue", "white", "red", "red", "red", "red")
colorPalette <- colorRampPalette(colors = colorPalette)(100)

matAnnot <- Cytokine[,c(2:3)]

ann_colors <- list(Time = c(T0 = "purple", T1 = "lightblue", T2 = "navy"), 
                                 PASC = c(nonPASC = "darkgreen", PASC = "gold"))

library(pheatmap)
pheatmap(mat = t(log(Cytokine_values+0.1)),
         color = colorPalette,
         scale = "row",
         cellwidth = 1,
         cellheight = 6,
         cluster_rows = T,
         cluster_cols = T,
         annotation = matAnnot,
         show_rownames = T,
         show_colnames = F,
         border_color = NA,
         clustering_method = "ward.D2",
         clustering_distance_rows = "canberra",
         clustering_distance_cols = "canberra",
         fontsize = 6,
         fontsize_row = 6,
         fontsize_col = 6, cutree_cols = 2, annotation_colors = ann_colors,
         cutree_rows = 3)
