# Project 02 — Nutritional Content in Global Recipes (Revised)  
**Isabel Majdoch**  
**CAP 5735: Data Visualization and Reproducible Research**  
**Revised: June 24, 2026**

---

## Project Structure

```
data/
│-- cuisines.csv
│-- all_recipes.csv
|
project_02/
│
│-- Majdoch_MiniProject2.Rmd
│-- Majdoch_MiniProject2.html
│-- Majdoch_MiniProject2.md
|
└-- README.md
```

---

## Overview
This project examines how macronutrients (fat, carbohydrates, and protein) vary across global cuisines. The data comes from Allrecipes.com through the tastyR package and the TidyTuesday project. I joined recipe-level nutrition data with cuisine labels, cleaned and mapped the cuisine categories to actual countries, and created several visualizations to explore patterns.

The revisions include accessibility improvements, a redesigned chart, a new visualization, and clearer explanations throughout.

---

# How This Revision Meets the Final Project Requirements

## 1. Interactive Chart
The first visualization is an interactive Plotly bubble chart. Hovering over each cuisine reveals its average fat, carbs, protein, and rating. This makes it easier to compare cuisines than a static scatterplot, especially when points overlap.

## 2. Accessibility
All figures were updated to follow accessibility guidelines.  
These updates include:

- Colorblind-safe palettes (viridis)  
- Alt text for every figure using the fig.alt option  
- Avoiding color as the only way to convey meaning  
- A custom theme that improves contrast and readability  

## 3. Redesign of a Bad Chart
The spatial map originally used a difficult yellow-to-red palette, low contrast, and lacked clear labeling.  
The revised version uses a viridis scale, labels only high-protein countries, centers the title, and applies the updated theme.  
Both the original and improved versions are included, along with an explanation of what was changed and why.

## 4. Revised Mini Project 2 Report
This revision includes:

- A new density plot  
- A fully updated spatial map  
- A clearer title and subtitle for the interactive chart  
- A rewritten narrative that explains the findings more clearly  
- A consistent theme across all plots  
- Better spacing, labeling, and accessibility  

## 5. Reproducibility
- All file paths are relative  
- Required packages are listed  
- The RMarkdown file knits cleanly  
- The project follows the folder structure required in the final project template  

## 6. Variety of Plot Types
This project includes four different types of visualizations:

- Interactive bubble chart  
- Spatial choropleth map  
- Model-based coefficient plot  
- Density plot  

## 7. Storytelling and Commentary
Each visualization includes a short explanation of what it shows and why it matters. The report also discusses data cleaning steps, challenges, and limitations.

---

# Data Used

### all_recipes.csv  
Contains 14,426 recipes with ingredients, nutrition, ratings, timing, and metadata.

### cuisines.csv  
Contains 2,218 recipes with cuisine labels.

A key challenge was that the “country” column in cuisines.csv did not represent actual countries. It represented cuisine categories. I created a mapping to convert these into actual countries for the spatial visualization.

---

# Visualizations

## 1. Interactive Bubble Chart
Compares average fat and carbs for each cuisine, with bubble size representing protein.  
The updated version includes a clearer title, a subtitle, and improved spacing so the title does not overlap the chart.

## 2. Spatial Map
Shows average protein content by country.  
Only countries with average protein above 20 grams are labeled to avoid clutter.  
Uses a viridis scale and the updated theme.

## 3. Model Visualization
A linear model predicting protein from fat and carbs.  
Fat has a strong positive relationship with protein.  
Carbs do not contribute much.

## 4. New Density Plot
Shows the distribution of protein across all recipes.  
Most recipes are low in protein, with a long tail of high-protein dishes.

---

# Data Cleaning and Challenges
- Mapping cuisine categories to countries required manual work  
- Some recipes had missing nutritional values  
- Plotly titles needed manual spacing adjustments  
- Ensuring consistent styling across all plots led to the creation of a custom theme  

---

# Limitations
- Cuisine categories are broad and do not capture the full diversity within each cuisine  
- Allrecipes.com submissions may not reflect traditional cooking practices  
- Nutritional values may vary in accuracy  

---

# Conclusion
This revised project brings together interactive, spatial, and statistical visualizations to explore global nutritional patterns. Updating the project for the final assignment improved accessibility, clarity, and consistency across all figures. The findings show that higher-fat cuisines tend to also be higher in protein, and that protein levels vary noticeably across regions.

---

If you want, I can help you update the top-level README for the entire final project or revise the Project 1 README in the same style.
