library(dplyr)
library(ggplot2)

# read in the csv from owid covd-19 data
df <- read.csv('owid-2june.csv')

# changing the names of columns
colnames(df)[2] <- c('countries')

# get only UK data
UK <- subset(df, countries == 'United Kingdom')
head(UK)

# time series as.Date()
day = as.Date("2019-12-31") - 0:156

# drop the iso_code column
UK <- subset(UK, select = -c(iso_code))

# bar plot of new deaths per day 
ggplot(UK, aes(date, new_deaths)) + 
  geom_bar(stat = 'identity', fill = 'darkred') +
  ggtitle('New Deaths Per Day UK June 2nd')


# line plot of new deaths per day
# group=1 is a new thing I learned here
ggplot(UK, aes(date, new_deaths)) +
  geom_line(group=1) +
  ggtitle('New Deaths Per Day UK June 2nd')

# new cases in UK
ggplot(UK, aes(date, new_cases)) +
  geom_bar(stat = 'identity', fill = 'midnightblue') +
  ggtitle('New Cases Per Day UK June 2nd')

# total deaths UK
ggplot(UK, aes(date, total_deaths)) +
  geom_bar(stat = 'identity', fill = 'darkred') +
  ggtitle('Total Deaths Per Day UK June 2nd')

# total cases UK
ggplot(UK, aes(date, total_cases)) +
  geom_bar(stat = 'identity', fill = 'lightblue') +
  ggtitle('Total Cases Per Day UK June 2nd')

# total cases UK + total deaths UK on SAME PLOT
# works and looks great!!!
# https://biostats.w.uib.no/overlaying-a-line-plot-and-a-column-plot/
ggplot(UK) +
  geom_bar(aes(x = date, y = total_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = total_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of Total Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 30, face = "bold"))

# overlap of new cases and new deaths UK
ggplot(UK) +
  geom_bar(aes(x = date, y = new_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = new_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of New Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 30, face = "bold")) +
  xlab('Date') + ylab('')
  






