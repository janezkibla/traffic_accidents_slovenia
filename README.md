Analyzing police traffic accident data
--------------------------------------

# Before you start
To create an R project, install package `renv` using `install.packages("renv")` and initialize the R environment using

```{r}
renv::init()
```

Should there be any prompts about installing/updating the packages, just follow the instructions. Once the packages are installed, you can start running the scripts.

# Running the scripts
To fetch the initial data, use `download_police_data.R` script. Please adjust the year range in the first `for` loop to indicate which years you would like to fetch.

To convert the raw data from .zip files into an R readable data object, use `import_data.R` script.

Plotting of data is done in `plot_data.R` and `num_traffic_accidents.Rmd`. To run the former, use `knitr` to run the report.