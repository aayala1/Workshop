################################################
#Andrea Ayala
#Date 5/16/18
#Exercise 5: Project Management in R*
################################################

#Exercise. Copy the MERS data file cases.csv and paste it 
#into your working directory.

#Exercise. Create a new script following the prototype we 
#introduced. Your script should load
#the MERS data and make a plot.
rm(list=ls())
install.packages('ggmap')
install.packages('maps')
install.packages('readr')
install.packages('ggplot2')
setwd("C:/Users/aayala1/Desktop/Computation/Management")
library(ggmap)
library(maps)
library(readr)
library(ggplot2)

cases<-read.csv("cases.csv") #loading MERS data into script

#Scripting a plot
ggplot(data=cases) +
  geom_bar(mapping=aes(x=country)) +
  labs(x='country', y='Case count', title='Global count of MERS cases by country',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")

#Exercise:  To commit a change, navigate to the “Git” tab in the top right explorer window.
#You will see a list of files in your work directory. Select the files that need to be pushed to
#Github and click on “Commit”. A dialog box will open. In the top right there is an editing
#window where you can register a comment describing the nature of the commit.

#git config --global user.email "aayala1@uga.edu"
#git config --global user.name "aayala1"
#Running into a git config issue, i.e. 