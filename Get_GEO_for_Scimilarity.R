if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("GEOquery")
library(GEOquery)

# -------------------------------------------------------------------------
# Read data.frame with GEO ids
df <- read.csv("/Users/aashar4/Desktop/ScimilarityGEO.csv", header = T)

# -------------------------------------------------------------------------
# Convert a column to a comma-separated character string
name_string <- paste(df$geo_accession, collapse = ",")
print(name_string)
# Split the string into a vector
geo_ids <- strsplit(name_string, ",")[[1]]

# -------------------------------------------------------------------------
# Define the keywords
keywords <- c("PD1", "PD-1", "PD-L1", "immunotherapy", "Immune checkpoint")
# Create a regular expression to match any keyword
regex <- paste(keywords, collapse = "|")

# -------------------------------------------------------------------------=
get_abstracts <- function(geo_id) {
  gse <- getGEO(geo_id, GSEMatrix = FALSE)  # Download GEO dataset
  meta <- Meta(gse)  # Extract metadata
  return(meta$summary)  # Return the abstract (summary field)
}
abstracts <- sapply(geo_ids, get_abstracts)
abstracts_df <- as.matrix(abstracts)
# Filter rows that contain any of the keywords
filtered_abstracts_df <- abstracts_df[grepl(regex, abstracts_df[,1], ignore.case = TRUE), ]
write.table(names(filtered_abstracts_df), "/Users/aashar4/Desktop/abstracts.txt", sep = "    ")

# -------------------------------------------------------------------------
get_title <- function(geo_id) {
  gse <- getGEO(geo_id, GSEMatrix = FALSE)  # Download GEO dataset
  meta <- Meta(gse)  # Extract metadata
  return(meta$title)  # Return the abstract (title field)
}
titles <- sapply(geo_ids, get_title)
titles_df <- as.matrix(titles)
filtered_titles_df <- titles_df[grepl(regex, titles_df[,1], ignore.case = TRUE), ]
write.table(names(filtered_titles_df), "/Users/aashar4/Desktop/titles.txt", sep = "    ")
