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

#### Interactive Graph

<img src="figures/Majdoch_P1_Interactive.png" width="70%" height="70%">

The viewer can hover over each bubble to reveal exact values for profitability, opening weekend revenue, and budget. This makes it possible to compare genres more precisely, inspect outliers, and understand the underlying numbers without cluttering the visual with labels. Interactivity also allows the reader to focus on specific points of interest rather than interpreting everything at once, which improves clarity and engagement.


## Project 02

In this project, I explored how different types of recipes around the world's micro nutrients (protien, fats, and carbs) compare. Find the code and report in the `project_02/` folder.

**Sample data visualization:** 

_[include your favorite visualization from this project here]_
<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/fl_higher_ed.png" width="80%" height="80%">

(you can place your figures in the `figures/` folder and use the `![](path_to_picture)` option to add the pictures here)


## Project 03

In this project, I explored ... _[short description of the data visualizations you for this part of the project produced goes here]_

**Sample data visualization:** 

_[include your favorite visualization from this project here]_
<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/concrete_density.png" width="80%" height="80%">


### Moving Forward

_Please add here a short reflection on what you learned and what you plan to continue exploring in terms of data visualization, data storytelling, reproducible research, and/or related topics._
