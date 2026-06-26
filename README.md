# Data Visualization and Reproducible Research

> Isabel Majdoch 


The following is a sample of products created during the _"Data Visualization and Reproducible Research"_ course.


## Project 01

In the `project_01/` folder you can find reasearch to determine which genres and story types are the most financially successful in Hollywood movies. 

**Sample data visualization:** 

My favorite visualization, a Heatmap that shows profitiability by genre and story. 

<img src="figures/Majdoch_P1_Heatmap.png" width="70%" height="70%">

Top performers included:

1. **Monster Force - Drama**  
2. **Wretched Excess - Drama**  
3. **Journey and Return - Drama**  
4. **Maturation - Biography**  
5. **Monster Force - Horror**

#### Accessibility Example

Within the heatmap, you also are able to see where **accessability** is present throughout the revised project. 

```
{r, fig.alt="Heatmap showing average profitability for each combination of genre and story type, with darker colors indicating higher ROI."}
heat_data <- movie %>%
  group_by(Genre, Story) %>%
  summarise(
    avg_profit = mean(Profitability, na.rm = TRUE),
    n = n()
  ) %>%
  filter(n >= 3)

ggplot(heat_data, aes(x = Genre, y = Story, fill = avg_profit)) +
  geom_tile(color = "white", linewidth = 0.4) +
  scale_fill_viridis_c(option = "C", direction = -1) +
  labs(
    title = "Profitability Heatmap by Genre and Story",
    subtitle = "Darker colors indicate higher average ROI",
    x = "Genre",
    y = "Story",
    fill = "Avg ROI"
  ) +
  theme_isabel() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid = element_blank()
  )
```

- Colorblind‑safe palettes (viridis everywhere)
- Alt text for every figure
- No meaning encoded by color alone

#### Redesign a bad chart (before / after)

<table>
  <tr>
    <td><img src="figures/Majdoch_P1_Before.png" width="350"></td>
    <td><img src="figures/Majdoch_P1_After.png" width="350"></td>
  </tr>
  <tr>
    <td align="center"><strong>Before</strong></td>
    <td align="center"><strong>After</strong></td>
  </tr>
</table>

The redesigned version improves clarity by:

- Using a perceptually uniform palette
- Adding percentage labels
- Sorting genres by frequency
- Applying a consistent theme

#### Interactive Graph

<img src="figures/Majdoch_P1_Interactive.png" width="70%" height="70%">

The viewer can hover over each bubble to reveal exact values for profitability, opening weekend revenue, and budget. This makes it possible to compare genres more precisely, inspect outliers, and understand the underlying numbers without cluttering the visual with labels. Interactivity also allows the reader to focus on specific points of interest rather than interpreting everything at once, which improves clarity and engagement.

---

## Project 02

In this project, I explored how different types of recipes around the world's micro nutrients (protien, fats, and carbs) compare. Find the code and report in the `project_02/` folder.

**Sample data visualization:** 

My favority visualization is the interactive bubble graph that shows the carb, protien, and fat content per average cuisine.

<img src="figures/Majdoch_P2_Interactive.png" width="80%" height="80%">

With a static image chart you wouldn't be able to get all of those details and it would be significantly more difficult to tell the difference between the different countries. 

#### Accessibility Example

Within the revised graphs in Project 2, you also are able to see where **accessability** is present throughout the revised project.

- **Accessibility**: Added alt text to all figures and replaced custom palettes with colorblind‑safe viridis scales.
- **Theme revision**: Updated the custom theme to ensure consistent contrast and readability.

```
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

#### Redesign a bad chart (before / after)

<table>
  <tr>
    <td><img src="figures/Majdoch_P2_Before.png" width="350"></td>
    <td><img src="figures/Majdoch_P2_After.png" width="350"></td>
  </tr>
  <tr>
    <td align="center"><strong>Before</strong></td>
    <td align="center"><strong>After</strong></td>
  </tr>
</table>

The revisions provide better accessibility wise, with the color palette being easier to read for color blind and providing alt text. It also labels the countries with the most protein content, naming them, for better readability. Also the title is centered so it can be properly read.

---

## Project 03

In this project, I explored the TPA weather dataset and recreated some of the 2016 TPA graphs into 2022. I also explain some of the text bigrams in Fl Poly News dataset. 

#### Interactive

**Sample data visualization:** 

<img src="figures/Majdoch_P3_Interactive.png" width="80%" height="80%">

This is also an interactive graph, that when hovered over shows the specific rain amount on that day.

#### Redesign a bad chart (before / after)
<table>
  <tr>
    <td><img src="figures/Majdoch_P3_Before.png" width="350"></td>
    <td><img src="figures/Majdoch_P3_After.png" width="350"></td>
  </tr>
  <tr>
    <td align="center"><strong>Before</strong></td>
    <td align="center"><strong>After</strong></td>
  </tr>
</table>

The original plot relied on default smoothing, identical y‑axis scales, and had no reference lines, making it difficult to compare central tendencies or understand how distributions varied across months.

#### Accessibility Example

Within the revised graphs in Project 2, you also are able to see where **accessability** is present throughout the revised project.

- **Accessibility**: Added alt text to all figures and replaced custom palettes with colorblind‑safe viridis scales.
- **Theme revision**: Updated the custom theme to ensure consistent contrast and readability.

```
{r, fig.alt="Distribution of daily maximum temperatures in Tampa for each month of 2022."}

library(tidyverse)
library(ggridges)
library(viridis)

weather_tpa %>%
  mutate(month = factor(month,
                        levels = 1:12,
                        labels = month.name)) %>%
  ggplot(aes(
    x = max_temp,
    y = month,
    fill = month
  )) +
  geom_density_ridges(
    color = "black",
    quantile_lines = TRUE,
    quantiles = 2
  ) +
  scale_fill_viridis_d(option = "plasma") +
  labs(
    x = "Maximum temperature (°F)",
    y = NULL,
    title = "Distribution of Daily Maximum Temperatures in Tampa (2022)"
  ) +
  theme_minimal()
```

This code shows the use of viridis, a color blind safe pallette. Also used alt text. 

**FL Poly Bigram Graph**
<img src="figures/Majdoch_P3_P2.png" width="80%" height="80%">

### Moving Forward

Working on this project helped me understand how data visualization and reproducible research fit together. I learned how graphs can be improved, especially when using consistent themes and colorblind‑safe palettes. Revising my earlier work also showed me the value of storytelling, that they are more effective when they go towards a question rather than stand alone. I also gained more confidence in using R Markdown to create fully reproducible workflows, which is something I want to continue improving. Going forward, I plan to explore more interactive visualizations and learn additional libraries for presenting information in ways that are engaging.
