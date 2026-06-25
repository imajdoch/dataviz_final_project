# Hollywood Movies — Data Visualization Mini‑Project 1 **Revised**
**Author:** Isabel Majdoch  
**Course:** Data Visualization and Reproducible Research  

---

## Project Structure

```
data/
│-- HollywoodMovies.csv
|
project_01/
│
│-- Majdoch_MiniProject1.Rmd
│-- Majdoch_MiniProject1.html
│-- Majdoch_MiniProject1.md
|
└-- README.md
```

- Raw data is stored in the `data/` folder.  
- All analysis files (R Markdown and knitted outputs) are stored in the `project_01` folder.  
- This README provides an overview of the project and highlights the main components of the revised Mini‑Project 1.

---

## Project Overview

This project analyzes the *HollywoodMovies.csv* dataset, which contains 970 films and 16 variables. The goal is to identify which genres and story types tend to be the most financially successful. The analysis focuses on variables that relate directly to financial performance, including:

- Genre  
- Story  
- Budget  
- Profitability  
- OpeningWeekend and BOAvgOpenWeekend  

The project includes data cleaning, exploratory visualizations, and commentary that connects patterns in the data to broader questions about film performance.

---

## Data Cleaning

Several preprocessing steps were necessary to ensure accurate analysis:

- Removed rows with missing values in key variables  
- Standardized the Story variable (trimmed whitespace, corrected inconsistent formatting, removed invalid entries)  
- Ensured that grouping and summarization steps reflected the cleaned dataset  

These steps improved the reliability of the visualizations and prevented misleading results.

---

## Key Visualizations

### Genre Popularity (Redesigned Chart)

This chart shows the number of movies in each genre, sorted from most to least common, with labels indicating the percentage of films rated above 50% on RottenTomatoes. The redesign replaces a confusing stacked bar chart with a clearer, more interpretable version that uses a perceptually uniform color palette and consistent styling.

### Top Five Stories Within Each Genre

Faceted bar charts display the most common story structures used within each genre. This helps contextualize later financial comparisons by showing which narrative patterns dominate each category.

### Profitability by Genre

A sorted bar chart highlights which genres achieve the highest return on investment.

### Profitability by Story Type

This visualization shows which story structures tend to perform best financially across genres, using only story types with at least three films.

### Genre × Story Heatmap

This heatmap reveals which combinations of genre and story type produce the highest average profitability. It is the most informative visualization in the project and directly addresses the central research question.

---

## Interactive Visualization

The project includes an interactive bubble chart created with Plotly. It compares genres based on opening weekend revenue, profitability, and average budget. Interactivity allows the reader to hover over points to view exact values, examine outliers, and explore relationships without adding clutter to the chart. This provides a level of detail that a static image cannot offer.

---

## Accessibility

The project incorporates several accessibility practices:

- All figures include descriptive alt text using the `fig.alt` option  
- Colorblind‑safe palettes (viridis) are used throughout  
- Meaning is not conveyed by color alone; labels, sorting, and annotations support interpretation  

These choices ensure that the visualizations are usable by a wider audience.

---

## Redesign of a Bad Chart

The report includes a “before” chart that used default styling, stacked bars, and unclear color choices. The redesigned version improves clarity by:

- Using a perceptually uniform palette  
- Adding percentage labels  
- Sorting genres by frequency  
- Applying a consistent theme  

A side‑by‑side comparison is included in the report.

---

## Favorite Chart

The Genre × Story Profitability Heatmap is the most informative visualization in the project. It clearly shows which narrative structures perform best within each genre and provides direct insight into the central research question.

---

## Summary

This revised Mini‑Project 1 demonstrates reproducible analysis, thoughtful visualization design, and clear narrative explanation. It incorporates accessibility, interactivity, and a meaningful chart redesign while presenting a cohesive exploration of how genre and story structure relate to financial success in Hollywood films.
