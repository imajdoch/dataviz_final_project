---
title: "Mini Project 2 **Revised**"
subtitlte: Isabel Majdoch
output:
  html_document:
    df_print: paged
---

# Nutritional Content in Different Global Recipes
### Isabel Majdoch Revised: 6/24/2026
### CAP 5735 Data Visualization and Reproducible Research

I was interested in seeing how different types of recipes around the world compared and contrasted in their micro nutrient department. These included comparing fat, carbohydrate, and protein content across recipes and seeing if patterns emerge. Asking the question 

> Is there a difference in nutritional value among different cultures?

For this project, I explored a curated collection of recipes sourced from **Allrecipes.com**, made available through the tastyR package and the TidyTuesday project. The dataset consists of two parts:
**all_recipes.csv** that had 14,426 recipes.
This dataset includes detailed information for each recipe, such as:

- Ingredients (raw text)

- Nutritional values: calories, fat, carbohydrates, protein

- User engagement: average rating, number of ratings, number of written reviews

- Timing information: preparation time, cooking time, total time

- Metadata: recipe name, author, publication date, and URL

These fields have been cleaned and standardized, making it possible to compare recipes across cuisines and cooking styles.

**cuisines.csv** that had 2,218 recipes.
This dataset links recipes to a cuisine type, such as Italian, Japanese, Cajun, or Soul Food. Although the column is named “country,” it actually represents cuisine categories, not sovereign countries. This distinction became important during the spatial visualization, where I mapped cuisines to their corresponding countries of origin.

Both datasets share the name field, allowing them to be joined and analyzed together.

```{r}
recipes <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/all_recipes.csv')
cuisines <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-09-16/cuisines.csv')
```

### Theme

A consistent theme was created to implement within my ggplot graphs that is food inspired. 

```{r}
library(ggplot2)

library(viridis)

theme_foodie_cb <- function(base_size = 14) {
  theme_minimal(base_size = base_size) %+replace%
    theme(
      plot.background  = element_rect(fill = "#F7F4EA", color = NA),
      panel.background = element_rect(fill = "#F7F4EA", color = NA),
      legend.background = element_rect(fill = "#F7F4EA", color = NA),

      panel.grid.major = element_line(color = "#E6DDC6", linewidth = 0.4),
      panel.grid.minor = element_line(color = "#EFE8D8", linewidth = 0.2),

      plot.title = element_text(face = "bold", size = base_size * 1.4, color = "#3A3A3A"),
      plot.subtitle = element_text(size = base_size * 1.1, color = "#4A4A4A"),
      plot.caption = element_text(size = base_size * 0.8, color = "#6A6A6A"),

      axis.title = element_text(face = "bold", color = "#3A3A3A"),
      axis.text  = element_text(color = "#3A3A3A"),

      legend.title = element_text(face = "bold", color = "#3A3A3A"),
      legend.text  = element_text(color = "#3A3A3A"),

      strip.background = element_rect(fill = viridis(1, option = "C"), color = NA),
      strip.text = element_text(face = "bold", color = "#3A3A3A")
    )
}

```

# Interactive Bubble Chart
**Visualization 1**

I computed the data to compute average fat, carbs, protein, and rating for each cuisine in order to create a bubble chart. Within this bubble chart you are able to compare the average fat and carbohydrate content across cuisines, with bubble size representing average protein. 

This highlights the macro nutrient “profile” of each cuisine. Larger bubbles indicate recipes high in protien content, while the position on the axes shows the fat and carbs The interactivity allows the viewer to explore each cuisine’s nutritional signature in detail.


```{r}

library(tidyverse)
library(plotly)

# Join on recipe name (or URL if more reliable)
df <- recipes %>%
  left_join(cuisines %>% select(name, country), by = "name")

country_avgs <- df %>%
  group_by(country) %>%
  summarise(
    avg_fat = mean(fat, na.rm = TRUE),
    avg_carbs = mean(carbs, na.rm = TRUE),
    avg_protein = mean(protein, na.rm = TRUE),
    avg_rating = mean(avg_rating, na.rm = TRUE),
    n_recipes = n()
  ) %>%
  drop_na()

```


```{r bubble, fig.alt="Interactive bubble chart showing average fat and carbs by cuisine, with bubble size representing protein content."}
plot_ly(
  data = country_avgs,
  x = ~avg_fat,
  y = ~avg_carbs,
  type = "scatter",
  mode = "markers",
  color = ~country,
  colors = viridis(20, option = "C"),
  marker = list(
    size = ~avg_protein * 1.5,
    sizemode = "diameter",
    line = list(width = 1, color = "#3A3A3A")
  ),
  text = ~paste0(
    "<b>", country, "</b><br>",
    "Avg Fat: ", round(avg_fat, 1), " g<br>",
    "Avg Carbs: ", round(avg_carbs, 1), " g<br>",
    "Avg Protein: ", round(avg_protein, 1), " g<br>",
    "Avg Rating: ", round(avg_rating, 2)
  ),
  hoverinfo = "text"
) %>%
  layout(
  title = list(
    text = "How Global Cuisines Differ in Nutritional Balance<br>",
    font = list(size = 24, family = "Nunito", color = "#3A3A3A"),
    yanchor = "top",
    y = 1.05,          # moves title above the chart
    pad = list(t = 40, b = 10)  # adds spacing above and below
  ),
  margin = list(t = 100),  # ensures enough space for the title block
  xaxis = list(
    title = "Average Fat (g)",
    gridcolor = "#E6DDC6",
    zerolinecolor = "#E6DDC6",
    titlefont = list(color = "#3A3A3A")
  ),
  yaxis = list(
    title = "Average Carbs (g)",
    gridcolor = "#E6DDC6",
    zerolinecolor = "#E6DDC6",
    titlefont = list(color = "#3A3A3A")
  ),
  plot_bgcolor = "#F7F4EA",
  paper_bgcolor = "#F7F4EA",
  legend = list(
    bgcolor = "#F7F4EA",
    bordercolor = "#F7F4EA",
    font = list(color = "#3A3A3A")
  )
)


```

Within this chart you are able to see and interact with all of the different types of cuisines and find average patterns. For example we can see that most of the large bubbles (high protien) actually correspond with a higher average fat content. You also see bubbles with smaller protien also are lower with fat and carbs. The smaller amount of protien, fat, and carbs is the Swedish based recipes. 

Higher‑protein cuisines tend to also be higher in fat (e.g., Pakistani, Cajun, Southern Recipes). Lower‑protein cuisines (e.g., Swedish) cluster with lower fat and carbs.

With a static image chart you wouldn't be able to get all of those details and it would be significantly more difficult to tell the difference between the different countries. 

### Data Cleaning

The raw data included 14,426 recipes and 2,218 cuisine labels. The “country” field in the cuisine dataset actually represented cuisine types, instead of specific countries, so I created a mapping to convert these into actual country names for the spatial visualization. 

```{r}
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

country_avgs <- country_avgs %>%
  mutate(country = case_when(
    country == "UK" ~ "United Kingdom",
    country == "United States" ~ "United States of America",
    country == "Vietnamese" ~ "Viet Nam",
    country == "Korean" ~ "Korea, Republic of",
    TRUE ~ country
  ))

```


```{r}
country_avgs <- country_avgs %>%
  mutate(country = case_when(
    str_detect(country, "American|Soul Food|Southern Recipes|Tex-Mex|Cajun") ~ "United States of America",
    str_detect(country, "Argentinian") ~ "Argentina",
    str_detect(country, "Australian") ~ "Australia",
    str_detect(country, "Austrian") ~ "Austria",
    str_detect(country, "Bangladeshi") ~ "Bangladesh",
    str_detect(country, "Belgian") ~ "Belgium",
    str_detect(country, "Brazilian") ~ "Brazil",
    str_detect(country, "Canadian") ~ "Canada",
    str_detect(country, "Chilean") ~ "Chile",
    str_detect(country, "Chinese") ~ "China",
    str_detect(country, "Cuban") ~ "Cuba",
    str_detect(country, "Danish") ~ "Denmark",
    str_detect(country, "Dutch") ~ "Netherlands",
    str_detect(country, "Filipino") ~ "Philippines",
    str_detect(country, "Finnish") ~ "Finland",
    str_detect(country, "French") ~ "France",
    str_detect(country, "German") ~ "Germany",
    str_detect(country, "Greek") ~ "Greece",
    str_detect(country, "Indian") ~ "India",
    str_detect(country, "Indonesian") ~ "Indonesia",
    str_detect(country, "Israeli|Jewish") ~ "Israel",
    str_detect(country, "Italian") ~ "Italy",
    str_detect(country, "Jamaican") ~ "Jamaica",
    str_detect(country, "Japanese") ~ "Japan",
    str_detect(country, "Korea") ~ "Korea, Republic of",
    str_detect(country, "Lebanese") ~ "Lebanon",
    str_detect(country, "Norwegian") ~ "Norway",
    str_detect(country, "Pakistani") ~ "Pakistan",
    str_detect(country, "Persian") ~ "Iran",
    str_detect(country, "Peruvian") ~ "Peru",
    str_detect(country, "Polish") ~ "Poland",
    str_detect(country, "Portuguese") ~ "Portugal",
    str_detect(country, "Puerto Rican") ~ "Puerto Rico",
    str_detect(country, "Russian") ~ "Russian Federation",
    str_detect(country, "Scandinavian|Swedish") ~ "Sweden",
    str_detect(country, "South African") ~ "South Africa",
    str_detect(country, "Spanish") ~ "Spain",
    str_detect(country, "Swiss") ~ "Switzerland",
    str_detect(country, "Thai") ~ "Thailand",
    str_detect(country, "Turkish") ~ "Türkiye",
    str_detect(country, "Viet Nam|Vietnamese") ~ "Viet Nam",
    TRUE ~ NA_character_
  ))


```

# Spatial Map
**Visualization 2**

This geospatial map visualizes the average protein content by the country the recipes originated in. I created a shape file after aggregating the data. The yellow to red gradient highlights the regional differences of the protein rich cuisines. With the yellow being less protien then the darker red part of the gradient. 

```{r map, fig.alt="World map showing average protein content by country, with darker colors indicating higher protein."}

world <- ne_countries(scale = "medium", returnclass = "sf")

map_data <- world %>%
  left_join(country_avgs, by = c("name" = "country"))

# Filter for labeling only high or low protein countries
label_data <- map_data %>%
  filter(!is.na(avg_protein)) %>%
  filter(avg_protein > 20)

ggplot(map_data) +
  geom_sf(aes(fill = avg_protein), color = "white", linewidth = 0.2) +
  geom_sf_text(
    data = label_data,
    aes(label = name),
    size = 2.6,
    color = "#3A3A3A",
    alpha = 0.65,
    fontface = "bold"
  ) +
  scale_fill_viridis_c(name = "Avg Protein (g)", option = "C", na.value = "grey90") +
labs(
  title = "Average Protein Content Across Global Recipes",
  subtitle = "Labels shown only for countries with an average of above 20g",
  caption = "Data: TidyTuesday Recipes & Cuisines"
) + theme_foodie_cb() +
theme(
  plot.title.position = "plot",
  plot.title = element_text(vjust = 1.2)
)




```

You can see that Pakistan has the lightest part of the map, making it the most protien based, and then the combination of different 'American style foods followed that, and then China. You also could see that Sweeden, Australia, and Brazil have the least amount. 

I was assuming that further away from the equator it would be more protien rich due to the idealized expection of hearty stew styled recipes in colder climates, but there is not an obvious distinction, according to this data, between countries group mapping. 

Because cuisine labels are broad and sometimes overlap (e.g., “Southern Recipes,” “Soul Food,” “Tex‑Mex”), the values may not fully represent the diversity within the recipes, specifically America. 

## Improved Graph

#### Before

This shows how the graph was presented before the revisions. The revisions provide better accessibility wise, with the color palette being easier to read for color blind and providing alt text. It also labels the countries with the most protein content, naming them, for better readability. Also the title is centered so it can be properly read.

```{r}
theme_foodie <- function(base_size = 14) {
  theme_minimal(base_size = base_size) %+replace%
    theme(
      plot.background  = element_rect(fill = "#F7F4EA", color = NA),
      panel.background = element_rect(fill = "#F7F4EA", color = NA),
      legend.background = element_rect(fill = "#F7F4EA", color = NA),

      panel.grid.major = element_line(color = "#E6DDC6", size = 0.4),
      panel.grid.minor = element_line(color = "#EFE8D8", size = 0.2),

      plot.title = element_text(
        face = "bold",
        size = base_size * 1.4,
        color = "#3A3A3A",
        margin = margin(b = 10)
      ),
      plot.subtitle = element_text(
        size = base_size * 1.1,
        color = "#4A4A4A",
        margin = margin(b = 15)
      ),
      plot.caption = element_text(
        size = base_size * 0.8,
        color = "#6A6A6A",
        margin = margin(t = 10)
      ),

      axis.title = element_text(face = "bold", color = "#3A3A3A"),
      axis.text  = element_text(color = "#3A3A3A"),

      legend.title = element_text(face = "bold", color = "#3A3A3A"),
      legend.text  = element_text(color = "#3A3A3A"),

      strip.background = element_rect(fill = "#F4E285", color = NA),
      strip.text = element_text(face = "bold", color = "#3A3A3A")
    )
}

world <- ne_countries(scale = "medium", returnclass = "sf")

map_data <- world %>%
  left_join(country_avgs, by = c("name" = "country"))

ggplot(map_data) +
  geom_sf(aes(fill = avg_protein), color = "white", size = 0.2) +
  scale_fill_gradient(
    name = "Avg Protein (g)",
    low = "#F4E285",
    high = "#BC4B51",
    na.value = "grey90"
  ) +
  labs(
    title = "Average Protein Content Across Global Recipes",
    subtitle = "Country averages based on recipe data",
    caption = "Data: TidyTuesday Recipes & Cuisines"
  ) +
  theme_foodie() +
  theme(
    legend.position = "right",
    panel.grid = element_blank()
  )
```


# Model Visualization
**Visualization 3**

A linear model was created to show and predict how the different macro nutrients fit with each other, predicting the protein from fat and nutrients. 

```{r model, fig.alt="Coefficient plot showing the effect of fat and carbs on protein content."}

library(broom)
library(ggplot2)

model <- lm(protein ~ fat + carbs, data = df)
coef_df <- tidy(model)

ggplot(coef_df %>% filter(term != "(Intercept)"),
       aes(x = estimate, y = term)) +
  geom_point(size = 4, color = viridis(1, option = "C")) +
  geom_errorbarh(aes(xmin = estimate - std.error,
                     xmax = estimate + std.error),
                 height = 0.2,
                 color = "#3A3A3A") +
  labs(
    title = "Effect of Fat and Carbs on Protein Content",
    subtitle = "Linear model coefficients with standard errors",
    x = "Coefficient Estimate",
    y = "Predictor"
  ) +
  theme_foodie_cb()


```

Within this plot you are able to see that fat has a strong positive coefficient (0.6), showing that recipes higher in fat are more likely higher in protein. Carbs hover nears the zero, showing that there is not a meaningful prediction of possible protein content. This also proves that the estimates are precise due to the small error bars. 

## New Visualization
```{r density, fig.alt="Density plot showing the distribution of protein content across all recipes."}

ggplot(df, aes(x = protein)) +
  geom_density(fill = viridis(1, option = "C"), alpha = 0.7) +
  labs(
    title = "Distribution of Protein Content Across All Recipes",
    x = "Protein (g)",
    y = "Density"
  ) +
  theme_foodie_cb()

```

This chart shows that while a handful of recipes are protein‑dense, the vast majority are relatively low‑protein dishes.


## Design Decisions and Original Plans 

I originally planned to compare cuisines strictly by country, but early exploration revealed that the “country” field actually represented cuisine types rather than geographic origins. This required additional data cleaning and a mapping step to align cuisines with actual countries for the spatial visualization. 

I also planned to explore calorie content, but shifted focus to macronutrients after noticing clearer patterns in fat, carbs, and protein.

Another challenge was ensuring visual consistency across plots, so I created a custom theme with color palette that was food‑inspired.

Also, the dataset reflects recipes uploaded to Allrecipes.com, which may not be representative of all global cooking traditions.

---

# Conclusion

Overall, the analysis suggests that cuisines with higher fat content tend to also be higher in protein, while carbohydrate levels vary more independently. The spatial map highlights regional differences in protein‑dense cuisines, with Pakistan and several American‑influenced cuisines ranking highest. The model confirms that fat is a strong predictor of protein content, while carbohydrates contribute little explanatory power. Together, these findings illustrate meaningful nutritional patterns across global recipes.

---

# Revision

This version includes several improvements:

- **Accessibility**: Added alt text to all figures and replaced custom palettes with colorblind‑safe viridis scales.
- **Theme revision**: Updated the custom theme to ensure consistent contrast and readability.
- **New visualization**: Added a density plot to contextualize protein distribution across all recipes.
- **Enhanced spatial map**: Improved color scale, legend readability, and background contrast.