#Extract reference matrix from celldex CIBERSORTx deconvolution
library(celldex)
ref <- fetchReference("novershtern_hematopoietic", "2024-02-26")
x <- df@data@listData[["logcounts"]]
y <- x@seed
z <- as.data.frame(y@seed)
colnames(z) <- ref@colData@rownames
rownames(z) <- ref@NAMES
write.csv(z, "expression_per_sample.csv")
meta <- cbind(ref@colData@rownames, 
              ref@colData@listData[["label.main"]], 
              ref@colData@listData[["label.fine"]])
write.csv(meta, "meta.csv")