**Tumor Classification and Subgroup Identification in Cancer Datasets Using Principal Component Analysis (PCA) and Machine Learning Approach**

**Introduction**

This analysis leverages diagnostic features including tumor radius, texture, and concavity, to distinguish benign (B) and malignant (M) tumors and employs machine-learning techniques to identify potential subclasses.

**Methodology**

<!--[if !supportLists]-->·       <!--[endif]-->Installation of packages and loading of libraries

<!--[if !supportLists]-->·       <!--[endif]-->Obtaining the dataset

<!--[if !supportLists]-->·       <!--[endif]-->Cleaning and processing of data

<!--[if !supportLists]-->·       <!--[endif]-->Classifying columns into the target and features variable

<!--[if !supportLists]-->·       <!--[endif]-->Standardization of the features variable

<!--[if !supportLists]-->·       <!--[endif]-->Exploratory Data Analysis

<!--[if !supportLists]-->·       <!--[endif]-->Principal Component Analysis

<!--[if !supportLists]-->·       <!--[endif]-->K-Means Clustering

****


**Findings and Insights**

**Visualization 1**

![image](https://github.com/user-attachments/assets/36300dc7-4717-4dae-bb75-f74a1764bd90)


**Figure 1: Radiu Mean Vs Diagnosis**

Radius, perimeter, and area (mean, worst values) are strongly correlated with malignancy. Larger tumors are more likely to be malignant.

****


**Visualization 2**


 ![image](https://github.com/user-attachments/assets/fb084b9e-c8ee-4b58-af8e-5193a482c761)


**Figure 2: Texture Mean Vs Diagnosis**

Irregularities in tumor shapes are higher and more variable in malignant (M) tumor.

****

**Visualization 3**


![image](https://github.com/user-attachments/assets/15ad6ef2-d207-4d1e-8d2a-391e6cd76e1e)


**Figure 3: Feature Correlation Heatmap**

Features (radius, perimeter, area) are highly positively correlated. Some texture and shape features show moderate correlations with size features.

****

**Visualization 4**

**Principal Component Analysis (PCA) With Scree Plot**

![image](https://github.com/user-attachments/assets/82ad4e56-71b7-48b4-95ff-9322cc773bcd)


**Figure 4: Scree Plot of % Variance Vs Principal Component**

The first principal component (PC1) explains 44.3% and PC2 explains 19% of the total variance respectively. The first two components together explain 63.2% of the total variance, and the first five components cumulatively explain 84.7% of the variance, which is sufficient for reducing dimensionality. The scree plot shows a sharp drop-off after the first two components, indicating that most of the information in this 30-dimensional dataset can be captured in just a few dimensions.

**Visualization 5**

![image](https://github.com/user-attachments/assets/fbd1402f-35fa-4a87-9915-6e7614162487)


**Figure 5: PCA plot of PC1 (Dim 1)Vs PC2 (Dim-2)**

PCA biplots show a clear separation between benign and malignant clusters in the PC1-PC2 space. Malignant tumors cluster in regions of higher PC1. A clear separation can be observed between benign and malignant cases, with some overlap. This suggests that linear combinations of the original features can effectively distinguish between the two classes.

****


**K-Means Clustering for Patient Classification**

**Optimal Cluster Count**

**Visualization 6**

![image](https://github.com/user-attachments/assets/efc4ec71-4303-4d30-8db7-9bebc0c0cf29)


**Figure 6: Optimal Number of Clusters**

**Visualization 7**

![image](https://github.com/user-attachments/assets/e806c53b-83a0-4411-a44f-32567fa12e80)

**Figure 7: K-Means Clustering K= 2 of PC1 (Dim 1)Vs PC2 (Dim-2)**

K-Means clusters (K=2) overlap well with PCA’s diagnosis-based separation.

Clustering Accuracy;

<!--[if !supportLists]-->·       <!--[endif]-->91.04% accuracy was achieved compared to the actual diagnosis

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 1 captured mostly malignant cases (175 malignant, 14 benign)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 2 captured mostly benign cases (343 benign, 37 malignant)

**Identifying Subclasses Within the Dataset**

**Visualization 8**

![image](https://github.com/user-attachments/assets/b6277848-cb5a-49c9-b97c-d2d0298119d0)


**Figure 8: K-Means Clustering K= 4 of PC1 (Dim 1)Vs PC2 (Dim-2)**

****

**Visualization 9**

![image](https://github.com/user-attachments/assets/18c1fa70-b408-45e8-9bbc-62e85be29cb3)


**Figure 9: PCA plot of K-Means Clustering K= 4 of PC1 (Dim 1)Vs PC2 (Dim-2)**

K=4 clustering explored potential subclasses within the benign and malignant groups, and it revealed interesting substructures:

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 4 primarily contains benign cases (321 benign, 23 malignant)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 2 contains purely malignant (37 cases).

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 3 exclusively contains malignant cases (98 cases)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 1 is mixed (36 benign, 54 malignant)

Subgroups within malignant cases (Clusters 2 and 3) suggest biological heterogeneity (e.g., aggressive vs. indolent tumors).

****


**Feature Profiles of Subclasses**

**Visualization 10**

![image](https://github.com/user-attachments/assets/a567d341-0d0f-4778-abd3-4ef4faa7d148)


**Figure 10: Feature Profiles for Each Cluster**

Cluster 2 shows elevated values for many of the size and shape irregularity features (Highest concavity\_worst, radius\_worst). Cluster 3 shows elevated values for many of the size and shape irregularity features (High texture\_worst, moderate radius\_worst). The benign-dominant cluster (Cluster 4) shows lower values for most features, and the mixed cluster (Cluster 1) shows intermediate values. These differences may reflect distinct molecular or pathological subtypes.

**Conclusion**

This analysis demonstrates how unsupervised machine learning techniques can reveal groupings in medical data, potentially helping to improve diagnostic accuracy and identify important potential subgroups within diagnostic categories.

Our findings indicate that dimensional features played a crucial role in differentiating benign from malignant tumors. PCA successfully reduced dimensionality, making most of the information captured in just a few principal components. When applying K-means clustering with K=4, we discovered potential subdivisions within the malignant classification (specifically clusters 2 and 3), possibly representing distinct morphological variants or progression stages. Additionally, the feature profiles across clusters highlighted the most significant differentiating characteristics: dimensional measurements (radius, perimeter, area., etc) and cellular irregularity indicators (concavity, compactness., etc).

With a high accuracy for the unsupervised K-means clustering (91.04%), conducting a supervised classification method (such as Random Forest) is recommended to refine the classification. Also, the identified subclasses (Cluster 2 and 3) should be subjected to further validation and analysis.
