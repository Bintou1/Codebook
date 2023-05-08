# Codebook

This is a codebook I creared as part of project for Data Analysis course in Spring 2023. The assignment asked us to collect data and perform some data wrangling and analysis.

My project looks at the relationship between risk taking and steak preference. This steak data was created in hopes of assessing the various factors affecting individual steak preferences. 

The dataset was extracted from `SurveyMonkey` Audience polls and published by `FiveThirtyEight`.

I performed the following wrangling tasks:
 - `Cleaning`: I renames some of the data variables for easier use and I corrected the formatting of certain values and **relocated** certain values. I also `recoded` missing values to -9, and dropped columns that were not needed for my analysis. I changed 2 varibales to be `factor values` as part of my analysis. 
- `Appending` : I `mutated` multiples new variables as part of the main data set and also sub data frames. The mutaed variables served as factor variables and frequency tables in the data frames. 

Files for the project: 
- `SteakCook.csv` and `SteakCook.Rdata` replication data
- `Codebook.R` with the r scrcode
- `Codebook .pdf` with the codebook
