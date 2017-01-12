#Getting and Cleaning Data Course Project
***
##Submitted Files
* *README.md* - description of submitted work
* *TidyData.txt* - the final cleaned dataset
* *run_analysis.R* - the code performing the transformations on the data
* *CodeBook.md* - contains variable names and experiment background

##run_analysis.R
1. Downloads data and unzips file
2. Reads the tables into variables
3. Renames the columns
4. Merges two seperate datasets to one
5. Filters the column names on mean, SD and relevant id's
6. Computes the average of each variable per activity
7. Writes result to **TidyData.txt**

##R code Prerequisites
1. Download *R* and/or *R Studio*
2. Set your working directory with *setwd()* command.
3. Download the data.table package with *install.packages("data.table")* command.

##Notes
The run_analysis.R file is heavily commented so other can see and understand the functionality of the code.