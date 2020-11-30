# GettingAndCleaningData
Homework Repo for the Getting and Cleaning Data Course Project

## Folder Structure

In the data folder one finds the original dataset. We have used the link on the course website to download the data. The original source is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The tidydata folder contains the codebook, the merged dataset, and the averages of the measurments by Subject x Activity.

## Analysis

The run_analysis.R script follows the step laid out in the homework assignment. We give a slightly more detailed description here:
1. It merges the data.
2. It extracts only the mean and std for each measurement.
3. It converts everything to numerics for later analysis.
4. It adds columns for the subject numbers and the activities
5. It replaces the activity-number with the activity-name
6. It creates the averages dataset
7. It saves everything.
