Fair-Lloyd algorithm

Matlab implementation of the Fair-Lloyd algorithm. Description of the files:

Folder: Fair-Lloyd

a.	load and pre-rpocess the data

•	loadData: load the working dataset
•	preProcessEductaionVector: only for the credit dataset. Outputs the sensitive feature vector indicating higher-educated and lower-educated
•	normalizeData : make the mean 0 and variance one for each feature
•	projectData: project the data using PCA or Fair-PCA
•	fairPCA: project the data using the Fair-PCA algorithm of Samadi et al. 2018 (look below for subroutines)
•	mw (subroutine for fairPCA): multiplicative weight update
•	optApprox (subroutine for mw): finds the optimal rank-d approximation of a given matrix
•	re (subroutine for mw): calculates reconstruction error of a matrix

b.	Fair-Lloyd


•	lloyd: implementation of lloyd’s and Fair-Lloyd algorithm (look below for subroutines)
•	giveRandCenters: generate initial random centres
•	findCenters: given a clustering, find the centers
•	findClustering: given a set of centers, find the clustering
•	compCost: given a clustering of the data, computing (fair) cost
•	kmeansCost_S_C (subroutine for compCost): given a clustering and a set of centers, calculate the k-means cost. 
•	bSearch: binary search procedure to find the fair centers

c.	evaluate the results using lloyd’s and Fair-Lloyd

•	maink: main file for running the experiments
Folder: plotsCode

•	plotting the results using the output data by Fair-Lloyd and Lloyd’s
You can download the resultsData folder from https://drive.google.com/file/d/1d2ChCuUHRpTFjPeAvHnsiw0mkP359WI3/view?usp=sharing
