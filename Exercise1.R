#setwd("C:/Users/aayala1/Desktop/Computation")#
#setwd("C:/Users/aayala1/Desktop/Computation/MERS")#
#Starting Exercise 1, Andrea Ayala, 5/14/2018#
mers<-read.csv('cases.csv')
#downloaded from github & imported into Rstudio#
head(mers)
#We can inspect the data using the base R function head. We see that some variables, such as onset and
#hospitalized are dates, but formatted as a factor#
#mers has 1741 obs. of 46 variables#
class(mers$onset)
##turned this variable into factor#
#These dates can be reformatted using the lubridate package. Here we create new variables using the Date
#class. But, first we correct a few errors.#
mers$hospitalized[890]<-c('2015-02-20')
mers <- mers[-471,]
#library(lubridate)# 
#library(ggplot2)#
#Note from console: Attaching package: 'lubridate'

#The following object is masked from 'package:base':
  
  #date

#Warning message:
 # package 'lubridate' was built under R version 3.4.4#
mers$onset2 <- ymd(mers$onset)
mers$hospitalized2 <- ymd(mers$hospitalized)
#Warning message: #
#5 failed to parse. #
class(mers$onset2)
#[1] "Date"
#5 failed to parse.
#We may also find it useful to have a simple numerical value for the days elapsed since the start of the epidemic.
#We use the following code to search for the earliest onset date.
day0 <- min(na.omit(mers$onset2))
# 5 failed to parse.#
#Question. Why do we use the function na.omit? What happens if we neglect this command?#
#Answer#
#https://stat.ethz.ch/R-manual/R-devel/library/stats/html/na.fail.html#
#Deals with missing data - omits missing data from analysis, necessary for
#statistical analyses, example, GLMs#
#If one does not exclude missing data, statistical tests may be impacted, depending on the models#
#Now we can create a new, numeric value for the "epidemic day" for each case.#
mers$epi.day <- as.numeric(mers$onset2 - day0)
#number of variables changed in Data/Global Environment, however
#received same warning 5 failed to parse.#


#Question. What purpose does the command as.numeric serve?#
#https://www.rdocumentation.org/packages/base/versions/3.5.0/topics/numeric
#Numeric Vectors
#Creates or coerces objects of type "numeric". is.numeric is a more general test of an object being interpretable as numbers.
#Changes characters from one type, i.e. character, to be read as a numeric value#
#getting an epidemic curve#
ggplot(data=mers) +
  geom_bar(mapping=aes(x=epi.day)) +
  labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")
#Exercise. To produce this plot, type all the commands up to this point exactly as they appear.
#Particularly, note that as we "build" the plot in the last code snippet, we end each line with
#the addition syhmbol "+". What happens if we don't use this convention?

#According to https://stackoverflow.com/questions/38166708/plus-sign-between-ggplot2-and-other-function-r#
#The purpose of the plus sign in the ggplot function is to add objects to the ggplot, i.e. objects needed to
#construct the plot#
ggplot(data=mers) +
  geom_bar(mapping=aes(x=epi.day, fill=country)) +
  labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")
#Exercise. Modify the epidemic curve using the argument position="fill". What does this
#plot show?
#Modifying plot by exchanging city for country#
ggplot(data=mers) +
  geom_bar(mapping=aes(x=epi.day, fill=city)) +
  labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")
#Exercise. Another way to modify a bar plot is to change the coordinates. This can be done
#by "adding" coord_flip() and coord_polar() to the plot. What does this plot show?
ggplot(data=mers) +
  geom_bar(mapping=aes(x=epi.day, fill=city)) +
  coord_flip() +
  labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")

ggplot(data=mers) +
  geom_bar(mapping=aes(x=epi.day, fill=city)) +
  coord_flip() +
  coord_polar() +
  labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")
#The first plot with just the coord flip command rotated the view of the axes. The second command turned it into a 360 degree plot.


#Univariate Plots with the MERS data#
mers$infectious.period <- mers$hospitalized2-mers$onset2 # calculate "raw" infectious period
class(mers$infectious.period)

mers$infectious.period <- as.numeric(mers$infectious.period, units = "days") # convert to days
ggplot(data=mers) +
  geom_histogram(aes(x=infectious.period)) +
  labs(x='Infectious period', y='Frequency', title='Distribution of calculated MERS infectious period',
       caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")

#Ifelse() function
#Most of the functions in R take vector as input and output a resultant vector.
#This vectorization of code, will be much faster than applying the same function to 
#each element of the vector individually.
#Similar to this concept, there is a vector equivalent form of the 
#if.else statement in R, the ifelse() function.

mers$infectious.period2 <- ifelse(mers$infectious.period<0,0,mers$infectious.period)
ggplot(data=mers) +
  geom_histogram(aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency', 
       title='Distribution of calculated MERS infectious period (positive values only)', caption="Data ifelse")

#receiving errors on bin widths, R is asking me to use binwidth to use better values#

#Exercise. Investigate the frequency of hospital-acquired infections of MERS
#There are lots of different plot types that one can use to inspect continuously valued or integer-valued data
#like these. For instance, the density plot

ggplot(data=mers) +
  geom_density(mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Probability density for MERS infectious period (positive values only)', caption="Data from Frequency")

#Or the area plot
ggplot(data=mers) +
  geom_area(stat='bin', mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Area plot for MERS infectious period (positive values only)', caption="Data from: https://github.com/rambaut/MERS???Cases/blob/gh???pages/data/cases.csv")

#Exercise. Use the infectious period data calculated in mers$infectious.period2 to experiment
#with other univariate plot types like geom_dotplot and geom_bar.

ggplot(data=mers) +
  geom_dotplot(stat='bin', mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Area plot for MERS infectious period (positive values only)', caption="Data from: https://github.com/rambaut/MERS???Cases/blob/gh???pages/data/cases.csv")
#removed stat_bin due to error
ggplot(data=mers) +
  geom_dotplot(mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Area plot for MERS infectious period (positive values only)', caption="Data from: https://github.com/rambaut/MERS???Cases/blob/gh???pages/data/cases.csv")
#attempting geom_bar
ggplot(data=mers) +
  geom_bar(stat='bin', mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Area plot for MERS infectious period (positive values only)', caption="Data from: https://github.com/rambaut/MERS???Cases/blob/gh???pages/data/cases.csv")

#Exercise. Use our corrected infectious period variable (infectious.period2) to study the change
#in the infectious period over the course of the MERS epidemic.
#Answer: Change is from negative to positive integers, but more importantly, it appears
#that the infectious period is not a curve but more of a spline or mid-curve."


#Exercise. In data from many outbreaks it can be seen that there is a kind of societal learning.
#When the infection first emerges it is not quickly recognized, public health resources have not
#been mobilized, it is not known what symptoms are diagnostic, how to treat, etc. But, quickly,
#this information is collected and the outbreak is contained. Is there evidence of this kind of
#societal learning in the mers data. Add a curve fit using geom_smooth to explore this question.
#Hint: We solved using the loess method because the default smoother (gam) failed.

ggplot(data=mers) +
  geom_point(stat='bin', mapping=aes(x=infectious.period2)) +
  labs(x='Infectious period', y='Frequency',
       title='Area plot for MERS infectious period (positive values only)', caption="Data from: https://")