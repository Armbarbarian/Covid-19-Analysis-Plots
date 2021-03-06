# reading todays data into a table

# open the relevant library 
library('readxl')
library('dplyr')

# read into R with read_excel (same as python)
data <- read_excel('RAW_5july.xlsx')

# turn into a df with data.frame
df <- data.frame(data)
colnames(df)[7] <- 'countries'
colnames(df)[1] <- 'date'

# drop what we don't care about
df <- subset(df, select = -c(continentExp))
df <- subset(df, select = -c(geoId))
df <- subset(df, select = -c(popData2019))
df <- subset(df, select = -c(countryterritoryCode))

head(df)

# df changed forever now

# add a CFR colunm
# $ like a select column character
df['CFR'] <- df$deaths / df$cases * 100

#add column called cumsum



# -------------------------------------UK data --------------------------------------------------
# subset rows then columns
# new df with only UK data
UK_df <- subset(df, countries == 'United_Kingdom')
head(UK_df, 12)

# drop until March
# using subset() and !=
UK_df <- subset(UK_df, month!=12 & month!=1 & month!=2)
tail(UK_df)
# invert the dataframe order of UK_df
UK_rev <- UK_df[order(nrow(UK_df):1),]

head(UK_rev)

# cummulative sum in a new colum to see the linear totals
# from: https://rveryday.wordpress.com/2016/11/17/create-a-cumulative-sum-column-in-r/
UK_rev[,'cum_deaths'] <- cumsum(UK_rev$deaths)
UK_rev[,'cum_cases'] <- cumsum(UK_rev$cases)
tail(UK_rev)





# -------------------------------------US Data ----------------------------------------------------

# invert the dataframe order of US_df
US_rev <- US_df[order(nrow(US_df):1),]



# -----------------------------------Sweden data -------------------------------------------------
# subset rows then columns
# new df with only UK data
swe_df <- subset(df, country == 'Sweden')
head(swe_df)

# invert the dataframe order of UK_df
swe_rev <- swe_df[order(nrow(UK_df):1),]
head(swe_rev)


# ----------------------------------Brazil data ---------------------------------------------------
# subset rows then columns
# new df with only UK data
brz_df <- subset(df, country == 'Brazil')
head(brz_df)

# invert the dataframe order of UK_df
brz_rev <- brz_df[order(nrow(UK_df):1),]





library(ggplot2)



# ---------------------------------------- GGPLOT  UK --------------------------------------------------

# ---------------------------------------- Deaths -------------------------------------------------
# using ggplot2 from youtube tutorial (1hour)

ggplot(UK_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')
 
# just get data for may (up to 19th)
#jan_df <- subset(UK_rev, month == 1)
#feb_df <- subset(UK_rev, month == 2)
mar_df <- subset(UK_rev, month == 3)
apr_df <- subset(UK_rev, month == 4)
may_df <- subset(UK_rev, month == 5)
jun_df <- subset(UK_rev, month == 6)
jul_df <- subset(UK_rev, month == 7)

# bar plot of mar
ggplot(mar_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=deaths), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current March Deaths in The UK due to COVID-19')

# bar plot of apr
ggplot(apr_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') + 
  geom_text(aes(label=deaths), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current April Deaths in The UK due to COVID-19')

# bar plot of may
ggplot(may_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=deaths), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current May Deaths in The UK due to COVID-19')
  
# bar plot of June
ggplot(jun_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=deaths), position = position_dodge(width = 0.9), vjust=-0.25, size=3) +
  ggtitle('Current June Deaths in The UK due to COVID-19')

# bar plot of July
ggplot(jul_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=deaths), position = position_dodge(width = 0.9), vjust=-0.25, size=3) +
  ggtitle('Current June Deaths in The UK due to COVID-19')






# bar plot of jun
# labels from: https://stackoverflow.com/questions/12018499/how-to-put-labels-over-geom-bar-for-each-bar-in-r-with-ggplot2



# line graph
# with smoothed line (trend)
ggplot(UK_rev, aes(date, deaths)) +
  geom_line(stat = 'identity', col = 'red', size = 0.6) +
  stat_smooth()


# -------------------------------------------------------- CASES --------------------------------------------------

ggplot(UK_rev, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076', col = 'black')

# just get data for may (up to 19th)
#jan_df <- subset(UK_rev, month == 1)
#feb_df <- subset(UK_rev, month == 2)
mar_df <- subset(UK_rev, month == 3)
apr_df <- subset(UK_rev, month == 4)
may_df <- subset(UK_rev, month == 5)
jun_df <- subset(UK_rev, month == 6)
jul_df <- subset(UK_rev, month == 7)

# bar plot of mar
ggplot(mar_df, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=cases), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current March Cases in The UK due to COVID-19')

# bar plot of apr
ggplot(apr_df, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076') + 
  geom_text(aes(label=cases), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current April Cases in The UK due to COVID-19')

# bar plot of may
ggplot(may_df, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=cases), position = position_dodge(width = 0.9), vjust=-0.25, size=3)+
  ggtitle('Current May cases in The UK due to COVID-19')

# bar plot of June
ggplot(jun_df, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=cases), position = position_dodge(width = 0.9), vjust=-0.25, size=3) +
  ggtitle('Current June cases in The UK due to COVID-19')

# bar plot of July
ggplot(jul_df, aes(date, cases)) +
  geom_bar(stat = 'identity', fill = '#ff0076') +
  geom_text(aes(label=cases), position = position_dodge(width = 0.9), vjust=-0.25, size=3) +
  ggtitle('Current June cases in The UK due to COVID-19')


# TOTAL DEATHS
# bar plot
ggplot(UK_rev, aes(date, cum_deaths)) +
  geom_bar(stat = 'identity', fill = 'darkred') +
  ggtitle('Total Deaths in The UK due to COVID-19')

# TOTAL CASES
# bar plot
ggplot(UK_rev, aes(date, cum_cases)) +
  geom_bar(stat = 'identity', fill = 'darkblue') +
  ggtitle('Total Cases in The UK due to COVID-19')

# Overlap
ggplot(UK_rev) +
  geom_bar(aes(x = date, y = cum_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = cum_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of Total Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 30, face = "bold"))







# ------------------------------------------US plots ----------------------------------------------------
ggplot(US_rev, aes(date, deaths)) +
  geom_line(stat = 'identity')

# US June data
US_june_df <- subset(US_rev, month == 6)


# bar plot of just June
ggplot(US_june_df, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = 'darkred') +
  ggtitle('Current June Deaths in The USA due to COVID-19') +
  geom_text(aes(label=deaths), position=position_dodge(width=0.9), vjust=-0.25, size=3)

# Overall bar chart with smoothed line
ggplot(US_rev, aes(date, deaths)) +
  geom_bar(stat = 'identity', fill = '#ff0076') + 
  stat_smooth()



# ----------------------------------------Top 10 countries ------------------------------------------

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

june25_df <- filter(df, month==6, day==25)


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
  ggtitle('Number of deaths on June 25th - Top 10 Countries')

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
