# FredApi (R package)

!["logo"](logo.png)

`FredApi` offers the possibility to access the [FRED Developer API](https://research.stlouisfed.org/docs/api/) in R.
This package was ported from [FredApi.jl](https://github.com/markushhh/FredApi.jl) in Julia.

## Installation

```@R
pak::pak("markushhh/FredApi")
devtools::install_github("markushhh/FredApi")
#install.packages("FredApi") # not (yet?) supported
```

## Tutorial

Download a full dataset with

```@R
x <- get_symbols("GDPC1")
head(x, 10)
```

output

```@R
               [,1]
1947-01-01 2033.061
1947-04-01 2027.639
1947-07-01 2023.452
1947-10-01 2055.103
1948-01-01 2086.017
1948-04-01 2120.450
1948-07-01 2132.598
1948-10-01 2134.981
1949-01-01 2105.562
1949-04-01 2098.380
```

To change the time frame of the dataset, the `xts`  package comes in really handy.

```@julia
library("xts")
```

subset with end date

```
x["::1948-01-01"]
```

output

```
               [,1]
2018-01-01 18438.25
2018-04-01 18598.13
2018-07-01 18732.72
2018-10-01 18783.55
2019-01-01 18927.28
2019-04-01 19021.86
2019-07-01 19121.11
```

subset only with start year

```
x["2018::"]
```

output

```
               [,1]
1947-01-01 2033.061
1947-04-01 2027.639
1947-07-01 2023.452
1947-10-01 2055.103
1948-01-01 2086.017
```

subset with start and end date

```
x["2012-01-01::2013-01-01"]
```

output

```
               [,1]
2012-01-01 16129.42
2012-04-01 16198.81
2012-07-01 16220.67
2012-10-01 16239.14
2013-01-01 16382.96
```

To explore more options, go to [link1](https://jangorecki.gitlab.io/data.table/library/xts/html/subset.xts.html) or [link2](https://jangorecki.gitlab.io/data.table/library/xts/html/xts.html).

## Plotting example

```@julia
library("ggplot2")
x <- get_symbols("FEDFUNDS")

x <- data.frame(x = x, time = time(x))

ggplot(x) +
  geom_line(aes(time, x), col = "blue", size = 1) +
  theme_minimal() + 
  xlab("") +
  ylab("")
```

!["plot"](plot.png)

# Each comment, suggestion or pull request is welcome!