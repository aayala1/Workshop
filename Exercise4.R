#######################################################
#Andrea Ayala
#Data from Troy Koser/8450/Tidy Data id.pop.climate
#5/15/18
#Exercise in Modelling
######################################################
rm(list=ls())
setwd("C:/Users/aayala1/Desktop/Computation/Lyme")
install.packages('tidyverse')
install.packages('magrittr')
install.packages('dplyr')
install.packages('stringr')
install.packages('GGally')
install.packages('maptools')
install.packages('ggmap')
install.packages('maps')
install.packages('readr')

library(tidyverse)
library(magrittr)
library(GGally)

#Task 1: Using either read_csv (note: the underscore version, not read.csv) or load, import the data set
#you put together in the module on 'Data wrangling in R'.
ld.prism.pop<-read_csv("ld.prism.pop.csv")
dim(ld.prism.pop)
ld.prism.pop
#Example syntax 
#for ggpairs: ggpairs(df,columns=c("x","y","z")).
#this will make a 3x3 plot

#Task 2: Use the ggpairs function to obtain a 4x4 summary plot 
#of precipitation  (prcp), 
#average temperature (avtemp), 
#population size (size), 
#number of Lyme disease cases (cases)

ggpairs(ld.prism.pop,columns=c("prcp","avtemp","size","cases"))

#Task 3: Create two new columns for log10(size) 
#and log10(cases+1) and substitute these for the 
#original size and cases supplied when you 
#recreate the ggpairs plot. 
#Why do we add 1 to the number of cases?

#Adding 1 = since there are 0 values,
#taking the 1og10 of 0 = 1.

#How is this done? 
#https://tibble.tidyverse.org/reference/add_column.html
#add_column(.data, ..., .before = NULL, .after = NULL)

#pop %<>% mutate(year=str_replace_all(str_year,"pop",""))
#mutate part of the dplyr package, creates new columns by 
#preserving existing ones, in this case the column 'year'
#str_replace_all(string, pattern, replacement)
#pop #now returns a tibble with 4 columns & 50,792 observations
# the new columns are fips, str_year, size, year
#the column name pop was replaced by year?

ld.prism.pop%<>%mutate(Lg10=log10(size))
ld.prism.pop

ld.prism.pop%<>%mutate(Lg101=log10(cases+1))
ld.prism.pop

#In the above line of code, mutate created one new column
#each time, the first new column is called Lg10 and 
#the second new column is called Lg101

#Creating the new plots:
ggpairs(ld.prism.pop,columns=c("prcp","avtemp","size","cases","Lg10","Lg101"))

#Task4: Using set.seed(222) for reproducibility, 
#create a new data frame to be a random sample 
#(n=100 rows) of the full data frame and plot 
#precipitation (x-axis) vs average temperature (y-axis).

#set.seed = reproducible (same random number)
#https://web.stanford.edu/class/bios221/labs/simulation/Lab_3_simulation.html
set.seed(222)

