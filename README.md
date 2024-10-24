# SAS Analysis Project

This repository contains SAS macros and analysis for comparing blood pressure (systolic and diastolic) across different groups. The dataset used for this analysis includes athlete data, comparing `sex` and `lifestyle`.

## Project Overview

The goal of this project is to create comparative boxplots and perform two-sample t-tests to statistically compare systolic and diastolic blood pressure across various groups (gender and lifestyle). We also demonstrate the use of macros in SAS for efficient data analysis.

### Files Included:
- **[`macro2.sas`](./macro2.sas)**: The SAS code that runs the analysis, including macros for creating boxplots and performing t-tests.
- **[`Results_macro2.sas.pdf`](./Results_macro2.sas.pdf)**: Detailed results from the SAS analysis, including t-test statistics and visualizations.

## Key Results Summary

The results from the analysis are based on comparisons of systolic and diastolic blood pressure using a t-test, with groupings based on gender and lifestyle. Below are key findings from the analysis:

### 1. **Systolic Blood Pressure (SBP) by Sex**
- **Mean for Females (F)**: 110.6 (Std Dev: 11.60)
- **Mean for Males (M)**: 119.0 (Std Dev: 6.35)
- **T-Test Results**:
  - **Pooled t-value**: -2.84, **p-value**: 0.0072
  - **Conclusion**: There is a significant difference in systolic blood pressure between males and females.

### 2. **Diastolic Blood Pressure (DBP) by Sex**
- **Mean for Females (F)**: 62.2 (Std Dev: 7.37)
- **Mean for Males (M)**: 77.2 (Std Dev: 7.95)
- **T-Test Results**:
  - **Pooled t-value**: -6.19, **p-value**: <0.0001
  - **Conclusion**: There is a strong evidence of a significant difference in diastolic blood pressure between males and females.

### 3. **Systolic Blood Pressure (SBP) by Lifestyle**
- **Athletic (1)**: Mean = 108.0, **Sedentary (2)**: Mean = 121.7
- **T-Test Results**:
  - **Pooled t-value**: -5.75, **p-value**: <0.0001
  - **Conclusion**: There is a significant difference in systolic blood pressure between athletic and sedentary individuals.

### 4. **Diastolic Blood Pressure (DBP) by Lifestyle**
- **Athletic (1)**: Mean = 66.4, **Sedentary (2)**: Mean = 73.0
- **T-Test Results**:
  - **Pooled t-value**: -2.02, **p-value**: 0.0503
  - **Conclusion**: The difference in diastolic blood pressure based on lifestyle is marginally significant.

## Example SAS Code Usage

The macro `%boxt` is used to generate boxplots and perform t-tests for group comparisons. Below is an example usage of the macro:

```sas
%boxt(athlete, sbp, sex);
%boxt(athlete, dbp, lifestyle);
