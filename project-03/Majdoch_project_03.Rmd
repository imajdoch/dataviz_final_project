---
title: "Data Visualization for Exploratory Data Analysis"
subtitle: "Isabel Majdoch"
date: "6/25/2026"
output: 
  html_document:
    keep_md: true
    toc: true
    toc_float: true
---

# Data Visualization Project 03


In this exercise you will explore methods to create different types of data visualizations (such as plotting text data, or exploring the distributions of continuous variables).


## PART 1: Density Plots

Using the dataset obtained from FSU's [Florida Climate Center](https://climatecenter.fsu.edu/climate-data-access-tools/downloadable-data), for a station at Tampa International Airport (TPA) for 2022, attempt to recreate the charts shown below which were generated using data from 2016. You can read the 2022 dataset using the code below: 


``` r
library(tidyverse)
weather_tpa <- read_csv("https://raw.githubusercontent.com/aalhamadani/datasets/master/tpa_weather_2022.csv")
# random sample 
sample_n(weather_tpa, 4)
```

```
## # A tibble: 4 × 7
##    year month   day precipitation max_temp min_temp ave_temp
##   <dbl> <dbl> <dbl>         <dbl>    <dbl>    <dbl>    <dbl>
## 1  2022     1    25          0.67       57       50     53.5
## 2  2022     1     2          0          82       71     76.5
## 3  2022    10    14          0          88       71     79.5
## 4  2022     1    19          0          75       47     61
```

``` r
glimpse(weather_tpa)
```

```
## Rows: 365
## Columns: 7
## $ year          <dbl> 2022, 2022, 2022, 2022, 2022, 2022, 2022, 2022, 2022, 20…
## $ month         <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
## $ day           <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 1…
## $ precipitation <dbl> 0.00000, 0.00000, 0.02000, 0.00000, 0.00000, 0.00001, 0.…
## $ max_temp      <dbl> 82, 82, 75, 76, 75, 74, 81, 81, 84, 81, 73, 77, 74, 72, …
## $ min_temp      <dbl> 67, 71, 55, 50, 59, 56, 63, 58, 65, 64, 54, 54, 59, 55, …
## $ ave_temp      <dbl> 74.5, 76.5, 65.0, 63.0, 67.0, 65.0, 72.0, 69.5, 74.5, 72…
```

See Slides from Week 4 of Visualizing Relationships and Models (slide 10) for a reminder on how to use this type of dataset with the `lubridate` package for dates and times (example included in the slides uses data from 2016).

Using the 2022 data: 

---

(a) Create a plot like the one below:

<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/tpa_max_temps_facet.png" alt="" width="80%" style="display: block; margin: auto;" />

Hint: the option `binwidth = 3` was used with the `geom_histogram()` function.

### Max Temp TPA Per Month


``` r
library(tidyverse)

weather_tpa %>%
  mutate(month = factor(month,
                        levels = 1:12,
                        labels = month.name)) %>%
  ggplot(aes(x = max_temp, fill = month)) +
  geom_histogram(binwidth = 3, color = "white") +
  facet_wrap(~ month, ncol = 4) +
  scale_fill_viridis_d() +
  labs(
    x = "Maximum temperatures (F)",
    y = "Number of Days",
    title = "Distribution of Daily Maximum Temperatures in TPA (2022)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    strip.background = element_rect(fill = "grey90", color = NA),
    strip.text = element_text(face = "bold"),
  )
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-3-1.png" alt="Histogram showing the distribution of daily maximum temperatures in Tampa for each month of 2022. Each panel represents one month and displays the number of days falling into 3‑degree temperature bins."  />

---

(b) Create a plot like the one below:

<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/tpa_max_temps_density.png" alt="" width="80%" style="display: block; margin: auto;" />

### Density Max Temp TPA


``` r
library(tidyverse)

ggplot(weather_tpa, aes(x = max_temp)) +
  geom_density(
    fill = "gray40",
    color = "black",
    bw = 0.5,  
    kernel = "gaussian"
  ) +
  labs(
    x = "Maximum temperature (F)",
    y = "Density",
    title = "Density of Daily Maximum Temperatures in TPA (2022)"
  ) +
  theme_minimal(base_size = 12)
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-5-1.png" alt="Density plot showing the distribution of daily maximum temperatures in Tampa for 2022."  />

Hint: check the `kernel` parameter of the `geom_density()` function, and use `bw = 0.5`.

---

(c) Create a plot like the one below:

<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/tpa_max_temps_density_facet.png" alt="" width="80%" style="display: block; margin: auto;" />

Hint: default options for `geom_density()` were used. 

### Monthly Density Plots


``` r
library(tidyverse)

weather_tpa %>%
  mutate(month = factor(month,
                        levels = 1:12,
                        labels = month.name)) %>%
  ggplot(aes(x = max_temp, fill = month)) +
  geom_density(color = "black") +   # default kernel and bandwidth
  facet_wrap(~ month, ncol = 4) +
  scale_fill_viridis_d() +
  labs(
    title = "Density plots for each month in 2022",
    x = "Maximum temperatures (F)",
    y = "Density"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    strip.background = element_rect(fill = "grey90", color = NA),
    strip.text = element_text(face = "bold"),
    legend.position = "none"
  )
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-7-1.png" alt="Density plots showing the distribution of daily maximum temperatures in Tampa for each month of 2022."  />

## Improved Graph
### After


``` r
library(tidyverse)
library(viridis)
```

```
## Warning: package 'viridis' was built under R version 4.5.3
```

```
## Loading required package: viridisLite
```

``` r
weather_tpa %>%
  mutate(
    month = factor(month,
                   levels = 1:12,
                   labels = month.name)
  ) %>%
  ggplot(aes(x = max_temp, fill = month)) +
  geom_density(alpha = 0.6, color = "black", linewidth = 0.4) +
  geom_vline(
    data = weather_tpa %>%
      mutate(month = factor(month, levels = 1:12, labels = month.name)) %>%
      group_by(month) %>%
      summarize(med = median(max_temp, na.rm = TRUE)),
    aes(xintercept = med),
    color = "red",
    linewidth = 0.6,
    linetype = "dashed"
  ) +
  facet_wrap(~ month, ncol = 4, scales = "free_y") +
  scale_fill_viridis_d(option = "plasma") +
  labs(
    title = "Monthly Distributions of Daily Max Temps in TPA (2022)",
    subtitle = "Improved version",
    x = "Maximum Temperature (F)",
    y = "Density",
    fill = "Month"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    strip.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11),
    panel.spacing = unit(1, "lines")
  )
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-8-1.png" alt="A grid of twelve density plots showing the distribution of daily maximum temperatures in Tampa for each month of 2022."  />

The original plot relied on default smoothing, identical y‑axis scales, and had no reference lines, making it difficult to compare central tendencies or understand how distributions varied across months.

---

(d) Generate a plot like the chart below:


<img src="https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/figures/tpa_max_temps_ridges_plasma.png" alt="" width="80%" style="display: block; margin: auto;" />

Hint: use the`{ggridges}` package, and the `geom_density_ridges()` function paying close attention to the `quantile_lines` and `quantiles` parameters. The plot above uses the `plasma` option (color scale) for the _viridis_ palette.


### Daily Max Temp TPA Monthly


``` r
library(tidyverse)
library(ggridges)
```

```
## Warning: package 'ggridges' was built under R version 4.5.3
```

``` r
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

```
## Picking joint bandwidth of 1.93
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-10-1.png" alt="Distribution of daily maximum temperatures in Tampa for each month of 2022."  />

---

## Interactive Graph

### Precipitation Calender

(e) Create a plot of your choice that uses the attribute for precipitation _(values of -99.9 for temperature or -99.99 for precipitation represent missing data)_.


``` r
library(tidyverse)
library(plotly)
```

```
## Warning: package 'plotly' was built under R version 4.5.3
```

```
## 
## Attaching package: 'plotly'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     last_plot
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```
## The following object is masked from 'package:graphics':
## 
##     layout
```

``` r
library(lubridate)

weather_clean <- weather_tpa %>%
  mutate(
    precipitation = na_if(precipitation, -99.99),
    date = as.Date(paste(year, month, day, sep = "-")),
    month_name = month(date, label = TRUE, abbr = FALSE)
  )

p <- weather_clean %>%
  ggplot(aes(
    x = day,
    y = month_name,
    fill = precipitation,
    text = paste(
      "Date:", date,
      "<br>Precipitation:", precipitation, "in"
    )
  )) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "plasma", na.value = "grey90") +
  scale_y_discrete(limits = rev) +
  labs(
    title = "Precipitation Calendar TPA 2022",
    x = "Day of Month",
    y = "Month",
    fill = "Precip (in)"
  ) +
  theme_minimal(base_size = 12)

ggplotly(p, tooltip = "text")
```

```{=html}
<div class="plotly html-widget html-fill-item" id="htmlwidget-4182b6fa4328b693f17e" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-4182b6fa4328b693f17e">{"x":{"data":[{"x":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],"y":[1,2,3,4,5,6,7,8,9,10,11,12],"z":[[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.38111888111888115,0.017482517482517484,0.0069930069930069939,0.013986013986013988,0,0.038461538461538464,0.20979020979020979,0.052447552447552448,3.496503496503497e-06,0,0,0,0,0,0,0,0.10139860139860139],[0,0,0.31468531468531469,0,3.496503496503497e-06,3.496503496503497e-06,0,0.02097902097902098,0.031468531468531472,0.86013986013986021,0.26573426573426573,0.0034965034965034969,0.0034965034965034969,0,0,0.048951048951048959,0,0,0,0.13636363636363638,3.496503496503497e-06,0,0.017482517482517484,0,3.496503496503497e-06,0,0.094405594405594415,0,0,0.013986013986013988,null],[0,0,0,0,0,0,0,0,0,3.496503496503497e-06,3.496503496503497e-06,0.0069930069930069939,0.1048951048951049,0,0,0,3.496503496503497e-06,0.0034965034965034969,0,0,0,0,0,0,0,0,0.02097902097902098,0.24825174825174826,0,0,0],[0.95804195804195813,0.49300699300699302,0.13986013986013987,0,0,0,0.034965034965034968,0.57342657342657344,0.045454545454545456,0.38111888111888115,0.0069930069930069939,0.01048951048951049,0.01048951048951049,0.02097902097902098,0,0.30419580419580422,0.02097902097902098,0,0.0069930069930069939,0.024475524475524479,3.496503496503497e-06,0,0.37412587412587417,0,0,3.496503496503497e-06,0.027972027972027975,0.86363636363636376,0,0,null],[0,3.496503496503497e-06,0.34265734265734266,0.4335664335664336,3.496503496503497e-06,0.013986013986013988,0.083916083916083919,0.02097902097902098,0.44755244755244761,0,0,0,0,3.496503496503497e-06,3.496503496503497e-06,0,0.2237762237762238,0,0,0.16433566433566432,0.15734265734265734,0,0,0.21328671328671328,0.1083916083916084,3.496503496503497e-06,0.0069930069930069939,0.055944055944055951,0,0,0.0034965034965034969],[3.496503496503497e-06,3.496503496503497e-06,0,3.496503496503497e-06,0.0034965034965034969,0.017482517482517484,0.01048951048951049,0.066433566433566432,0,0.30419580419580422,0.22027972027972029,0,0,0.72727272727272729,0,1,0.27272727272727276,0,0.0069930069930069939,0,0,0.57342657342657344,0.59090909090909094,0,0.0069930069930069939,0.39160839160839167,0,0,0,0,0],[3.496503496503497e-06,0.55944055944055948,3.496503496503497e-06,0.16433566433566432,0,0,0.055944055944055951,0,0.034965034965034968,0.0034965034965034969,0.98251748251748261,0,0,0,0.038461538461538464,3.496503496503497e-06,0,0,0.013986013986013988,0.034965034965034968,0,0,0,0.066433566433566432,0,0,0.44755244755244761,0.031468531468531472,0.013986013986013988,0.37412587412587417,null],[0.01048951048951049,0,0.2167832167832168,0,0,0,0.052447552447552448,0,0,0,0,0,0,0,0,0,0,0,0,0.059440559440559447,3.496503496503497e-06,0,3.496503496503497e-06,0.0034965034965034969,0,0,0,0,0,0.57692307692307687,0.027972027972027975],[0.47902097902097907,0.38811188811188818,0,0,0,0,0.4685314685314686,0,0,0,0,0,0,0,0.0069930069930069939,0,0,0,0,0,0,0,0,0,0,0,0,0.048951048951048959,0.42657342657342656,0.54545454545454553,null],[0,0,0,0,0,0,0,0,0,3.496503496503497e-06,0,0.14335664335664336,0,0,0.36363636363636365,3.496503496503497e-06,0,0,0,0,0,0,0,0.49650349650349651,0,0,0,0,0,0,0.013986013986013988],[0,0,0,0,0.0069930069930069939,0.0069930069930069939,0,0.12237762237762237,3.496503496503497e-06,0,0,3.496503496503497e-06,0.034965034965034968,0,0,0,0,0,0.045454545454545456,0,0,0,0,0,0,0,0,0,null,null,null],[0,0,0.0069930069930069939,0,0,3.496503496503497e-06,3.496503496503497e-06,0,0,0,0,0,0,0,0,0.23776223776223779,0,0,0,0,0,0.0034965034965034969,3.496503496503497e-06,0,0.2342657342657343,0.027972027972027975,0,3.496503496503497e-06,0,0,0]],"text":[["Date: 2022-12-01 <br>Precipitation: 0 in","Date: 2022-12-02 <br>Precipitation: 0 in","Date: 2022-12-03 <br>Precipitation: 0 in","Date: 2022-12-04 <br>Precipitation: 0 in","Date: 2022-12-05 <br>Precipitation: 0 in","Date: 2022-12-06 <br>Precipitation: 0 in","Date: 2022-12-07 <br>Precipitation: 0 in","Date: 2022-12-08 <br>Precipitation: 0 in","Date: 2022-12-09 <br>Precipitation: 0 in","Date: 2022-12-10 <br>Precipitation: 0 in","Date: 2022-12-11 <br>Precipitation: 0 in","Date: 2022-12-12 <br>Precipitation: 0 in","Date: 2022-12-13 <br>Precipitation: 0 in","Date: 2022-12-14 <br>Precipitation: 0 in","Date: 2022-12-15 <br>Precipitation: 1.09 in","Date: 2022-12-16 <br>Precipitation: 0.05 in","Date: 2022-12-17 <br>Precipitation: 0.02 in","Date: 2022-12-18 <br>Precipitation: 0.04 in","Date: 2022-12-19 <br>Precipitation: 0 in","Date: 2022-12-20 <br>Precipitation: 0.11 in","Date: 2022-12-21 <br>Precipitation: 0.6 in","Date: 2022-12-22 <br>Precipitation: 0.15 in","Date: 2022-12-23 <br>Precipitation: 1e-05 in","Date: 2022-12-24 <br>Precipitation: 0 in","Date: 2022-12-25 <br>Precipitation: 0 in","Date: 2022-12-26 <br>Precipitation: 0 in","Date: 2022-12-27 <br>Precipitation: 0 in","Date: 2022-12-28 <br>Precipitation: 0 in","Date: 2022-12-29 <br>Precipitation: 0 in","Date: 2022-12-30 <br>Precipitation: 0 in","Date: 2022-12-31 <br>Precipitation: 0.29 in"],["Date: 2022-11-01 <br>Precipitation: 0 in","Date: 2022-11-02 <br>Precipitation: 0 in","Date: 2022-11-03 <br>Precipitation: 0.9 in","Date: 2022-11-04 <br>Precipitation: 0 in","Date: 2022-11-05 <br>Precipitation: 1e-05 in","Date: 2022-11-06 <br>Precipitation: 1e-05 in","Date: 2022-11-07 <br>Precipitation: 0 in","Date: 2022-11-08 <br>Precipitation: 0.06 in","Date: 2022-11-09 <br>Precipitation: 0.09 in","Date: 2022-11-10 <br>Precipitation: 2.46 in","Date: 2022-11-11 <br>Precipitation: 0.76 in","Date: 2022-11-12 <br>Precipitation: 0.01 in","Date: 2022-11-13 <br>Precipitation: 0.01 in","Date: 2022-11-14 <br>Precipitation: 0 in","Date: 2022-11-15 <br>Precipitation: 0 in","Date: 2022-11-16 <br>Precipitation: 0.14 in","Date: 2022-11-17 <br>Precipitation: 0 in","Date: 2022-11-18 <br>Precipitation: 0 in","Date: 2022-11-19 <br>Precipitation: 0 in","Date: 2022-11-20 <br>Precipitation: 0.39 in","Date: 2022-11-21 <br>Precipitation: 1e-05 in","Date: 2022-11-22 <br>Precipitation: 0 in","Date: 2022-11-23 <br>Precipitation: 0.05 in","Date: 2022-11-24 <br>Precipitation: 0 in","Date: 2022-11-25 <br>Precipitation: 1e-05 in","Date: 2022-11-26 <br>Precipitation: 0 in","Date: 2022-11-27 <br>Precipitation: 0.27 in","Date: 2022-11-28 <br>Precipitation: 0 in","Date: 2022-11-29 <br>Precipitation: 0 in","Date: 2022-11-30 <br>Precipitation: 0.04 in",null],["Date: 2022-10-01 <br>Precipitation: 0 in","Date: 2022-10-02 <br>Precipitation: 0 in","Date: 2022-10-03 <br>Precipitation: 0 in","Date: 2022-10-04 <br>Precipitation: 0 in","Date: 2022-10-05 <br>Precipitation: 0 in","Date: 2022-10-06 <br>Precipitation: 0 in","Date: 2022-10-07 <br>Precipitation: 0 in","Date: 2022-10-08 <br>Precipitation: 0 in","Date: 2022-10-09 <br>Precipitation: 0 in","Date: 2022-10-10 <br>Precipitation: 1e-05 in","Date: 2022-10-11 <br>Precipitation: 1e-05 in","Date: 2022-10-12 <br>Precipitation: 0.02 in","Date: 2022-10-13 <br>Precipitation: 0.3 in","Date: 2022-10-14 <br>Precipitation: 0 in","Date: 2022-10-15 <br>Precipitation: 0 in","Date: 2022-10-16 <br>Precipitation: 0 in","Date: 2022-10-17 <br>Precipitation: 1e-05 in","Date: 2022-10-18 <br>Precipitation: 0.01 in","Date: 2022-10-19 <br>Precipitation: 0 in","Date: 2022-10-20 <br>Precipitation: 0 in","Date: 2022-10-21 <br>Precipitation: 0 in","Date: 2022-10-22 <br>Precipitation: 0 in","Date: 2022-10-23 <br>Precipitation: 0 in","Date: 2022-10-24 <br>Precipitation: 0 in","Date: 2022-10-25 <br>Precipitation: 0 in","Date: 2022-10-26 <br>Precipitation: 0 in","Date: 2022-10-27 <br>Precipitation: 0.06 in","Date: 2022-10-28 <br>Precipitation: 0.71 in","Date: 2022-10-29 <br>Precipitation: 0 in","Date: 2022-10-30 <br>Precipitation: 0 in","Date: 2022-10-31 <br>Precipitation: 0 in"],["Date: 2022-09-01 <br>Precipitation: 2.74 in","Date: 2022-09-02 <br>Precipitation: 1.41 in","Date: 2022-09-03 <br>Precipitation: 0.4 in","Date: 2022-09-04 <br>Precipitation: 0 in","Date: 2022-09-05 <br>Precipitation: 0 in","Date: 2022-09-06 <br>Precipitation: 0 in","Date: 2022-09-07 <br>Precipitation: 0.1 in","Date: 2022-09-08 <br>Precipitation: 1.64 in","Date: 2022-09-09 <br>Precipitation: 0.13 in","Date: 2022-09-10 <br>Precipitation: 1.09 in","Date: 2022-09-11 <br>Precipitation: 0.02 in","Date: 2022-09-12 <br>Precipitation: 0.03 in","Date: 2022-09-13 <br>Precipitation: 0.03 in","Date: 2022-09-14 <br>Precipitation: 0.06 in","Date: 2022-09-15 <br>Precipitation: 0 in","Date: 2022-09-16 <br>Precipitation: 0.87 in","Date: 2022-09-17 <br>Precipitation: 0.06 in","Date: 2022-09-18 <br>Precipitation: 0 in","Date: 2022-09-19 <br>Precipitation: 0.02 in","Date: 2022-09-20 <br>Precipitation: 0.07 in","Date: 2022-09-21 <br>Precipitation: 1e-05 in","Date: 2022-09-22 <br>Precipitation: 0 in","Date: 2022-09-23 <br>Precipitation: 1.07 in","Date: 2022-09-24 <br>Precipitation: 0 in","Date: 2022-09-25 <br>Precipitation: 0 in","Date: 2022-09-26 <br>Precipitation: 1e-05 in","Date: 2022-09-27 <br>Precipitation: 0.08 in","Date: 2022-09-28 <br>Precipitation: 2.47 in","Date: 2022-09-29 <br>Precipitation: 0 in","Date: 2022-09-30 <br>Precipitation: 0 in",null],["Date: 2022-08-01 <br>Precipitation: 0 in","Date: 2022-08-02 <br>Precipitation: 1e-05 in","Date: 2022-08-03 <br>Precipitation: 0.98 in","Date: 2022-08-04 <br>Precipitation: 1.24 in","Date: 2022-08-05 <br>Precipitation: 1e-05 in","Date: 2022-08-06 <br>Precipitation: 0.04 in","Date: 2022-08-07 <br>Precipitation: 0.24 in","Date: 2022-08-08 <br>Precipitation: 0.06 in","Date: 2022-08-09 <br>Precipitation: 1.28 in","Date: 2022-08-10 <br>Precipitation: 0 in","Date: 2022-08-11 <br>Precipitation: 0 in","Date: 2022-08-12 <br>Precipitation: 0 in","Date: 2022-08-13 <br>Precipitation: 0 in","Date: 2022-08-14 <br>Precipitation: 1e-05 in","Date: 2022-08-15 <br>Precipitation: 1e-05 in","Date: 2022-08-16 <br>Precipitation: 0 in","Date: 2022-08-17 <br>Precipitation: 0.64 in","Date: 2022-08-18 <br>Precipitation: 0 in","Date: 2022-08-19 <br>Precipitation: 0 in","Date: 2022-08-20 <br>Precipitation: 0.47 in","Date: 2022-08-21 <br>Precipitation: 0.45 in","Date: 2022-08-22 <br>Precipitation: 0 in","Date: 2022-08-23 <br>Precipitation: 0 in","Date: 2022-08-24 <br>Precipitation: 0.61 in","Date: 2022-08-25 <br>Precipitation: 0.31 in","Date: 2022-08-26 <br>Precipitation: 1e-05 in","Date: 2022-08-27 <br>Precipitation: 0.02 in","Date: 2022-08-28 <br>Precipitation: 0.16 in","Date: 2022-08-29 <br>Precipitation: 0 in","Date: 2022-08-30 <br>Precipitation: 0 in","Date: 2022-08-31 <br>Precipitation: 0.01 in"],["Date: 2022-07-01 <br>Precipitation: 1e-05 in","Date: 2022-07-02 <br>Precipitation: 1e-05 in","Date: 2022-07-03 <br>Precipitation: 0 in","Date: 2022-07-04 <br>Precipitation: 1e-05 in","Date: 2022-07-05 <br>Precipitation: 0.01 in","Date: 2022-07-06 <br>Precipitation: 0.05 in","Date: 2022-07-07 <br>Precipitation: 0.03 in","Date: 2022-07-08 <br>Precipitation: 0.19 in","Date: 2022-07-09 <br>Precipitation: 0 in","Date: 2022-07-10 <br>Precipitation: 0.87 in","Date: 2022-07-11 <br>Precipitation: 0.63 in","Date: 2022-07-12 <br>Precipitation: 0 in","Date: 2022-07-13 <br>Precipitation: 0 in","Date: 2022-07-14 <br>Precipitation: 2.08 in","Date: 2022-07-15 <br>Precipitation: 0 in","Date: 2022-07-16 <br>Precipitation: 2.86 in","Date: 2022-07-17 <br>Precipitation: 0.78 in","Date: 2022-07-18 <br>Precipitation: 0 in","Date: 2022-07-19 <br>Precipitation: 0.02 in","Date: 2022-07-20 <br>Precipitation: 0 in","Date: 2022-07-21 <br>Precipitation: 0 in","Date: 2022-07-22 <br>Precipitation: 1.64 in","Date: 2022-07-23 <br>Precipitation: 1.69 in","Date: 2022-07-24 <br>Precipitation: 0 in","Date: 2022-07-25 <br>Precipitation: 0.02 in","Date: 2022-07-26 <br>Precipitation: 1.12 in","Date: 2022-07-27 <br>Precipitation: 0 in","Date: 2022-07-28 <br>Precipitation: 0 in","Date: 2022-07-29 <br>Precipitation: 0 in","Date: 2022-07-30 <br>Precipitation: 0 in","Date: 2022-07-31 <br>Precipitation: 0 in"],["Date: 2022-06-01 <br>Precipitation: 1e-05 in","Date: 2022-06-02 <br>Precipitation: 1.6 in","Date: 2022-06-03 <br>Precipitation: 1e-05 in","Date: 2022-06-04 <br>Precipitation: 0.47 in","Date: 2022-06-05 <br>Precipitation: 0 in","Date: 2022-06-06 <br>Precipitation: 0 in","Date: 2022-06-07 <br>Precipitation: 0.16 in","Date: 2022-06-08 <br>Precipitation: 0 in","Date: 2022-06-09 <br>Precipitation: 0.1 in","Date: 2022-06-10 <br>Precipitation: 0.01 in","Date: 2022-06-11 <br>Precipitation: 2.81 in","Date: 2022-06-12 <br>Precipitation: 0 in","Date: 2022-06-13 <br>Precipitation: 0 in","Date: 2022-06-14 <br>Precipitation: 0 in","Date: 2022-06-15 <br>Precipitation: 0.11 in","Date: 2022-06-16 <br>Precipitation: 1e-05 in","Date: 2022-06-17 <br>Precipitation: 0 in","Date: 2022-06-18 <br>Precipitation: 0 in","Date: 2022-06-19 <br>Precipitation: 0.04 in","Date: 2022-06-20 <br>Precipitation: 0.1 in","Date: 2022-06-21 <br>Precipitation: 0 in","Date: 2022-06-22 <br>Precipitation: 0 in","Date: 2022-06-23 <br>Precipitation: 0 in","Date: 2022-06-24 <br>Precipitation: 0.19 in","Date: 2022-06-25 <br>Precipitation: 0 in","Date: 2022-06-26 <br>Precipitation: 0 in","Date: 2022-06-27 <br>Precipitation: 1.28 in","Date: 2022-06-28 <br>Precipitation: 0.09 in","Date: 2022-06-29 <br>Precipitation: 0.04 in","Date: 2022-06-30 <br>Precipitation: 1.07 in",null],["Date: 2022-05-01 <br>Precipitation: 0.03 in","Date: 2022-05-02 <br>Precipitation: 0 in","Date: 2022-05-03 <br>Precipitation: 0.62 in","Date: 2022-05-04 <br>Precipitation: 0 in","Date: 2022-05-05 <br>Precipitation: 0 in","Date: 2022-05-06 <br>Precipitation: 0 in","Date: 2022-05-07 <br>Precipitation: 0.15 in","Date: 2022-05-08 <br>Precipitation: 0 in","Date: 2022-05-09 <br>Precipitation: 0 in","Date: 2022-05-10 <br>Precipitation: 0 in","Date: 2022-05-11 <br>Precipitation: 0 in","Date: 2022-05-12 <br>Precipitation: 0 in","Date: 2022-05-13 <br>Precipitation: 0 in","Date: 2022-05-14 <br>Precipitation: 0 in","Date: 2022-05-15 <br>Precipitation: 0 in","Date: 2022-05-16 <br>Precipitation: 0 in","Date: 2022-05-17 <br>Precipitation: 0 in","Date: 2022-05-18 <br>Precipitation: 0 in","Date: 2022-05-19 <br>Precipitation: 0 in","Date: 2022-05-20 <br>Precipitation: 0.17 in","Date: 2022-05-21 <br>Precipitation: 1e-05 in","Date: 2022-05-22 <br>Precipitation: 0 in","Date: 2022-05-23 <br>Precipitation: 1e-05 in","Date: 2022-05-24 <br>Precipitation: 0.01 in","Date: 2022-05-25 <br>Precipitation: 0 in","Date: 2022-05-26 <br>Precipitation: 0 in","Date: 2022-05-27 <br>Precipitation: 0 in","Date: 2022-05-28 <br>Precipitation: 0 in","Date: 2022-05-29 <br>Precipitation: 0 in","Date: 2022-05-30 <br>Precipitation: 1.65 in","Date: 2022-05-31 <br>Precipitation: 0.08 in"],["Date: 2022-04-01 <br>Precipitation: 1.37 in","Date: 2022-04-02 <br>Precipitation: 1.11 in","Date: 2022-04-03 <br>Precipitation: 0 in","Date: 2022-04-04 <br>Precipitation: 0 in","Date: 2022-04-05 <br>Precipitation: 0 in","Date: 2022-04-06 <br>Precipitation: 0 in","Date: 2022-04-07 <br>Precipitation: 1.34 in","Date: 2022-04-08 <br>Precipitation: 0 in","Date: 2022-04-09 <br>Precipitation: 0 in","Date: 2022-04-10 <br>Precipitation: 0 in","Date: 2022-04-11 <br>Precipitation: 0 in","Date: 2022-04-12 <br>Precipitation: 0 in","Date: 2022-04-13 <br>Precipitation: 0 in","Date: 2022-04-14 <br>Precipitation: 0 in","Date: 2022-04-15 <br>Precipitation: 0.02 in","Date: 2022-04-16 <br>Precipitation: 0 in","Date: 2022-04-17 <br>Precipitation: 0 in","Date: 2022-04-18 <br>Precipitation: 0 in","Date: 2022-04-19 <br>Precipitation: 0 in","Date: 2022-04-20 <br>Precipitation: 0 in","Date: 2022-04-21 <br>Precipitation: 0 in","Date: 2022-04-22 <br>Precipitation: 0 in","Date: 2022-04-23 <br>Precipitation: 0 in","Date: 2022-04-24 <br>Precipitation: 0 in","Date: 2022-04-25 <br>Precipitation: 0 in","Date: 2022-04-26 <br>Precipitation: 0 in","Date: 2022-04-27 <br>Precipitation: 0 in","Date: 2022-04-28 <br>Precipitation: 0.14 in","Date: 2022-04-29 <br>Precipitation: 1.22 in","Date: 2022-04-30 <br>Precipitation: 1.56 in",null],["Date: 2022-03-01 <br>Precipitation: 0 in","Date: 2022-03-02 <br>Precipitation: 0 in","Date: 2022-03-03 <br>Precipitation: 0 in","Date: 2022-03-04 <br>Precipitation: 0 in","Date: 2022-03-05 <br>Precipitation: 0 in","Date: 2022-03-06 <br>Precipitation: 0 in","Date: 2022-03-07 <br>Precipitation: 0 in","Date: 2022-03-08 <br>Precipitation: 0 in","Date: 2022-03-09 <br>Precipitation: 0 in","Date: 2022-03-10 <br>Precipitation: 1e-05 in","Date: 2022-03-11 <br>Precipitation: 0 in","Date: 2022-03-12 <br>Precipitation: 0.41 in","Date: 2022-03-13 <br>Precipitation: 0 in","Date: 2022-03-14 <br>Precipitation: 0 in","Date: 2022-03-15 <br>Precipitation: 1.04 in","Date: 2022-03-16 <br>Precipitation: 1e-05 in","Date: 2022-03-17 <br>Precipitation: 0 in","Date: 2022-03-18 <br>Precipitation: 0 in","Date: 2022-03-19 <br>Precipitation: 0 in","Date: 2022-03-20 <br>Precipitation: 0 in","Date: 2022-03-21 <br>Precipitation: 0 in","Date: 2022-03-22 <br>Precipitation: 0 in","Date: 2022-03-23 <br>Precipitation: 0 in","Date: 2022-03-24 <br>Precipitation: 1.42 in","Date: 2022-03-25 <br>Precipitation: 0 in","Date: 2022-03-26 <br>Precipitation: 0 in","Date: 2022-03-27 <br>Precipitation: 0 in","Date: 2022-03-28 <br>Precipitation: 0 in","Date: 2022-03-29 <br>Precipitation: 0 in","Date: 2022-03-30 <br>Precipitation: 0 in","Date: 2022-03-31 <br>Precipitation: 0.04 in"],["Date: 2022-02-01 <br>Precipitation: 0 in","Date: 2022-02-02 <br>Precipitation: 0 in","Date: 2022-02-03 <br>Precipitation: 0 in","Date: 2022-02-04 <br>Precipitation: 0 in","Date: 2022-02-05 <br>Precipitation: 0.02 in","Date: 2022-02-06 <br>Precipitation: 0.02 in","Date: 2022-02-07 <br>Precipitation: 0 in","Date: 2022-02-08 <br>Precipitation: 0.35 in","Date: 2022-02-09 <br>Precipitation: 1e-05 in","Date: 2022-02-10 <br>Precipitation: 0 in","Date: 2022-02-11 <br>Precipitation: 0 in","Date: 2022-02-12 <br>Precipitation: 1e-05 in","Date: 2022-02-13 <br>Precipitation: 0.1 in","Date: 2022-02-14 <br>Precipitation: 0 in","Date: 2022-02-15 <br>Precipitation: 0 in","Date: 2022-02-16 <br>Precipitation: 0 in","Date: 2022-02-17 <br>Precipitation: 0 in","Date: 2022-02-18 <br>Precipitation: 0 in","Date: 2022-02-19 <br>Precipitation: 0.13 in","Date: 2022-02-20 <br>Precipitation: 0 in","Date: 2022-02-21 <br>Precipitation: 0 in","Date: 2022-02-22 <br>Precipitation: 0 in","Date: 2022-02-23 <br>Precipitation: 0 in","Date: 2022-02-24 <br>Precipitation: 0 in","Date: 2022-02-25 <br>Precipitation: 0 in","Date: 2022-02-26 <br>Precipitation: 0 in","Date: 2022-02-27 <br>Precipitation: 0 in","Date: 2022-02-28 <br>Precipitation: 0 in",null,null,null],["Date: 2022-01-01 <br>Precipitation: 0 in","Date: 2022-01-02 <br>Precipitation: 0 in","Date: 2022-01-03 <br>Precipitation: 0.02 in","Date: 2022-01-04 <br>Precipitation: 0 in","Date: 2022-01-05 <br>Precipitation: 0 in","Date: 2022-01-06 <br>Precipitation: 1e-05 in","Date: 2022-01-07 <br>Precipitation: 1e-05 in","Date: 2022-01-08 <br>Precipitation: 0 in","Date: 2022-01-09 <br>Precipitation: 0 in","Date: 2022-01-10 <br>Precipitation: 0 in","Date: 2022-01-11 <br>Precipitation: 0 in","Date: 2022-01-12 <br>Precipitation: 0 in","Date: 2022-01-13 <br>Precipitation: 0 in","Date: 2022-01-14 <br>Precipitation: 0 in","Date: 2022-01-15 <br>Precipitation: 0 in","Date: 2022-01-16 <br>Precipitation: 0.68 in","Date: 2022-01-17 <br>Precipitation: 0 in","Date: 2022-01-18 <br>Precipitation: 0 in","Date: 2022-01-19 <br>Precipitation: 0 in","Date: 2022-01-20 <br>Precipitation: 0 in","Date: 2022-01-21 <br>Precipitation: 0 in","Date: 2022-01-22 <br>Precipitation: 0.01 in","Date: 2022-01-23 <br>Precipitation: 1e-05 in","Date: 2022-01-24 <br>Precipitation: 0 in","Date: 2022-01-25 <br>Precipitation: 0.67 in","Date: 2022-01-26 <br>Precipitation: 0.08 in","Date: 2022-01-27 <br>Precipitation: 0 in","Date: 2022-01-28 <br>Precipitation: 1e-05 in","Date: 2022-01-29 <br>Precipitation: 0 in","Date: 2022-01-30 <br>Precipitation: 0 in","Date: 2022-01-31 <br>Precipitation: 0 in"]],"colorscale":[[0,"#0D0887"],[3.496503496503497e-06,"#0D0887"],[0.0034965034965034969,"#110888"],[0.0069930069930069939,"#140888"],[0.01048951048951049,"#170889"],[0.013986013986013988,"#1A0889"],[0.017482517482517484,"#1C088A"],[0.02097902097902098,"#1F078A"],[0.024475524475524479,"#21078B"],[0.027972027972027975,"#23078C"],[0.031468531468531472,"#25078C"],[0.034965034965034968,"#27078D"],[0.038461538461538464,"#29078D"],[0.045454545454545456,"#2D078E"],[0.048951048951048959,"#2E078F"],[0.052447552447552448,"#300690"],[0.055944055944055951,"#320690"],[0.059440559440559447,"#330691"],[0.066433566433566432,"#370692"],[0.083916083916083919,"#3E0595"],[0.094405594405594415,"#430596"],[0.10139860139860139,"#450598"],[0.1048951048951049,"#470598"],[0.1083916083916084,"#480499"],[0.12237762237762237,"#4E049B"],[0.13636363636363638,"#53039D"],[0.13986013986013987,"#54039E"],[0.14335664335664336,"#56039F"],[0.15734265734265734,"#5B02A1"],[0.16433566433566432,"#5D02A2"],[0.20979020979020979,"#6E02A7"],[0.21328671328671328,"#7002A6"],[0.2167832167832168,"#7103A6"],[0.22027972027972029,"#7304A6"],[0.2237762237762238,"#7405A5"],[0.2342657342657343,"#7807A4"],[0.23776223776223779,"#7A08A4"],[0.24825174825174826,"#7E0AA2"],[0.26573426573426573,"#850FA0"],[0.27272727272727276,"#87109F"],[0.30419580419580422,"#92179C"],[0.31468531468531469,"#96199A"],[0.34265734265734266,"#9F1F97"],[0.36363636363636365,"#A62394"],[0.37412587412587417,"#A92593"],[0.38111888111888115,"#AB2692"],[0.38811188811188818,"#AD2891"],[0.39160839160839167,"#AE2891"],[0.42657342657342656,"#B8338A"],[0.4335664335664336,"#BA3589"],[0.44755244755244761,"#BE3986"],[0.4685314685314686,"#C34081"],[0.47902097902097907,"#C5437F"],[0.49300699300699302,"#C9477C"],[0.49650349650349651,"#CA487B"],[0.54545454545454553,"#D5556F"],[0.55944055944055948,"#D8596C"],[0.57342657342657344,"#DB5D69"],[0.57692307692307687,"#DC5E68"],[0.59090909090909094,"#DF6264"],[0.72727272727272729,"#F38F4A"],[0.86013986013986021,"#FAC032"],[0.86363636363636376,"#FAC132"],[0.95804195804195813,"#F4E828"],[0.98251748251748261,"#F2F224"],[1,"#F0F921"]],"type":"heatmap","showscale":false,"autocolorscale":false,"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[0],"y":[1],"name":"ad8d6a03f3558f72d45d1b0e05a45433","type":"scatter","mode":"markers","opacity":0,"hoverinfo":"skip","showlegend":false,"marker":{"color":[0,1],"colorscale":[[0,"#0D0887"],[0.0033444816053511705,"#110888"],[0.006688963210702341,"#140888"],[0.010033444816053512,"#170889"],[0.013377926421404682,"#190889"],[0.016722408026755856,"#1C088A"],[0.020066889632107024,"#1E078A"],[0.023411371237458192,"#20078B"],[0.026755852842809364,"#22078B"],[0.030100334448160536,"#24078C"],[0.033444816053511711,"#26078C"],[0.036789297658862873,"#28078D"],[0.040133779264214048,"#2A078E"],[0.043478260869565216,"#2C078E"],[0.046822742474916385,"#2D078F"],[0.05016722408026756,"#2F078F"],[0.053511705685618728,"#310690"],[0.056856187290969896,"#320690"],[0.060200668896321072,"#340691"],[0.06354515050167224,"#350691"],[0.066889632107023422,"#370692"],[0.070234113712374577,"#380692"],[0.073578595317725745,"#3A0693"],[0.076923076923076927,"#3B0694"],[0.080267558528428096,"#3D0694"],[0.083612040133779264,"#3E0595"],[0.086956521739130432,"#3F0595"],[0.090301003344481601,"#410596"],[0.093645484949832769,"#420596"],[0.096989966555183937,"#440597"],[0.10033444816053512,"#450597"],[0.10367892976588629,"#460598"],[0.10702341137123746,"#480499"],[0.11036789297658862,"#490499"],[0.11371237458193979,"#4A049A"],[0.11705685618729098,"#4C049A"],[0.12040133779264214,"#4D049B"],[0.12374581939799331,"#4E049B"],[0.12709030100334448,"#4F049C"],[0.13043478260869565,"#51039C"],[0.13377926421404684,"#52039D"],[0.13712374581939801,"#53039E"],[0.14046822742474915,"#54039E"],[0.14381270903010032,"#56039F"],[0.14715719063545149,"#57039F"],[0.15050167224080266,"#5803A0"],[0.15384615384615385,"#5902A0"],[0.15719063545150502,"#5B02A1"],[0.16053511705685619,"#5C02A1"],[0.16387959866220736,"#5D02A2"],[0.16722408026755853,"#5E02A3"],[0.1705685618729097,"#6002A3"],[0.17391304347826086,"#6101A4"],[0.17725752508361203,"#6201A4"],[0.1806020066889632,"#6301A5"],[0.18394648829431437,"#6401A5"],[0.18729096989966554,"#6601A6"],[0.19063545150501671,"#6701A6"],[0.19397993311036787,"#6800A7"],[0.19732441471571907,"#6900A8"],[0.20066889632107024,"#6A00A8"],[0.20401337792642141,"#6C01A8"],[0.20735785953177258,"#6D01A7"],[0.21070234113712374,"#6F02A7"],[0.21404682274247491,"#7003A6"],[0.21739130434782608,"#7203A6"],[0.22073578595317725,"#7304A6"],[0.22408026755852842,"#7405A5"],[0.22742474916387959,"#7605A5"],[0.23076923076923075,"#7706A4"],[0.23411371237458195,"#7807A4"],[0.23745819397993312,"#7A08A4"],[0.24080267558528429,"#7B08A3"],[0.24414715719063546,"#7C09A3"],[0.24749163879598662,"#7E0AA2"],[0.25083612040133779,"#7F0BA2"],[0.25418060200668896,"#800CA2"],[0.25752508361204013,"#810DA1"],[0.2608695652173913,"#830DA1"],[0.26421404682274247,"#840EA0"],[0.26755852842809369,"#850FA0"],[0.27090301003344486,"#8610A0"],[0.27424749163879603,"#88119F"],[0.27759197324414714,"#89119F"],[0.28093645484949831,"#8A129E"],[0.28428093645484948,"#8B139E"],[0.28762541806020064,"#8C149E"],[0.29096989966555181,"#8E149D"],[0.29431438127090298,"#8F159D"],[0.29765886287625415,"#90169C"],[0.30100334448160532,"#91169C"],[0.30434782608695654,"#92179C"],[0.30769230769230771,"#93189B"],[0.31103678929765888,"#95199B"],[0.31438127090301005,"#96199A"],[0.31772575250836121,"#971A9A"],[0.32107023411371238,"#981B9A"],[0.32441471571906355,"#991B99"],[0.32775919732441472,"#9A1C99"],[0.33110367892976589,"#9B1D98"],[0.33444816053511706,"#9C1D98"],[0.33779264214046822,"#9D1E98"],[0.34113712374581939,"#9F1F97"],[0.34448160535117056,"#A01F97"],[0.34782608695652173,"#A12096"],[0.3511705685618729,"#A22196"],[0.35451505016722407,"#A32196"],[0.35785953177257523,"#A42295"],[0.3612040133779264,"#A52395"],[0.36454849498327757,"#A62394"],[0.36789297658862874,"#A72494"],[0.37123745819397991,"#A82494"],[0.37458193979933108,"#A92593"],[0.37792642140468224,"#AA2693"],[0.38127090301003341,"#AB2692"],[0.38461538461538458,"#AC2792"],[0.38795986622073575,"#AD2891"],[0.39130434782608692,"#AE2891"],[0.39464882943143814,"#AF2991"],[0.39799331103678931,"#B02A90"],[0.40133779264214048,"#B12A90"],[0.40468227424749165,"#B22C8F"],[0.40802675585284282,"#B32D8E"],[0.41137123745819398,"#B42E8E"],[0.41471571906354515,"#B52F8D"],[0.41806020066889632,"#B6308C"],[0.42140468227424749,"#B7318B"],[0.42474916387959866,"#B8328B"],[0.42809364548494983,"#B9338A"],[0.43143812709030099,"#B93489"],[0.43478260869565216,"#BA3588"],[0.43812709030100333,"#BB3688"],[0.4414715719063545,"#BC3887"],[0.44481605351170567,"#BD3986"],[0.44816053511705684,"#BE3A86"],[0.451505016722408,"#BF3B85"],[0.45484949832775917,"#BF3C84"],[0.45819397993311034,"#C03D83"],[0.46153846153846151,"#C13E83"],[0.46488294314381273,"#C23F82"],[0.4682274247491639,"#C34081"],[0.47157190635451507,"#C44180"],[0.47491638795986624,"#C44280"],[0.47826086956521741,"#C5437F"],[0.48160535117056857,"#C6437E"],[0.48494983277591974,"#C7447D"],[0.48829431438127091,"#C8457D"],[0.49163879598662208,"#C9467C"],[0.49498327759197325,"#C9477B"],[0.49832775919732442,"#CA487A"],[0.50167224080267558,"#CB497A"],[0.50501672240802675,"#CC4A79"],[0.50836120401337792,"#CD4B78"],[0.51170568561872909,"#CD4C77"],[0.51505016722408026,"#CE4D77"],[0.51839464882943143,"#CF4E76"],[0.52173913043478259,"#D04F75"],[0.52508361204013376,"#D05074"],[0.52842809364548493,"#D15173"],[0.5317725752508361,"#D25273"],[0.53511705685618738,"#D35372"],[0.53846153846153855,"#D35371"],[0.54180602006688972,"#D45470"],[0.54515050167224088,"#D5556F"],[0.54849498327759205,"#D6566F"],[0.55183946488294322,"#D6576E"],[0.55518394648829428,"#D7586D"],[0.55852842809364545,"#D8596C"],[0.56187290969899661,"#D95A6B"],[0.56521739130434778,"#D95B6B"],[0.56856187290969895,"#DA5C6A"],[0.57190635451505012,"#DB5C69"],[0.57525083612040129,"#DC5D68"],[0.57859531772575246,"#DC5E67"],[0.58193979933110362,"#DD5F67"],[0.58528428093645479,"#DE6066"],[0.58862876254180596,"#DF6165"],[0.59197324414715713,"#DF6264"],[0.5953177257525083,"#E06363"],[0.59866220735785947,"#E16462"],[0.60200668896321063,"#E16562"],[0.6053511705685618,"#E26661"],[0.60869565217391308,"#E26761"],[0.61204013377926425,"#E36860"],[0.61538461538461542,"#E3695F"],[0.61872909698996659,"#E46B5F"],[0.62207357859531776,"#E46C5E"],[0.62541806020066892,"#E56D5E"],[0.62876254180602009,"#E56E5D"],[0.63210702341137126,"#E66F5D"],[0.63545150501672243,"#E6705C"],[0.6387959866220736,"#E7715C"],[0.64214046822742477,"#E7735B"],[0.64548494983277593,"#E8745A"],[0.6488294314381271,"#E8755A"],[0.65217391304347827,"#E97659"],[0.65551839464882944,"#E97759"],[0.65886287625418061,"#EA7858"],[0.66220735785953178,"#EA7957"],[0.66555183946488294,"#EB7A57"],[0.66889632107023411,"#EB7C56"],[0.67224080267558528,"#EB7D55"],[0.67558528428093645,"#EC7E55"],[0.67892976588628762,"#EC7F54"],[0.68227424749163879,"#ED8053"],[0.68561872909698995,"#ED8153"],[0.68896321070234112,"#EE8252"],[0.69230769230769229,"#EE8351"],[0.69565217391304346,"#EF8451"],[0.69899665551839463,"#EF8650"],[0.7023411371237458,"#F0874F"],[0.70568561872909696,"#F0884F"],[0.70903010033444813,"#F0894E"],[0.7123745819397993,"#F18A4D"],[0.71571906354515047,"#F18B4D"],[0.71906354515050164,"#F28C4C"],[0.72240802675585281,"#F28D4B"],[0.72575250836120397,"#F38E4A"],[0.72909698996655514,"#F38F4A"],[0.73244147157190631,"#F49049"],[0.73578595317725748,"#F49148"],[0.73913043478260865,"#F49347"],[0.74247491638795982,"#F59446"],[0.74581939799331098,"#F59546"],[0.74916387959866215,"#F69645"],[0.75250836120401332,"#F69744"],[0.75585284280936449,"#F79843"],[0.75919732441471566,"#F79942"],[0.76254180602006683,"#F79A41"],[0.76588628762541799,"#F89B40"],[0.76923076923076916,"#F89C3F"],[0.77257525083612033,"#F99D3E"],[0.7759197324414715,"#F99E3D"],[0.77926421404682267,"#F99F3D"],[0.78260869565217384,"#FAA03C"],[0.78595317725752512,"#FAA23B"],[0.78929765886287628,"#FBA339"],[0.79264214046822745,"#FBA438"],[0.79598662207357862,"#FCA537"],[0.79933110367892979,"#FCA636"],[0.80267558528428096,"#FCA736"],[0.80602006688963213,"#FCA936"],[0.80936454849498329,"#FCAA35"],[0.81270903010033446,"#FCAC35"],[0.81605351170568563,"#FCAD35"],[0.8193979933110368,"#FCAE35"],[0.82274247491638797,"#FBB035"],[0.82608695652173914,"#FBB135"],[0.8294314381270903,"#FBB334"],[0.83277591973244147,"#FBB434"],[0.83612040133779264,"#FBB634"],[0.83946488294314381,"#FBB734"],[0.84280936454849498,"#FBB833"],[0.84615384615384615,"#FBBA33"],[0.84949832775919731,"#FBBB33"],[0.85284280936454848,"#FBBD33"],[0.85618729096989965,"#FABE32"],[0.85953177257525082,"#FABF32"],[0.86287625418060199,"#FAC132"],[0.86622073578595316,"#FAC232"],[0.86956521739130432,"#FAC431"],[0.87290969899665549,"#FAC531"],[0.87625418060200666,"#FAC631"],[0.87959866220735783,"#F9C831"],[0.882943143812709,"#F9C930"],[0.88628762541806017,"#F9CB30"],[0.88963210702341133,"#F9CC30"],[0.8929765886287625,"#F9CD2F"],[0.89632107023411367,"#F8CF2F"],[0.89966555183946484,"#F8D02F"],[0.90301003344481601,"#F8D22E"],[0.90635451505016718,"#F8D32E"],[0.90969899665551834,"#F8D42E"],[0.91304347826086951,"#F7D62D"],[0.91638795986622068,"#F7D72D"],[0.91973244147157185,"#F7D82D"],[0.92307692307692302,"#F7DA2C"],[0.92642140468227419,"#F7DB2C"],[0.92976588628762546,"#F6DD2C"],[0.93311036789297663,"#F6DE2B"],[0.9364548494983278,"#F6DF2B"],[0.93979933110367897,"#F6E12A"],[0.94314381270903014,"#F5E22A"],[0.94648829431438131,"#F5E32A"],[0.94983277591973247,"#F5E529"],[0.95317725752508364,"#F4E629"],[0.95652173913043481,"#F4E728"],[0.95986622073578598,"#F4E928"],[0.96321070234113715,"#F4EA27"],[0.96655518394648832,"#F3EB27"],[0.96989966555183948,"#F3ED26"],[0.97324414715719065,"#F3EE26"],[0.97658862876254182,"#F2F025"],[0.97993311036789299,"#F2F125"],[0.98327759197324416,"#F2F224"],[0.98662207357859533,"#F1F423"],[0.98996655518394649,"#F1F523"],[0.99331103678929766,"#F1F622"],[0.99665551839464883,"#F0F822"],[1,"#F0F921"]],"colorbar":{"bgcolor":null,"bordercolor":null,"borderwidth":0,"thickness":23.039999999999996,"title":"Precip (in)","titlefont":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243},"tickmode":"array","ticktext":["0","1","2"],"tickvals":[0.0016666666666666668,0.35015151515151516,0.69863636363636372],"tickfont":{"color":"rgba(0,0,0,1)","family":"","size":12.7521793275218},"ticklen":2,"len":0.5}},"xaxis":"x","yaxis":"y","frame":null}],"layout":{"margin":{"t":43.098381070983812,"r":7.9701120797011216,"b":40.647571606475722,"l":85.280199252802035},"paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243},"title":{"text":"Precipitation Calendar TPA 2022","font":{"color":"rgba(0,0,0,1)","family":"","size":19.128268991282692},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-1.05,33.049999999999997],"tickmode":"array","ticktext":["0","10","20","30"],"tickvals":[0,10,20,30],"categoryorder":"array","categoryarray":["0","10","20","30"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.9850560398505608,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":12.7521793275218},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.72455564360919278,"zeroline":false,"anchor":"y","title":{"text":"Day of Month","font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.40000000000000002,12.6],"tickmode":"array","ticktext":["December","November","October","September","August","July","June","May","April","March","February","January"],"tickvals":[1,2,3,4.0000000000000009,5,6,7.0000000000000009,8,9,10,11,12],"categoryorder":"array","categoryarray":["December","November","October","September","August","July","June","May","April","March","February","January"],"nticks":null,"ticks":"","tickcolor":null,"ticklen":3.9850560398505608,"tickwidth":0,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":12.7521793275218},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.72455564360919278,"zeroline":false,"anchor":"x","title":{"text":"Month","font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243}},"hoverformat":".2f"},"shapes":[],"showlegend":false,"legend":{"bgcolor":null,"bordercolor":null,"borderwidth":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":12.7521793275218},"title":{"text":"Precip (in)","font":{"color":"rgba(0,0,0,1)","family":"","size":15.940224159402243}}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"source":"A","attrs":{"111f8329d41a6":{"x":{},"y":{},"fill":{},"text":{},"type":"heatmap"}},"cur_data":"111f8329d41a6","visdat":{"111f8329d41a6":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

---

## PART 2 

### Option (A): Visualizing Text Data

Review the set of slides (and additional resources linked in it) for visualizing text data: Week 6 PowerPoint slides of Visualizing Text Data. 

Choose any dataset with text data, and create at least one visualization with it. For example, you can create a frequency count of most used bigrams, a sentiment analysis of the text data, a network visualization of terms commonly used together, and/or a visualization of a topic modeling approach to the problem of identifying words/documents associated to different topics in the text data you decide to use. 

- [FL Poly News Articles](https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/data/flpoly_news_SP23.csv)


(to get the "raw" data from any of the links listed above, simply click on the `raw` button of the GitHub page and copy the URL to be able to read it in your computer using the `read_csv()` function)


``` r
flpoly <- read_csv("https://raw.githubusercontent.com/aalhamadani/dataviz_final_project/main/data/flpoly_news_SP23.csv")
```

```
## Rows: 480 Columns: 3
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): news_title, news_summary
## date (1): news_date
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Most Common Bigram in FL Poly News


``` r
library(tidyverse)
library(tidytext)
```

```
## Warning: package 'tidytext' was built under R version 4.5.3
```

``` r
library(viridis)

# Create bigrams
bigrams <- flpoly %>%
  unnest_tokens(bigram, news_summary, token = "ngrams", n = 2) %>%
  separate(bigram, into = c("word1", "word2"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word) %>%
  unite(bigram, word1, word2, sep = " ") %>%
  count(bigram, sort = TRUE) %>%
  slice_max(n, n = 12) %>%
  mutate(bigram = fct_reorder(bigram, n))

# Plot
ggplot(bigrams, aes(x = n, y = bigram, fill = n)) +
  geom_col() +
  scale_fill_viridis_c(option = "plasma") +
  labs(
    title = "Most Common Bigrams in FL Poly News (Spring 2023)",
    x = "Frequency",
    y = NULL
  ) +
  theme_minimal(base_size = 12)
```

<img src="Majdoch_project_03_files/figure-html/unnamed-chunk-13-1.png" alt="A horizontal bar chart showing the 12 most common bigrams in Florida Polytechnic University news summaries from Spring 2023."  />


This graph shows the most frequent two‑word phrases appearing in FL Poly’s Spring 2023 news summaries. The dominant pairs include“Florida Polytechnic” and “Polytechnic University. This highlights how often the institution’s name appears, while smaller bars like “robotics team”, “mechanical engineering”, and “computer science” reveal recurring themes.
