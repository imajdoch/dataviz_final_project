---
title: "Mini Project 2 **Revised**"
author: "Isabel Majdoch"
output: html_notebook
editor_options: 
  chunk_output_type: inline
---

# Project: Nutritional Content in Global Recipes  
#### CAP 5735: Data Visualization and Reproducible Research

---

## **Overview**
This project explores global recipe data sourced from **Allrecipes.com** and curated through the *tastyR* package. The goal was to analyze how macronutrient: 

- fat
- carbohydrates
- protein

vary across different cuisines and to visualize these patterns using interactive, spatial, and statistical model‑based graphics.

The analysis focuses on three core questions:

> 1. **How do cuisines differ in their macronutrient composition?**  
> 2. **Do these nutritional patterns show geographic structure when mapped to countries of origin?**  
> 3. **Can we model the relationship between fat, carbs, and protein across recipes?**

---

## **Data Description**
The project uses two datasets:

### **1. all_recipes.csv (14,426 recipes)**  
Contains detailed recipe‑level information:
- Ingredients  
- Nutritional values (calories, fat, carbs, protein)  
- Ratings and review counts  
- Prep time, cook time, total time  
- Recipe name, author, publication date, URL  

### **2. cuisines.csv (2,218 recipes)**  
Includes:
- Recipe name  
- Cuisine type (e.g., Italian, Cajun, Soul Food, Japanese)  
- Nutritional and rating information  

**Important note:**  
The `country` column in this dataset actually represents **cuisine categories**, not actual countries. For the spatial visualization, cuisine types were mapped manually to their corresponding countries of origin.

Both datasets share the `name` field, allowing them to be joined.

---

## **Project Structure**
```
MiniProject2/
│
├── MiniProject2.Rproj
├── data/
│   ├── all_recipes.csv
│   ├── cuisines.csv
│
├── report/
│   ├── Majdoch_MiniProject2.Rmd
│   └── Majdoch_MiniProject2.html
│
└── README.md
```

---

## **Reproducibility Instructions**
To reproduce this analysis:

1. Open the project by double‑clicking `MiniProject2.Rproj`.  
2. Ensure the datasets are located in the `data/` folder.  
3. Open `Majdoch_MiniProject2.Rmd` in the `report/` folder.  
4. Install required packages if needed:
   ```r
   install.packages(c("tidyverse", "plotly", "sf", "rnaturalearth", "rnaturalearthdata", "broom"))
   ```
5. Knit the R Markdown file to HTML.

All file paths are relative, so the project should run on any machine without modification.

---

## **Summary of Findings**
Across the three visualizations, several patterns emerged:

- **Cuisines with higher fat content tend to also be higher in protein**, while carbohydrate levels vary more independently.  
- The **interactive bubble chart** highlights nutrient trade‑offs and shows that cuisines like Pakistani, Cajun, and Southern Recipes tend to be richer in all three macronutrients.  
- The **spatial map** reveals geographic variation in protein density, with Pakistan and several American‑influenced cuisines ranking highest.  
- The **linear model** confirms that **fat is a strong positive predictor of protein**, while carbohydrates contribute little explanatory power.  
- These patterns suggest meaningful nutritional differences across global cuisines, though they reflect recipes uploaded to Allrecipes.com rather than traditional cuisine as a whole.

---

## **Visualizations Included**
This project includes the three required visualization types:

### **1. Interactive Plot (Plotly Bubble Chart)**  
Shows average fat vs. carbs for each cuisine, with bubble size representing protein.  
Allows users to explore nutrient profiles interactively.

### **2. Spatial Visualization (Choropleth Map)**  
Maps average protein content by country of origin after mapping cuisine types to countries.

### **3. Model Visualization (Coefficient Plot)**  
Displays the estimated effects of fat and carbs on protein using a linear model.

All visualizations use a custom **food‑inspired theme** for consistency.

---

## **Data Cleaning & Challenges**
Key challenges included:

- The `country` field in the cuisine dataset did not contain actual countries.  
  → Resolved by creating a manual mapping from cuisine types to countries.  
- Many recipes had missing nutritional values.  
  → Addressed using `na.rm = TRUE` during aggregation.  
- Spatial joins required careful ordering of code chunks to ensure the `world` object existed before joining.  
- Ensuring visual consistency across plots led to the creation of a custom theme.

---

## **Limitations**
- Cuisine categories are broad and may not fully represent the diversity  
- The dataset reflects recipes uploaded to Allrecipes.com, which may not represent global traditional cooking practices  
- Nutritional values may vary in accuracy.

---

## **Conclusion**
This project demonstrates how interactive, spatial, and statistical visualizations can work together to reveal meaningful patterns in global recipe data. The findings highlight nutritional differences across cuisines and show how macronutrients relate to one another across thousands of recipes.
