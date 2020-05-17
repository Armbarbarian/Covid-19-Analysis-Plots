# reading todays data into a table

# open the relevant library 
library('readxl')

# read into R with read_excel (same as python)
data <- read_excel('RAW_16may.xlsx')

# turn into a df with data.frame
df <- data.frame(data)

# see if its working
head(df)

# drop the colunms I do not want in the df
# using subset()
# once you have run this it updates
df = subset(df, select = -c(countryterritoryCode))
head(df)

# df changed forever now

# add a CFR colunm
# $ like a select column character
df['CFR'] <- df$deaths / df$cases * 100

# change column name to country
colnames(df)[7] <- 'country'


# Getting UK data -----------------------------------------------
# subset rows then columns
# new df with only UK data
UK_df <- subset(df, country == 'United_Kingdom')
head(UK_df)
# plotting ------------------------------------------------------
library(ggplot2)

# quick plot
# give a sort of scatter
qplot(dateRep, deaths, data = UK_df)

# basic histogram
qplot(deaths, data = UK_df)

# using ggplot bar graph
base_plot <- ggplot(data = UK_df, aes(x=dateRep, y=deaths))
base_plot + geom_bar(stat = 'identity')

# STILL NOT GETTING THE DESIRED OUTPUT
# AES, GEOM_BAR ETC ARE CONFUSING ME....

# TRY AGAIN LATER
