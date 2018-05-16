################################################
#Andrea Ayala
#Date 5/15/15
#Exercise 3: Data wrangling in R*
################################################
rm(list=ls())
install.packages('tidyverse')
install.packages('magrittr')
install.packages('dplyr')
install.packages('stringr')
install.packages('GGally')
install.packages('maptools')
install.packages('ggmap')
install.packages('maps')
install.packages('readr')
setwd("C:/Users/aayala1/Desktop/Computation/Lyme")

#https://www.statmethods.net/interface/packages.html
library(tidyverse) #add package to library
library(magrittr) #add package to library
library(dplyr) #add package to library
library(stringr) #add package to library
library(GGally) #add package to library
library(maptools) #add package to library
library(ggmap) #add package to library
library(maps) #add package to library

#reading delimited files into a tibble
#https://readr.tidyverse.org/reference/read_delim.html

#read_csv("climate.csv") #read csv
#read_csv("lyme.csv") #read csv
#read_csv("pop.csv") #read csv

#Task 1: Read in all three csv files as tibble data frames. For consistency with these notes, we'll assign their
#dataframes to be called "ld", "pop" and "prism", resectively.

prism <-read_csv("climate.csv")
pop <-read_csv("pop.csv")
ld <-read_csv ("lyme.csv")

#Task 2: By inspecting the 'pop' data, and talking with your neighbors and instructors, articulate in which
#way(s) these data fail to conform to the tidy data format?

#Principles of Tidy Data https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html
#Column headers are values, not variable names.
#Multiple variables are stored in one column.
#Variables are stored in both rows and columns.
#Multiple types of observational units are stored in the same table.
#A single observational unit is stored in multiple tables.

pop #hit key return to visualize. Similar to print (pop)
#pipes: The pipe captures expressions on each side of the
#%>% operator and then arranges for the thing on the left of 
#%>% to be injected into the expression on the right of %>%, 
#usually as the first argument but not always. 
#This all involves capturing the expressions and evaluating them within the %>%() function.


pop %<>% select(fips,starts_with("pop2")) #running this command
#pop = data file/tibble
#%<>% = directionality of pipes
#select = keeps only the variables mentioned, in this
#       case the variable fips data starting from the year 2000 and higher

pop #visualize tibble after command run
#Selected a subset of data from pop, the fips data associated with
#census data in the year 2000 and above

pop %<>% gather(starts_with("pop2"),key="str_year",value="size") %>% na.omit
#pop = data file/tibble
#gather = collects a set of column names and places them into a single column
#key = name of new key columns as strings or symbols
#value = name of new value columns as strings or symbols
#na.omit = returns table/tibble by omitting NAs i.e. missing values

#running the command op %<>% gather(starts_with("pop2"),key="str_year",value="size") %>% na.omit
#returned fewer variables & observations

pop %<>% mutate(year=str_replace_all(str_year,"pop",""))
#mutate part of the dplyr package, creates new columns by 
#preserving existing ones, in this case the column 'year'
#str_replace_all(string, pattern, replacement)
pop #now returns a tibble with 4 columns & 50,792 observations
# the new columns are fips, str_year, size, year
#the column name pop was replaced by year?

pop %<>% mutate(year=as.integer(year))
#mutate, again as part of the dplyr pkge, is going to
#to change the values of year into integers since their
#category is currently a character.
pop #returned a tibble with year as a column of integers instead of 
#characters

pop %<>% mutate(fips=str_replace_all(fips,"^0",""))
#mutate again as part of the dplyr pkge, replacing all
#str_replace_all
pop
#the replace function removed the leading 0's from column 1
#by replacing them with ""

pop %<>% mutate(fips=as.integer(fips))
#turns the variable fips into being read as integers 
#instead of characters

#Task 4: Write a code chunk to convert the 
#Lyme disease data to tidy data format

ld #running the ld data to see the format
#Steps to take:
#Merging columns STCODE and CTYCODE
#Changing the name of the new column into fips
#Adding zeroes where necessary to get 5 character fips


#Solution in handout
ld %<>% gather(starts_with("Cases"),key="str_year",value="cases")
#gather collects all columns that start with the word cases
ld
ld %<>% mutate(year=str_replace_all(str_year,"Cases",""))
ld
ld %<>% mutate(year=as.integer(year))
ld
ld %<>% rename(state=STNAME,county=CTYNAME)
ld

fips.builder<-function(st,ct){
  if (str_length(ct)==3){
    fips<-paste(as.character(st),as.character(ct),sep="") %>% as.integer
  }
  else if (str_length(ct)==2){
    fips<-paste(as.character(st),"0",as.character(ct),sep="") %>% as.integer
  }
  else {
        fips<-paste(as.character(st),"00",as.character(ct),sep="") %>% as.integer
  }
  return(fips)
}
ld
ld %<>% rowwise() %>% mutate(fips=fips.builder(STCODE,CTYCODE))
