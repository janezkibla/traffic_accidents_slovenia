Analyzing police traffic accident data
--------------------------------------

To fetch the initial data, use `download_police_data.R` script. Please adjust the year range in the first `for` loop to indicate which years you would like to fetch.

To convert the raw data from .zip files into an R readable data object, use `import_data.R` script.

Plotting of data is done in `plot_data.R` and `num_traffic_accidents.Rmd`. To run the former, use `knitr` to run the report.