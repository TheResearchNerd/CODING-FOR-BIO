# Download and read the TSV file
url <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/sift.tsv"
sift_data <- read.delim(url, sep="\t", header=TRUE, col.names=c("Protein", "Amino_Acid", "sift_Score"))
#Confirm data is well aligned
str(sift_data)
head(sift_data)
View(sift_data)

#import 2nd dataset
url_2 <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/datasets/foldX.tsv"
fold_data <- read.delim(url_2, sep="\t", header=TRUE, col.names=c("Protein", "Amino_Acid", "foldX_Score"))
str(fold_data)
head(fold_data)
View(fold_data)

#Load libraries
library(dplyr)
library(ggplot2)

#Create a combined colum
sift_data$specific_Protein_aa <- paste(sift_data$Protein, sift_data$Amino_acid, sep="_")
fold_data$specific_Protein_aa <- paste(fold_data$Protein, fold_data$Amino_acid, sep="_")

#merge both datasets using Specific_Protein_aa
merged_data <- merge(sift_data, fold_data, by="specific_Protein_aa")

# Filter mutations that affect structure and function
deleterious_mutations <- merged_data %>%
  filter(sift_Score < 0.05 & foldX_Score > 2)

# View the first few rows
head(deleterious_mutations)

#Find deleterious amino acid by extracting the first letter of the amino acid (original_aa) from the Amino_acid column
names(deleterious_mutations)
deleterious_mutations$original_aa = substr(deleterious_mutations$Amino_Acid.x, 1, 1)

# Create frequency table
All_aa_frequency <- table(deleterious_mutations$original_aa)
All_aa_frequency_df <- as.data.frame(All_aa_frequency)
colnames(All_aa_frequency_df) <- c("Amino_Acid", "Frequency")

# View frequency table
print(All_aa_frequency_df)

# Generate Bar plot to represent aa frequency
ggplot(All_aa_frequency_df, aes(x=Amino_Acid, y=Frequency)) +
  geom_bar(stat="identity", fill="steelblue") +
  theme_minimal() +
  labs(title="Frequency of Amino Acids in Deleterious Mutations",
       x="Amino Acid",
       y="Frequency") +
  theme(axis.text.x = element_text(angle=45, hjust=1))

# Generate Pie chart to represent distribution frequency of aa
ggplot(All_aa_frequency_df, aes(x="", y=Frequency, fill=Amino_Acid)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  theme_void() +
  #labels = paste(round(All_aa_frequency_df/sum(All_aa_frequency_df$Frequency)*100), "%")
  labs(title="Frequency of Amino Acids in Deleterious Mutations")


# Find amino acids with more than 100 occurrences
Hundred_occurences_aa <- All_aa_frequency_df %>%
  filter(Frequency > 100)

# Calculate average SIFT and FoldX scores for frequent amino acids
aa_stats <- deleterious_mutations %>%
  group_by(original_aa) %>%
  summarise(
    avg_sift = mean(sift_Score),
    avg_foldx = mean(foldX_Score),
    count = n()
  ) %>%
  filter(count > 100)

# View statistics
print(aa_stats)


# Calculate combined impact score (this is one way to do it - you might want to adjust the method)
aa_impact <- deleterious_mutations %>%
  group_by(original_aa) %>%
  summarise(
    avg_impact = mean((1 - sift_Score) * foldX_Score),  # Lower sift and higher foldX indicate more impact
    count = n()
  ) %>%
  arrange(desc(avg_impact))

# View the results
print(aa_impact)


# For amino acids with more than 100 occurrences
structural_functional_analysis <- deleterious_mutations %>%
  group_by(original_aa) %>%
  summarise(
    count = n(),
    avg_structural_impact = mean(foldX_Score),
    avg_functional_impact = mean(sift_Score),
    percent_highly_deleterious = mean(sift_Score < 0.01 & foldX_Score > 3) * 100
  ) %>%
  filter(count > 100) %>%
  arrange(desc(count))

# View the analysis
print(structural_functional_analysis)

