library(dplyr)
library(ggplot2)
library(readxl)

# read in the csv from owid covd-19 data
data <- read_excel('owid-9june.xlsx')

# turn into df
df <- data.frame(data)
head(df)
colnames(df)

# changing the names of columns
colnames(df)[3] <- c('countries')
colnames(df)

# get only UK data
UK <- subset(df, countries == 'United Kingdom')
head(UK)


# drop the iso_code & continent column
UK <- subset(UK, select = -c(iso_code))
UK <- subset(UK, select = -c(continent))
head(UK)

# bar plot of new deaths per day 
ggplot(UK, aes(date, new_deaths)) + 
  geom_bar(stat = 'identity', fill = 'darkred') +
  ggtitle('New Deaths Per Day UK June 9th')


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
# scale_x_.... SO USEFUL to show the bins you want
# https://rstudio-pubs-static.s3.amazonaws.com/3364_d1a578f521174152b46b19d0c83cbe7e.html
# discrete _ limit = only shows those bins (3 dates)
# discrete _ breaks = is what I wanted!! only show the xticks I want
ggplot(UK) +
  geom_bar(aes(x = date, y = new_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = new_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of New Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 30, face = "bold")) +
  xlab('Date') + 
  ylab('') +
  scale_x_discrete(breaks = c('2020-01-31', '2020-04-02', '2020-06-02'))
  

# SAME AS ABOVE 
# more custom
# breaks of the beginning of the month
# change the x labels to 1 Feb, 1 March, 1 April, 1 May, 1 June
ggplot(UK) +
  geom_bar(aes(x = date, y = new_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = new_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of New Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 15, face = "bold")) +
  xlab('Date') + 
  ylab('') +
  scale_x_discrete(breaks = c('2020-02-01', '2020-03-01', '2020-04-01', '2020-05-01', '2020-06-01'),
                   labels = c('1st Feb','1st March','1st April','1st May','1st June')) 

# ggsave('Overlap of New Deaths and Cases in the UK up to June 2nd.png')  



# ------------------------------------ SPAIN ----------------------------------

# spain df as sp
esp <- subset(df, countries =='Spain')

# new cases in UK
ggplot(esp, aes(date, new_cases)) +
  geom_bar(stat = 'identity', fill = 'midnightblue') +
  ggtitle('New Cases Per Day ESP June 2nd')


# New deaths in spain
# some data seems wrong here... negaitve deaths?
ggplot(esp, aes(date, new_deaths)) +
  geom_line(group=1) +
  ggtitle('New Deaths Per Day ESP June 2nd')

# total cases UK + total deaths ESP on SAME PLOT
ggplot(esp) +
  geom_bar(aes(x = date, y = total_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = total_deaths), group=1, color='darkred', size = 1) +
  ggtitle('Overlap of Total Deaths and Total Cases ESP June 2nd') +
  theme(plot.title = element_text(size = 30, face = "bold"))

# overlap of cases and deaths in spain
ggplot(esp) +
  geom_bar(aes(x = date, y = new_cases), fill = 'lightblue', stat='identity') +
  geom_line(aes(x = date, y = new_deaths), group=1, color='darkred', size = 1) +
  ggtitle('ESP Overlap of New Deaths and Total Cases June 2nd') +
  theme(plot.title = element_text(size = 15, face = "bold")) +
  xlab('Date') + 
  ylab('') +
  scale_x_discrete(breaks = c('2020-02-01', '2020-03-01', '2020-04-01', '2020-05-01', '2020-06-01'),
                   labels = c('1st Feb','1st March','1st April','1st May','1st June')) 












