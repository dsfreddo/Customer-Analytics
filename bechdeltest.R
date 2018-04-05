#Inspecting the dataset

bechdel

#Function utilized for calculating numbers for geom segment

bechdel %>% 
  filter(year %in% c(2010:2013)) %>% 
  filter(clean_test %in% c("ok", "dubious")) %>% 
  count()

#Creating a data frame to hold numbers for geom segment points

dat <- data.frame(x=c(1970, 1974, 1974, 1979, 1979, 1984, 1984, 1989, 1989, 1994, 1994, 1999, 1999, 2004, 2004, 2009, 2009),
                  y=c(.238, .238, .333, .333, .379, .379, .447, .447, .422, .422, .538, .538, .559, .559, .551, .551, .547),
                  x2=c(1974, 1974, 1979, 1979, 1984, 1984, 1989, 1989, 1994, 1994, 1999, 1999, 2004, 2004, 2009, 2009, 2013),
                  y2=c(.238, .333, .333, .379, .379, .447, .447, .422, .422, .538, .538, .559, .559, .551, .551, .547, .547))  

#Plotting of stacked histogram made in replication of 538 bechdel plot

ggplot(data = bechdel, aes(year)) +
  geom_histogram(aes(fill = clean_test), colour = "white", position = "fill", breaks=c(1970, 1974, 1979, 1984, 1989, 1994, 1999, 2004, 2009, 2013)) +
  scale_fill_manual(breaks = c("ok", "dubious", "men", "notalk", "nowomen"), 
                    values=c("red", "salmon", "lightpink", "dodgerblue", "blue"),
                    labels = c("Passes Bechdel Test", "Dubious", "Women only talk about men", "Women don't talk to each other", "Fewer than two women"), 
                    guide = guide_legend(title.position = "right", title = "", reverse = TRUE)) +
  theme(plot.title = element_text(size = 23, face = "bold"),
        plot.subtitle = element_text(size = 15),
        plot.caption = element_text(hjust = -2.5),
        legend.text = element_text(size = 12)) +
  scale_y_continuous(labels =  percent) +
  ggtitle("The Bechdel Test Over Time") +
  labs(y = "Percentage Pass/Fail", x = "Year(every 5 years)", subtitle = "How women are represented in movies", caption = "Source: FiveThirtyEight Bechdel Dataset") +
  geom_segment(data = dat, aes(x = x, y = y, xend = x2, yend = y2), size = 2) +
  scale_color_manual(values = "Black") +
  guides(color = FALSE, size = FALSE)

#Filtered and calculated median budget in 2013$ and then plotted that info on a horizontal bar plot.

bechdel %>% 
  filter(year %in% c(1990:2013)) %>% 
  filter(clean_test %in% c("ok", "men", "notalk", "nowomen")) %>% 
  group_by(clean_test) %>% 
  summarise(Median_Budget = median(budget_2013)) %>% 
  ggplot(aes(x = clean_test, y = Median_Budget, label = paste0("$", round(Median_Budget/1000000, digits = 1),"m"))) +
  geom_bar(stat = "identity", fill = "dodgerblue2") +
  coord_flip() +
  geom_text( hjust = -0.1, size = 5) +
  scale_x_discrete(labels=c("Fewer than two women", "Women don't talk to each other", "Women only talk about men", "Passes Bechdel Test")) +
  scale_y_discrete(labels=("")) +
  ggtitle("Median Budget For Films Since 1990") +
  theme(plot.title = element_text(size = 23, face = "bold"),
        plot.subtitle = element_text(size = 15),
        axis.text.y = element_text(size = 14)) +
  labs(y = "", x = "", subtitle = "2013 dollars")
  
  
###########################################################################

#Ignore below, just some random functions and help files
  
  
?theme_fivethirtyeight
?element_text
bechdel %>% 
  arrange(-year)
bechdel %>% 
  group_by(year %in% 1970:1974 & 1975:1979 & 1980:1984 & 1985:1989 & 1990:1994 & 1995:1999 & 2000:2004 & 2005:2009 & 2010:2013) %>% 
  ggplot(aes(year)) +
  geom_histogram(aes(fill = clean_test), position = "fill") +
  theme_fivethirtyeight() +

  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

install.packages("fivethirtyeight")

bechdel %>% 
  filter(binary == "PASS") %>% 
  arrange(-domgross)
?bechdel
 bechdel %>% 
   filter(year == 1975)
 ?
   breaks=seq(1970, 2015, 5)