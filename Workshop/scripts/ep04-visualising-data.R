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


## BUILDING Plots Interactively

 
ggplot(data = surveys_complete, mapping = aes(x = weight , y = hindfoot_length)) +
  geom_point(alpha = 0.1)

# alpha does transparentcy
ggplot(data = surveys_complete, mapping = aes(x = weight , y = hindfoot_length)) +
  geom_point(alpha = 0.1, colour = "red")

#use data in the dataframe to do the colour, note legend was added automatically
ggplot(data = surveys_complete, mapping = aes(x = weight , y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(colour = species_id))

#bc there is one geom, i can move the colour up to the aes SAME AS ABOVE
ggplot(data = surveys_complete, mapping = aes(x = weight , y = hindfoot_length, colour = species_id)) +
  geom_point(alpha = 0.1)
# "red" needs quotes bc it is not from the dataset, however, no "" needed for weight as its from the dataset



#challenge 3
#Use what you just learned to create a scatter plot of weight over species_id with the plot type showing in different colours. 

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_point(alpha = 0.2, aes(colour = plot_type))

# or
ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_jitter(alpha = 0.2, aes(colour = plot_type))
#geom_jitter moves the points so they are not sitting on top each other, u can change amount of jitter.


### Box plots good for when u havbe one discrete axis and one continous axis (e.g. taxa and abundance)

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_boxplot()

# add an alpha
ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, colour = "tomato")

# challenge 4

#Notice how the boxplot layer is behind the jitter layer? What do you need to change in the code to put the boxplot in front of the points such that it’s not hidden
# just put the boxplot last as they layers :-)
ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_jitter(alpha = 0., colour = "tomato") +
  geom_boxplot(alpha = 0)
# alpha 1 is white, 0 = totally transparent


#Challenge 5
#Boxplots are useful summaries but hide the shape of the distribution. For example, if there is a bimodal distribution, it would not be observed with a boxplot. An alternative to the boxplot is the violin plot (sometimes known as a beanplot), where the shape (of the density of points) is drawn.
#Replace the box plot with a violin plot

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, y = weight))+
  geom_violin(alpha = 0, colour = "tomato")



#Challenge 6
#So far, we’ve looked at the distribution of weight within species. Make a new plot to explore the distribution of hindfoot_length within each species.
#Add color to the data points on your boxplot according to the plot from which the sample was taken (plot_id).

#Hint: Check the class for plot_id. Consider changing the class of plot_id from integer to factor. How and why does this change how R makes the graph

ggplot(data=surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.3, colour = "tomato") +
  geom_boxplot(alpha = 0)

#now need to colour according to plot_id

ggplot(data=surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.3, colour = "tomato") +
  geom_boxplot(alpha = 0)

#however this gives a graduated colour (continuos for plot) therefore no good.
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)

class(surveys_complete$plot_id)
#comes out as numeric, but needs to a factor
#want to change it in the dataframe, this rewrites are master dataframe replacing this variable as a factor.

surveys_complete$plot_id <-   as.factor(surveys_complete$plot_id)

class(surveys_complete$plot_id)

#now rerun the same script
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(colour = plot_id)) +
  geom_boxplot(alpha = 0)

#this option just changes it to a factor for the graph but not in the main dataset- but legend needs to be changed
#don't really need this option. 

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_id))) +
  geom_boxplot(alpha = 0)


#Challenge 7
#In many types of data, it is important to consider the scale of the observations. For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). 

#Make a scatter plot of species_id on the x-axis and weight on the y-axis with a log10 scale.

ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_id))) +
  scale_y_log10()


### time series- coumts per year per genus , notice it it created the count column called n

yearly_counts <- surveys_complete %>% 
  count(year, genus)
yearly_counts

ggplot(data = year_counts, mapping = aes(x = year, y = n, group = genus)) +
  geom_line()

### this works much better!!!  
ggplot(data = year_counts, mapping = aes(x = year, y = n, colour = genus)) +
  geom_line()


## or with piping, not this + a layer not a pipe;. 

yearly_counts_graph <- surveys_complete %>%
  count(year, genus) %>% 
  ggplot(mapping = aes(x = year, y = n, color = genus)) +
  geom_line()
#to display it
yearly_counts_graph


### FACETING makes panels !!!!

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))
# or
facet_wrap(~genus)

# how the data varies by sex 

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

yearly_sex_counts <- surveys_complete %>% 
  count(year, genus, sex)
view(yearly_sex_counts)

yearly_sex_counts %>%
  ggplot(mapping = aes(x=year, y=n, colour=sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))


# now facet by sex and genus

yearly_sex_counts %>%
  ggplot(mapping = aes(x=year, y=n, colour=sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols = vars(genus))


  # 
yearly_sex_counts %>%
  ggplot(mapping = aes(x=year, y=n, colour=sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))


# Challenge 8
# Modify the code for the yearly counts to colour by genus so we can clearly see the counts by genus. 

yearly_sex_counts %>%
  ggplot(mapping = aes(x=year, y=n, colour=sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))


### customizing your plot THEMES, like a present

ggplot(data=yearly_sex_counts, mapping = aes(x=year, y=n, colour = sex)) +
  geom_line() +
  facet_wrap(~genus) +
  theme_bw()

# also a package called ggthemes if you need it
#just a different theme

ggplot(data=yearly_sex_counts, mapping = aes(x=year, y=n, colour = sex)) +
  geom_line() +
  facet_wrap(~genus) +
  theme_classic()

#Challenge 10
#
# Put together what you’ve learned to create a plot that depicts how the 
# average weight of each species changes through the years.
#
# Hint: need to do a group_by() and summarize() to get the data
# before plotting

yearly_weight <- surveys_complete %>% 
  group_by(year, species_id) %>% 
  summarize(mean_weight = mean(weight))
view(yearly_weight)

yearly_weight %>% 
  ggplot(mapping = aes(x = year, y = mean_weight, colour = species_id))+
  geom_line()+
  facet_wrap(~species_id)
  theme_bw()
yearly_weight

#same without colour, therefore get rids of the legend. 
yearly_weight %>% 
  ggplot(mapping = aes(x = year, y = mean_weight))+
  geom_line()+
  facet_wrap(~species_id)
theme_bw()
yearly_weight

#customize stuff # NEED TO GET THIS FROM GOOGLE DOCUMENT!!!!
 


# save image- export is low quality therefore use code
# we will save into our fig folder

#will save the last fig 
ggsave ("figures/my_plot.png", width = 15, height = 10)  # you can define the width and height in cms see manual
# can make a pdf
ggsave ("figures/my_plot.pdf", width = 15, height = 10)


