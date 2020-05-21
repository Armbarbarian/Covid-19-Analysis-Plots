# reading todays data into a table

# open the relevant library 
library('readxl')

# read into R with read_excel (same as python)
data <- read_excel('RAW_21may.xlsx')

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

# Getting UK data -------------------------------------------------------------------------------------
# subset rows then columns
# new df with only UK data
UK_df <- subset(df, country == 'United_Kingdom')
head(UK_df)

# invert the dataframe order of UK_df
UK_rev <- UK_df[order(nrow(UK_df):1),]


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


# 18/05/2020 - Monday ----------------------------------------------------------------------------------

# line plot with the new sorted df
plot(UK_rev$deaths, xlab = 'Date',ylab = 'Deaths',type = 'o',col = 'blue',
     main = 'UK deaths over time', lty = 1, pch = 18)

# bar plot with updated df
barplot(UK_rev$deaths)

# using mfrow parameter for multiple plots for easy visualisation
# no that useful
'par(mfrow = c(2, 2))
barplot(UK_rev$deaths)
barplot(UK_rev$cases)
barplot(US_rev$deaths)
barplot(US_rev$cases)
'
# ---------------------------------------- GGPLOT --------------------------------------------------
# 19/05/2020 - Tuesday -----------------------------------------------------------------------------
# using ggplot2 from youtube tutorial (1hour)

ggplot(UK_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')
 
# just get data for may (up to 19th)
may_df <- subset(UK_rev, month == 5)

# bar plot of just may 1st - 16th
ggplot(may_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  stat_smooth()

# line graph
# with smoothed line (trend)
ggplot(UK_rev, aes(date, deaths)) +
  geom_line(stat = 'identity', col = 'red', size = 0.5) +
  stat_smooth(aes())

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
