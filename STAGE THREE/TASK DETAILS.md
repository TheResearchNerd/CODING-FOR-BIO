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

** **

**Findings and Insights**

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 1**

**<!--[if gte vml 1]><v:shapetype
 id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
 path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
 <v:stroke joinstyle="miter"/>
 <v:formulas>
  <v:f eqn="if lineDrawn pixelLineWidth 0"/>
  <v:f eqn="sum @0 1 0"/>
  <v:f eqn="sum 0 0 @1"/>
  <v:f eqn="prod @2 1 2"/>
  <v:f eqn="prod @3 21600 pixelWidth"/>
  <v:f eqn="prod @3 21600 pixelHeight"/>
  <v:f eqn="sum @0 0 1"/>
  <v:f eqn="prod @6 1 2"/>
  <v:f eqn="prod @7 21600 pixelWidth"/>
  <v:f eqn="sum @8 21600 0"/>
  <v:f eqn="prod @7 21600 pixelHeight"/>
  <v:f eqn="sum @10 21600 0"/>
 </v:formulas>
 <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
 <o:lock v:ext="edit" aspectratio="t"/>
</v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_i1034" type="#_x0000_t75"
 style='width:342pt;height:219pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image001.emz"
  o:title="" croptop="2618f" cropbottom="20303f" cropright="22450f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image002.png)<!--[endif]-->**

**Figure 1: Radiu Mean Vs Diagnosis**

Radius, perimeter, and area (mean, worst values) are strongly correlated with malignancy. Larger tumors are more likely to be malignant.

****

** **

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 2**

<!--[if gte vml 1]><v:shape id="Picture_x0020_2" o:spid="_x0000_i1033"
 type="#_x0000_t75" style='width:355pt;height:221.5pt;visibility:visible;
 mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image003.emz"
  o:title="" croptop="2448f" cropbottom="21242f" cropright="22181f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image004.png)<!--[endif]-->

**Figure 2: Texture Mean Vs Diagnosis**

Irregularities in tumor shapes are higher and more variable in malignant (M) tumor.

****

** **

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 3**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_3" o:spid="_x0000_i1032" type="#_x0000_t75" style='width:331.5pt;
 height:249.5pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image005.emz"
  o:title="" croptop="1652f" cropbottom="16149f" cropright="24534f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image006.png)<!--[endif]-->**

**Figure 3: Feature Correlation Heatmap**

Features (radius, perimeter, area) are highly positively correlated. Some texture and shape features show moderate correlations with size features.

****

** **

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 4**

**Principal Component Analysis (PCA) With Scree Plot**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_4" o:spid="_x0000_i1031" type="#_x0000_t75" style='width:312pt;
 height:197pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image007.emz"
  o:title="" croptop="2392f" cropbottom="20515f" cropright="21845f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image008.png)<!--[endif]-->**

**Figure 4: Scree Plot of % Variance Vs Principal Component**

The first principal component (PC1) explains 44.3% and PC2 explains 19% of the total variance respectively. The first two components together explain 63.2% of the total variance, and the first five components cumulatively explain 84.7% of the variance, which is sufficient for reducing dimensionality. The scree plot shows a sharp drop-off after the first two components, indicating that most of the information in this 30-dimensional dataset can be captured in just a few dimensions.

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 5**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_5" o:spid="_x0000_i1030" type="#_x0000_t75" style='width:326.5pt;
 height:221pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image009.emz"
  o:title="" cropbottom="18640f" cropright="20770f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image010.png)<!--[endif]-->**

**Figure 5: PCA plot of PC1 (Dim 1)Vs PC2 (Dim-2)**

PCA biplots show a clear separation between benign and malignant clusters in the PC1-PC2 space. Malignant tumors cluster in regions of higher PC1. A clear separation can be observed between benign and malignant cases, with some overlap. This suggests that linear combinations of the original features can effectively distinguish between the two classes.

****

** **

**K-Means Clustering for Patient Classification**

**Optimal Cluster Count**

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 6**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_6" o:spid="_x0000_i1029" type="#_x0000_t75" style='width:348pt;
 height:211.5pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image011.emz"
  o:title="" croptop="3142f" cropbottom="20409f" cropright="20905f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image012.png)<!--[endif]-->**

**Figure 6: Optimal Number of Clusters**

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 7**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_7" o:spid="_x0000_i1028" type="#_x0000_t75" style='width:343pt;
 height:209pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image013.emz"
  o:title="" croptop="2480f" cropbottom="19891f" cropright="19690f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image014.png)<!--[endif]-->**

**Figure 7: K-Means Clustering K= 2 of PC1 (Dim 1)Vs PC2 (Dim-2)**

K-Means clusters (K=2) overlap well with PCA’s diagnosis-based separation.

Clustering Accuracy;

<!--[if !supportLists]-->·       <!--[endif]-->91.04% accuracy was achieved compared to the actual diagnosis

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 1 captured mostly malignant cases (175 malignant, 14 benign)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 2 captured mostly benign cases (343 benign, 37 malignant)

**Identifying Subclasses Within the Dataset**

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 8**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_8" o:spid="_x0000_i1027" type="#_x0000_t75" style='width:342.5pt;
 height:218pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image015.emz"
  o:title="" croptop="2389f" cropbottom="19787f" cropright="21442f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image016.png)<!--[endif]-->**

**Figure 8: K-Means Clustering K= 4 of PC1 (Dim 1)Vs PC2 (Dim-2)**

****

** **

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 9**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_9" o:spid="_x0000_i1026" type="#_x0000_t75" style='width:339.5pt;
 height:222.5pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image017.emz"
  o:title="" cropbottom="19787f" cropright="20434f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image018.png)<!--[endif]-->**

**Figure 9: PCA plot of K-Means Clustering K= 4 of PC1 (Dim 1)Vs PC2 (Dim-2)**

K=4 clustering explored potential subclasses within the benign and malignant groups, and it revealed interesting substructures:

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 4 primarily contains benign cases (321 benign, 23 malignant)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 2 contains purely malignant (37 cases).

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 3 exclusively contains malignant cases (98 cases)

<!--[if !supportLists]-->·       <!--[endif]-->Cluster 1 is mixed (36 benign, 54 malignant)

Subgroups within malignant cases (Clusters 2 and 3) suggest biological heterogeneity (e.g., aggressive vs. indolent tumors).

****

** **

**Feature Profiles of Subclasses**

<!--[if !supportLists]-->·       <!--[endif]-->**Visualization 10**

**<!--[if gte vml 1]><v:shape
 id="Picture_x0020_10" o:spid="_x0000_i1025" type="#_x0000_t75" style='width:336pt;
 height:210pt;visibility:visible;mso-wrap-style:square'>
 <v:imagedata src="file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image019.emz"
  o:title="" croptop="2346f" cropbottom="20405f" cropright="21308f"/>
</v:shape><![endif]--><!--[if !vml]-->![](file:///C:/Users/USER/AppData/Local/Temp/msohtmlclip1/01/clip_image020.png)<!--[endif]-->**

**Figure 10: Feature Profiles for Each Cluster**

Cluster 2 shows elevated values for many of the size and shape irregularity features (Highest concavity\_worst, radius\_worst). Cluster 3 shows elevated values for many of the size and shape irregularity features (High texture\_worst, moderate radius\_worst). The benign-dominant cluster (Cluster 4) shows lower values for most features, and the mixed cluster (Cluster 1) shows intermediate values. These differences may reflect distinct molecular or pathological subtypes.

**Conclusion**

This analysis demonstrates how unsupervised machine learning techniques can reveal groupings in medical data, potentially helping to improve diagnostic accuracy and identify important potential subgroups within diagnostic categories.

Our findings indicate that dimensional features played a crucial role in differentiating benign from malignant tumors. **PCA successfully reduced dimensionality**, making most of the information captured in just a few principal components. When applying K-means clustering with K=4, we discovered potential subdivisions within the malignant classification (specifically clusters 2 and 3), possibly representing distinct morphological variants or progression stages. Additionally, the feature profiles across clusters highlighted the most significant differentiating characteristics: dimensional measurements (radius, perimeter, area., etc) and cellular irregularity indicators (concavity, compactness., etc).

With a high accuracy for the unsupervised K-means clustering (91.04%), conducting a supervised classification method (such as Random Forest) is recommended to refine the classification. Also, the identified subclasses (Cluster 2 and 3) should be subjected to further validation and analysis.

** **
