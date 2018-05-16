##########################################################################
#Andrea Ayala
#5/14/18
#Exercise 2 for ECOL 8420, writing scripts
#Data provided by lab: WNV from Drake Lab Site/Origin USGS
##########################################################################

#Exercise 1.Write a script to load the West Nile virus data and use 
#ggplot to create a histogram #for the total number of cases in each state 
#in each year. Follow the format of the prototypical
#script advocated in the presentation: 
#Header, Load Packages, Declare Functions, Load Data, Perform Analysis.#

setwd("C:/Users/aayala1/Desktop/Computation/WNV")
wnv <-read.csv('wnv.csv')
library(ggplot2)

dim(wnv)
head(wnv, n = 5)
tail(wnv, n = 5)

#Practice plots

a<-ggplot(wnv, aes(x = Fatal)) +
  geom_histogram()
print(a)

#Created object, then stored histogram as object

#GGplot Total Cases syntax #1
ggplot(data=wnv) +
  geom_histogram(mapping = aes(x = Total)) +
  labs (x= 'Total Number of West Nile Cases from USGS', y = 'Case Count')
  #Directly called ggplot & made the graph a little fancier

#GGplot Total Cases by syntax #2
ggplot(data=wnv) +
  geom_histogram(mapping = aes(x =wnv$Total))

#Log10 of Total Cases = log of data in graph #1
ggplot(data=wnv) +
  geom_histogram(mapping = aes(x = Total)) + 
  scale_x_log10()

#Log10 of Total Cases = 
#ggplot(data=wnv) +
 # geom_histogram(mapping = aes(x = Total)) +
#coord_trans(log10(x))
#This isn't working above

#Functions Section
#Let us call the ratio of meningitis/encephalitis cases to the total number 
#of cases the neuroinvasive disease rate.

#Exercise. Write a function to calculate the mean and standard error 
#(standard deviation divided by the square root of the sample size) of the neuroinvasive disease 
#rate for all the states in a given list and given set of years. Follow the Google R style 
#and remember to place
#the function near the top of your script. Use your function to calculate the 
#average severe
#disease rate in California, Colorado, and New YorK

#Display all data to identify rows represented by CA, CO, & NY
print(wnv)
#This $ is the columns
wnv[wnv$Total==20,]
wnv[wnv$State=="California", ]

  

