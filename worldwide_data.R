# total covid deaths and cases worldwide

library('readxl')

data <- read_excel('RAW_26june.xlsx')

df <- data.frame(data)

# change column name to country
colnames(df)[7] <- 'country'
colnames(df)[1] <- 'date'

# df of todays numbers using dplyr
library(dplyr)

today <- filter(df, month==6, day==26)
head(today)

# add up the total cases and total deaths for ALL countries
# for loop? NO NEED use sum() function

cases <- sum(today$cases)
deaths <- sum(today$deaths)
cases  
deaths

# need to play all these together
# for loop to add all the days into a new list then plot from that?