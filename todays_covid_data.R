# reading todays data into a table

# open the relevant library 
library('readxl')

# read into R with read_excel (same as python)
data <- read_excel('RAW_15june.xlsx')

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
colnames(df)[1] <- 'date'


# UK data -------------------------------------------------------------------------------------
# subset rows then columns
# new df with only UK data
UK_df <- subset(df, country == 'United_Kingdom')
head(UK_df)

# invert the dataframe order of UK_df
UK_rev <- UK_df[order(nrow(UK_df):1),]


# US Data -----------------------------------------------------------------------------------
US_df <- subset(df, country == 'United_States_of_America')

# invert the dataframe order of US_df
US_rev <- US_df[order(nrow(US_df):1),]

# Sweden data -------------------------------------------------------------------------------------
# subset rows then columns
# new df with only UK data
swe_df <- subset(df, country == 'Sweden')
head(swe_df)

# invert the dataframe order of UK_df
swe_rev <- swe_df[order(nrow(UK_df):1),]
head(swe_rev)










# plotting ---------------------------------------------------------------------------------------------
library(ggplot2)
















# quick plot
# give a sort of scatter
qplot(date, deaths, data = UK_df)


# using ggplot bar graph
base_plot <- ggplot(data = UK_df, aes(x=date, y=deaths))
base_plot + geom_bar(stat = 'identity')

# STILL NOT GETTING THE DESIRED OUTPUT
# AES, GEOM_BAR ETC ARE CONFUSING ME....

# TRY AGAIN LATER


# 18/05/2020 - Monday 

# line plot with the new sorted df
plot(UK_rev$deaths, xlab = 'Date',ylab = 'Deaths',type = 'o',col = 'blue',
     main = 'UK deaths over time', lty = 1, pch = 18)

# bar plot with updated df
barplot(UK_rev$deaths)

# ---------------------------------------- GGPLOT  UK --------------------------------------------------
# 19/05/2020 - Tuesday 
# using ggplot2 from youtube tutorial (1hour)

ggplot(UK_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')
 
# just get data for may (up to 19th)
jan_df <- subset(UK_rev, month == 1)
feb_df <- subset(UK_rev, month == 2)
mar_df <- subset(UK_rev, month == 3)
apr_df <- subset(UK_rev, month == 4)
may_df <- subset(UK_rev, month == 5)
jun_df <- subset(UK_rev, month == 6)

# bar plot of mar
ggplot(mar_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of apr
ggplot(apr_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of may
ggplot(may_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of jun
ggplot(jun_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# line graph
# with smoothed line (trend)
ggplot(UK_rev, aes(date, deaths)) +
  geom_line(stat = 'identity', col = 'red', size = 0.5) +
  stat_smooth(aes())



# ------------------------------------------US plots ----------------------------------------------------
ggplot(US_rev, aes(date, deaths)) +
  geom_line(stat = 'identity')

# US May data
US_may_df <- subset(US_rev, month == 5)

# May plot
# bar plot of just may 1st - 16th
ggplot(US_may_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  stat_smooth()

# Overall bar chart with smoothed line
ggplot(US_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') + 
  stat_smooth()



# ---------------------- Top 10 countries ------------------

# from the csv generated from Python in VS code in the My_project folder (not for R)
# this is a sorted csv by deaths
june_1_data <- read.csv('C:\\Users\\Danie\\Desktop\\My_project\\1st_June_data_deaths.csv')
june_df_py <- data.frame(june_1_data)


# sorted generated from the original data from R folder
# need to get todays data first
# using dplyr is the easiest way for data manipulation here
# https://www.youtube.com/watch?v=jWjqLW-u3hc&t=335s
# using the filter function

library(dplyr)

june1_df <- filter(sort_df, month==6, day==1)


# put the top10 into an object and run ggplot on that
top10 <- june1_df %>% head(10)

is.factor(top10$country)
# False

# trying to change the df vectors/character/factor on country
# to not get the ggplot in alphabetical order
# below code stopped the alphabetical ggplot order
# https://stackoverflow.com/questions/12774210/how-do-you-specifically-order-ggplot2-x-axis-instead-of-alphabetical-order
top10$country <- as.character(top10$country)
top10$country <- factor(top10$country, levels = unique(top10$country))


# original in alphabetical order (wasn't by design)
# had an issue with the coord_flip giving an upside down image
# fixed with  scale_x_discrete(limits = rev(levels(top10$country)))
ggplot(top10, aes(x = country, y = deaths)) +
  geom_bar(stat='identity', fill='midnightblue') + 
  coord_flip() +
  scale_x_discrete(limits = rev(levels(top10$country))) + 
  ggtitle('Number of deaths on June 1st - Top 10 Countries')

# ggsave('top10_1st_june.png')



# ---------------------- UK cases --------------------------

ggplot(UK_rev, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')





# ---------------------- Sweden --------------------------

ggplot(swe_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')

# just get data for may (up to 19th)
jan_swe <- subset(swe_rev, month == 1)
feb_swe <- subset(swe_rev, month == 2)
mar_swe <- subset(swe_rev, month == 3)
apr_swe <- subset(swe_rev, month == 4)
may_swe <- subset(swe_rev, month == 5)
jun_swe <- subset(swe_rev, month == 6)

# bar plot of mar
ggplot(mar_swe, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of apr
ggplot(apr_swe, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of may
ggplot(may_swe, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# bar plot of jun
ggplot(jun_swe, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076')

# line graph
# with smoothed line (trend)
ggplot(swe_rev, aes(date, deaths)) +
  geom_line(stat = 'identity', col = 'red', size = 0.5) +
  stat_smooth(aes())

# ----------------------- Sweden Cases -------------------------

ggplot(swe_rev, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')











# Predictive analysis -------------------------------------------------------------------------------
# for time series
# need to convert the data to a time series (ts) class
# https://www.youtube.com/watch?v=0gf5iLTbiQM

ts_UK = ts(UK_rev$deaths, start = c(2020, 1), frequency = 1)
ts_UK

plot(ts_UK)

# Forecasting
library(forecast)

# Arima model
# get coefficeitns and signma intervals and confidence values...serious stuff?
model_arima <- auto.arima(ts_UK)
model_arima

# forecast
forecast(model_arima, 20)
confint(model_arima)
plot(forecast(model_arima, 20))

#Marima
model_marima <- arima(ts_UK, order = c(0,1,1))
model_marima
plot(forecast(model_marima,20))

# ETS method
model_ets <- ets(ts_UK)
model_ets
forecast(model_ets,20)
plot(forecast(model_ets,20))

# Holt-Winters method (seasonality)
model_hw <- HoltWinters(ts_UK)

# TSLM
model_tslm <- tslm(ts_UK ~ trend)
model_tslm
plot(forecast(model_tslm, h=20))

# Understand nothing above ------------------------------------------------------------------------------
