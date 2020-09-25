## Visualising Data with GGPLOT

# load ggplot

library(ggplot2) #if its already installed you dont need quotation marks
library(tidyverse)
#load data

surveys_complete <- read_csv("data_raw/surveys_complete.csv")  
# read_csv is tidyverse,  read.csv is base R

# 1 create a plot, need call ggplot and select the data

ggplot(data=surveys_complete)
# 2 aes is aesthetics, define the x and y (mappings)
ggplot(data=surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

# 3 doesnt know how to show it yet,  geom- what display you want
ggplot(data=surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

#think in layers, the grey box, the axes, the data

# assign a plot to an object you can then work with it and modify it.

surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))
#might need "mapping = )

#draw the plot
surveys_plot + geom_point()
# same but easier to read, but plus must be at the end of the line
surveys_plot +
 geom_point()

 #aesthetics applied to a geom only apply to the geom, others apply globally

#challenge 1
#Change the mappings so weight is on the y-axis and hindfoot_length is on the x-axis

ggplot(data = surveys_complete, mapping = aes(x = hindfoot_length, y = weight)) +
  geom_point()

#challenge 2
#How would you create a histogram of weights?

ggplot(data = surveys_complete, aes(x=weight)) + 
  geom_histogram(binwidth=10)
 



