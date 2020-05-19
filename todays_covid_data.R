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

# invert the dataframe order of UK_df
UK_rev <- UK_df[order(nrow(UK_df):1),]

#US data
US_df <- subset(df, country == 'United_States_of_America')

# invert the dataframe order of UK_df
US_rev <- US_df[order(nrow(UK_df):1),]


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


# 18/05/2020 - Monday ------------------------------------------------
# barplot
barplot(UK_df$deaths)

#line plot?
plot(UK_df$deaths, xlab = 'Date',ylab = 'Deaths',type = 'o',col = 'blue',
     main = 'UK deaths over time', lty = 1, pch = 18)


# line plot with the new sorted df
plot(UK_rev$deaths, xlab = 'Date',ylab = 'Deaths',type = 'o',col = 'blue',
     main = 'UK deaths over time', lty = 1, pch = 18)

# bar plot with updated df
barplot(UK_rev$deaths)

# using mfrow parameter for multiple plots for easy visualisation
par(mfrow = c(2, 2))
barplot(UK_rev$deaths)
barplot(UK_rev$cases)
barplot(US_rev$deaths)
barplot(US_rev$cases)

# 19/05/2020 - Tuesday ------------------------------------------------
# using ggplot2 from youtube tutorial (1hour)

ggplot(UK_rev, aes(dateRep, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')
 
# just get data for may (up to 16th)
may_df <- subset(UK_rev, month == 5)

# bar plot of just may 1st - 16th
ggplot(may_df, aes(dateRep, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# line graph
# doesn't work............
ggplot(may_df, aes(dateRep, deaths)) +
  geom_line()





