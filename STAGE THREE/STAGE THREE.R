# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(cluster)
library(factoextra)

#Load the data
url <- "https://raw.githubusercontent.com/PacktPublishing/Machine-Learning-in-Biotechnology-and-Life-Sciences/refs/heads/main/datasets/dataset_wisc_sd.csv"
cancer_data <- read.csv(url)

# Examine the structure of the data
str(cancer_data)
head(cancer_data)
summary(cancer_data)
View(cancer_data)

# Check for missing values
sum(is.na(cancer_data))
missing_cols <- colSums(is.na(cancer_data))
print(missing_cols[missing_cols > 0])
print(sum(missing_cols > 0))

missing_rows <- rowSums(is.na(cancer_data))
print(sum(missing_rows > 0))

#since there are 7 NAs,I used mean imputation for the missing values
cancer_data_imputed <- cancer_data
for(col in colnames(cancer_data)) {
  if(sum(is.na(cancer_data[[col]])) > 0) {
    # For numeric columns, mean imputation is used
    if(is.numeric(cancer_data[[col]])) {
      col_mean <- mean(cancer_data[[col]], na.rm = TRUE)
      cancer_data_imputed[[col]][is.na(cancer_data_imputed[[col]])] <- col_mean
      print(paste("Imputed missing values in column", col, "with mean:", col_mean))
    } 
    # For categorical columns, use mode imputation
    else {
      col_mode <- names(sort(table(cancer_data[[col]]), decreasing = TRUE))[1]
      cancer_data_imputed[[col]][is.na(cancer_data_imputed[[col]])] <- col_mode
      print(paste("Imputed missing values in column", col, "with mode:", col_mode))
    }
  }
}

# Confirm no more missing values
print(sum(is.na(cancer_data_imputed)))

# Processing the data
# check column names to identify the target variable
colnames(cancer_data_imputed)

# Separate features from target, diagnosis and id will be target, while other columns will be features
features <- cancer_data_imputed %>% select(-diagnosis, -id) 
target <- cancer_data_imputed$diagnosis

# Convert target(diagnosis) to factor
target <- factor(
  target, 
  levels = c("B", "M"), 
  labels = c("Benign", "Malignant")
)
#check target
str(target)
levels(target)
table(target)

# Standardize features
# One of the columns was stored as character, so it needs to be converted to numeric before standardizing
features$concave.points_worst <- as.numeric(features$concave.points_worst)

# Check for NA values introduced by coercion
sum(is.na(features$concave.points_worst)) #gave 1 NA

# Get row number with NA in 'concave.points_worst'
na_row <- which(is.na(features$concave.points_worst))
print(na_row)
wrong_value <- cancer_data_imputed$concave.points_worst[na_row]
print(wrong_value)

#Replace "0.1865\\n\\n" with "0.1865" (adjust based on your data)
features$concave.points_worst[na_row] <- 0.1865  # Replace with correct numeric value
str(features$concave.points_worst)

# Standardize features
scaled_features <- scale(features) 

#EDA: Visualize distributions by plotting few important features
ggplot(cancer_data_imputed, aes(x = diagnosis, y = radius_mean, fill = diagnosis)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Radius Mean by Diagnosis")

ggplot(cancer_data_imputed, aes(x = diagnosis, y = texture_mean, fill = diagnosis)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Texture Mean by Diagnosis")

#Correlation matrix heatmap
cor_matrix <- cor(features)
heatmap(cor_matrix, 
        col = colorRampPalette(c("blue", "white", "red"))(100),
        main = "Feature Correlation Heatmap")

#PCA
pca_result <- prcomp(scaled_features, center = TRUE, scale. = TRUE)
pca_summary <- summary(pca_result) # Examine variance explained
print(pca_summary)

# Print variance explained by first few components
print("Proportion of variance explained by the first 5 principal components:")
print(pca_summary$importance[2, 1:5])
print(paste("Cumulative proportion for first 5 components:", 
            round(pca_summary$importance[3, 5] * 100, 2), "%"))

# Create a scree plot to visualize explained variance
fviz_eig(pca_result, 
         addlabels = TRUE, 
         ylim = c(0, 50),
         main = "Percentage of Explained Variance by Principal Components",
         xlab = "Principal Component", 
         ylab = "% of Variance")

# Visualize PCA results with diagnosis colors
fviz_pca_ind(pca_result, 
             geom.ind = "point",
             col.ind = target,
             addEllipses = TRUE,
             legend.title = "Diagnosis")


# K-means clustering
set.seed(123)  # For reproducibility
# Determining optimal number of clusters with elbow method
fviz_nbclust(scaled_features, kmeans, method = "wss")

# Perform k-means with optimal k (let's use k=2 for benign or malignant)
kmc_result <- kmeans(scaled_features, centers = 2, nstart = 25)

# Visualize the clustering result
fviz_cluster(list(data = scaled_features, cluster = kmc_result$cluster),
             geom = "point",
             ellipse.type = "convex",
             palette = "jco",
             main = "K-means Clustering (k=2)")

# Create a comparison table to evaluate clustering vs. actual diagnosis
comparison_table <- table(kmc_result$cluster, target)
print(comparison_table)

# Calculate accuracy to determine which cluster corresponds to level of diagnosis
if(comparison_table[1,1] + comparison_table[2,2] > comparison_table[1,2] + comparison_table[2,1]) {
  accuracy <- (comparison_table[1,1] + comparison_table[2,2]) / sum(comparison_table)
} else {
  accuracy <- (comparison_table[1,2] + comparison_table[2,1]) / sum(comparison_table)
}
print(paste("Clustering accuracy:", round(accuracy * 100, 2), "%"))

# Check for other potential subclasses by using more clusters
set.seed(123)
kmc_result_4 <- kmeans(scaled_features, centers = 4, nstart = 25)

# Visualize 4-cluster result
fviz_cluster(list(data = scaled_features, cluster = kmc_result_4$cluster),
             geom = "point",
             ellipse.type = "convex",
             palette = "jco",
             main = "K-means Clustering (k=4)")

# Visualize the 4 clusters in PCA space
fviz_pca_ind(pca_result,
             geom.ind = "point", 
             col.ind = as.factor(kmc_result_4$cluster),
             addEllipses = TRUE,
             legend.title = "Cluster")

# Compare the 4 clusters with the diagnosis
comparison_table_4 <- table(kmc_result_4$cluster, target)
print(comparison_table_4)

# Get cluster centers and convert to data frame
centers_df <- as.data.frame(kmc_result_4$centers)
centers_df$cluster <- rownames(centers_df)
centers_long <- pivot_longer(centers_df, 
                             cols = -cluster, 
                             names_to = "feature", 
                             values_to = "value")

# Plot the cluster profiles
ggplot(centers_long, aes(x = feature, y = value, color = cluster, group = cluster)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Feature Profiles for Each Cluster",
       x = "Feature Index",
       y = "Standardized Value")

