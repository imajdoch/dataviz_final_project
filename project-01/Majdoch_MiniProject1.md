---
title: "Data Visualization Mini-Project 1 **Revised**"
subtitle: "Isabel Majdoch - imajdoch0433@floridapoly.edu"
output:
  html_document:
    df_print: paged
---

# **Introduction**

The goal of this project was to explore the **HollywoodMovies.csv** dataset and determine:

> **Which genres and story types are the most financially successful?**

The dataset contains **970 films** and **16 variables**, including financial metrics (Budget, OpeningWeekend, WorldGross, Profitability), categorical descriptors (Genre, Story), and audience feedback (RottenTomatoes, AudienceScore).

My analysis focused on variables most relevant to financial performance:

- **Genre**  
- **Story**  
- **Budget**  
- **Profitability**  
- **BOAvgOpenWeekend**

The project involved data cleaning, visualization design, and narrative storytelling to uncover patterns in how genre and story structure influence financial outcomes.


```{r}
library(tidyverse)
movie <- readr::read_csv(
  "https://raw.githubusercontent.com/aalhamadani/datasets/main/HollywoodMovies.csv"
)

```
```{r}
theme_isabel <- function() {
  theme_minimal(base_size = 13) +
    theme(
      plot.background = element_rect(fill = "#faf6ef", color = NA),
      panel.grid.major = element_line(color = "#e6dcc7"),
      panel.grid.minor = element_blank(),
      
      plot.title = element_text(
        size = 20, face = "bold",
        hjust = 0.5, color = "#b8860b"
      ),
      plot.subtitle = element_text(
        size = 12, hjust = 0.5, color = "#6b5b4d"
      ),
      axis.title = element_text(size = 12, face = "bold", color = "#5a4a3a"),
      axis.text = element_text(size = 10, color = "#4a3a2a"),
      strip.text = element_text(
        size = 12, face = "bold",
        color = "#b8860b", margin = margin(b = 5)
      ),
      legend.background = element_rect(fill = "#faf6ef", color = NA),
      legend.text = element_text(color = "#4a3a2a"),
      legend.title = element_text(color = "#b8860b", face = "bold")
    )
}



```


This project will explore the **HolywoodMovies.csv** dataset that was found under the *aalhamadani* Github Repo. This dataset contains 970 movies and 16 variables that can be explored.

```{r}
summarize(movie)
head(movie)
str(movie)
glimpse(movie)
```


This dataset explore several different variables including:
```{r}
names(movie)
```
```{r}
library(tidyr)
movie <- movie %>% drop_na()
```


---

# **Original Charts Planned**

At the start of the assignment, I planned several **bar charts** to explore the distribution of genres and stories. These were meant to establish a baseline for understanding which genres are most common and how stories are distributed across them.

As the analysis progressed, the visualizations evolved:

- A **genre distribution bar chart** to show which genres dominate the dataset.
- A **top stories per genre** visualization. Initially, combining all genres into one plot was unreadable, so I shifted to **individual faceted charts** showing the top five stories within each genre. This greatly improved clarity.
- Several **financial comparison charts**, including:
  - Profitability by Genre  
  - Opening Weekend vs. Profitability  
  - Profitability by Story  
  - A combined **Genre × Story heatmap**

These changes reflected a deeper understanding of the data and helped shape the narrative more effectively.

---

# **Data Cleaning and Preparation**

Before creating visualizations, several data quality issues needed to be addressed.

- The dataset contained **missing values**, especially in the Story variable. I used `drop_na()` to remove incomplete rows for the variables used in analysis.
- Story labels were inconsistent (blank strings, whitespace, capitalization differences). I standardized them using string cleaning functions.
- Without these cleaning steps, the analysis would have been misleading, especially when grouping by story type.

These preprocessing steps ensured that the visualizations accurately reflected the underlying patterns.


# Data Cleaning
```{r}
movie <- movie %>%
  drop_na() %>%
  mutate(
    Story = trimws(Story),
    Story = tolower(Story),
    Story = na_if(Story, ""),
    Story = na_if(Story, "na")
  ) %>%
  filter(!is.na(Story))

```

```{r}
# Prepare data safely (avoid name collision with ggplot2::theme)
top_stories <- movie %>%
  count(Genre, Story, name = "count") %>%
  group_by(Genre) %>%
  slice_max(count, n = 5, with_ties = FALSE) %>%
  ungroup() %>%
  mutate(Story_wrapped = stringr::str_wrap(Story, width = 25))

# Extract unique genres for looping
unique_genres <- unique(top_stories$Genre)

```

---

# **The Story**

## **Genre Popularity**

I began by examining which genres appeared most frequently. This provided context for later financial comparisons. For example, if documentaries or musicals (which appear less often) were highly profitable, that would raise questions about why they aren’t produced more. Conversely, if high‑volume genres like Comedy or Action performed poorly, that would suggest a mismatch between production and audience demand.

# Redesign a bad chart

## Before

```{r}
ggplot(movie, aes(x = Genre, fill = RottenTomatoes > 50)) + 
  geom_bar() +
  labs(
    title = "Popularity of Movie Genres",
    x = "Genre",
    y = "Total"
  ) + coord_flip() +
  theme_bw()
```


## After

```{r, fig.alt="Bar chart showing the number of movies in each genre, sorted from most to least common."}
movie %>%
  group_by(Genre) %>%
  summarise(
    n = n(),
    pct_fresh = mean(RottenTomatoes > 50) * 100
  ) %>%
  arrange(desc(n)) %>%
  ggplot(aes(x = reorder(Genre, n), y = n, fill = n)) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(pct_fresh), "% fresh")),
    hjust = -0.1,
    size = 3.5,
    color = "#4a3a2a"
  ) +
  scale_fill_viridis_c(option = "C") +
  coord_flip(clip = "off") +
  labs(
    title = "Popularity of Movie Genres",
    subtitle = "Text labels show % of movies with RottenTomatoes > 50",
    x = "Genre",
    y = "Total Movies"
  ) +
  theme_isabel() +
  theme(plot.margin = margin(r = 20))


```

The revised chart has the same underlying data as the original stacked version but has greater clarity and visual impact. Instead of splitting each bar into “fresh” and “rotten” segments, the updated design keeps total counts intact while adding percentage labels that show the share of movies with RottenTomatoes scores above 50. The use of a perceptually uniform color gradient highlights genre popularity, and the Hollywood Gold theme unifies the visual style across the report. This approach makes the chart easier to interpret at a glance.

## **Top Stories Within Genres**

Several patterns emerged:

- Some genres rely heavily on a small set of story structures  
  - e.g., **“Love”** dominates Romance, **“Monster Force”** dominates Horror  
- Other genres are more diverse  
  - e.g., Animation includes **Journey and Return**, **Quest**, **Rescue**, **Fish Out of Water**, and **Comedy**

Understanding these patterns helped contextualize the financial results that followed.


```{r, fig.alt="Bar charts showing the top five story types within each genre, with bars sorted by frequency."}
library(ggplot2)
library(dplyr)
library(tidytext)
library(stringr)

for (g in unique_genres) {
  genre_data <- top_stories %>% 
    filter(Genre == g) %>%
    arrange(count)
  
  p <- ggplot(genre_data, aes(
    x = reorder(Story_wrapped, count),
    y = count,
    fill = count
  )) +
    geom_col() +
    scale_fill_viridis_c(option = "C") +
    coord_flip() +
    labs(
      title = paste("Top 5 Stories in", g),
      subtitle = "Most frequently used narrative structures",
      x = "Story Type",
      y = "Frequency"
    ) +
    theme_isabel()
  
  print(p)
}


```

## **Financial Performance — Genre**

The profitability chart revealed which genres deliver the highest return on investment.

The **Opening Weekend vs. Profitability bubble chart** showed:

- Some genres open strong but are not profitable  
  - e.g., **Fantasy** films often have large opening weekends but low profitability  
- Others have modest openings but excellent long‑term ROI  
  - e.g., **Horror** films tend to open small but generate high profit  
- Budget size plays a major role in shaping these outcomes

```{r}
genre_finances <- movie %>%
  group_by(Genre) %>%
  summarise(
    avg_profitability = mean(Profitability, na.rm = TRUE),
    avg_opening_weekend = mean(OpeningWeekend, na.rm = TRUE),
    avg_budget = mean(Budget, na.rm = TRUE),
    n_movies = n()
  ) %>%
  arrange(desc(avg_profitability))

```


```{r, fig.alt="Bar chart showing average profitability for each movie genre, sorted from highest to lowest ROI."}
genre_finances %>%
  arrange(desc(avg_profitability)) %>%
  ggplot(aes(
    x = reorder(Genre, avg_profitability),
    y = avg_profitability,
    fill = avg_profitability
  )) +
  geom_col() +
  scale_fill_viridis_c(option = "C") +
  coord_flip() +
  labs(
    title = "Average Profitability by Genre",
    x = "Genre",
    y = "ROI"
  ) +
  theme_isabel()


```

## One Interactive Chart

```{r, fig.alt="Interactive bubble chart comparing genres by opening weekend revenue and profitability, with bubble size representing average budget."}
library(plotly)

p <- genre_finances %>%
  ggplot(aes(
    x = avg_opening_weekend,
    y = avg_profitability,
    size = avg_budget,
    color = Genre,
    text = paste(
      "Genre:", Genre,
      "<br>Avg Profitability:", round(avg_profitability, 2),
      "<br>Avg Opening Weekend:", round(avg_opening_weekend, 2),
      "<br>Avg Budget:", round(avg_budget, 2)
    )
  )) +
  geom_point(alpha = 0.8) +
  scale_color_viridis_d(option = "C") +
  labs(
    title = "Profitability vs Opening Weekend by Genre",
    subtitle = "Bubble size represents average budget",
    x = "Opening Weekend ($)",
    y = "Profitability (ROI)"
  ) +
  theme_isabel()

ggplotly(p, tooltip = "text") %>%
  layout(
    title = list(
      text = paste0(
        "Profitability vs Opening Weekend - Genre<br>",
        "<sup>Bubble size represents average budget</sup>"
      )
    )
  )


```

With interactivity, the viewer can hover over each bubble to reveal exact values for profitability, opening weekend revenue, and budget. This makes it possible to compare genres more precisely, inspect outliers, and understand the underlying numbers without cluttering the visual with labels. Interactivity also allows the reader to focus on specific points of interest rather than interpreting everything at once, which improves clarity and engagement.

## **Financial Performance — Story**

Story type also plays a significant role in financial success. Some stories consistently produce high profitability across genres, while others underperform even within traditionally strong genres.

```{r}
story_finances <- movie %>%
  group_by(Story) %>%
  summarise(
    avg_profitability = mean(Profitability, na.rm = TRUE),
    avg_opening_weekend = mean(OpeningWeekend, na.rm = TRUE),
    avg_budget = mean(Budget, na.rm = TRUE),
    n_movies = n()
  ) %>%
  filter(n_movies >= 3) %>%
  arrange(desc(avg_profitability))

```


```{r, fig.alt="Bar chart showing average profitability for each story type, including only stories with at least three films."}

story_finances %>%
  arrange(desc(avg_profitability)) %>%
  ggplot(aes(
    x = reorder(Story, avg_profitability),
    y = avg_profitability,
    fill = avg_profitability
  )) +
  geom_col() +
  scale_fill_viridis_c(option = "C") +
  coord_flip() +
  labs(
    title = "Average Profitability by Story Type",
    subtitle = "Only stories with at least 3 films included",
    x = "Story Type",
    y = "ROI"
  ) +
  theme_isabel()


```

## **Genre × Story Heatmap**

This was the most informative visualization in the project. It revealed:

- Which story–genre combinations are consistently profitable  
- Which combinations studios rely on but may not perform well  
- Which stories succeed across multiple genres  
- Which genres depend on specific stories to perform well  

The heatmap directly addressed the central question:

> **Which Genre × Story combinations have the highest ROI?**

Top performers included:

1. **Monster Force - Drama**  
2. **Wretched Excess - Drama**  
3. **Journey and Return - Drama**  
4. **Maturation - Biography**  
5. **Monster Force - Horror**

These results highlight how narrative structure interacts with genre to influence financial outcomes.

```{r, fig.alt="Heatmap showing average profitability for each combination of genre and story type, with darker colors indicating higher ROI."}
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

---

# **Conclusion**

This project demonstrates how data visualization techniques can be used to uncover meaningful patterns in film performance. By analyzing both genre and story structure, I identified which combinations tend to drive financial success in Hollywood films. The visualizations worked together to build a narrative that connects production choices, narrative structure, and financial outcomes.

---

# What I changed 
- Revising my code improved both the clarity of my analysis. The updated version uses cleaner data prep steps, consistent styling with a theme, and colorblind‑safe palettes that make the visuals more accessible. 
- Sorting the bar charts strengthened the storytelling by highlighting the most important patterns first, and adding alt text improved the accessibility of the entire report. 
- The interactive bubble chart was the biggest enhancement, allowing to explore exact values and relationships that a static image couldn't.
