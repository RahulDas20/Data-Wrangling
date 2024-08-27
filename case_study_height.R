#load raw heights and inspect
library(dslabs)
data("reported_heights")
class(reported_heights$height)
library(tidyverse)

#convert to numeric, inspect and count NAs
x <- as.numeric(reported_heights$height)

sum(is.na(x))

#keep only the entries that results in NAs
reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height))

#calculate the cutoffs that cover 99.999% of human population
alpha <- 1/10^6
qnorm(1-alpha/2, 69.1,2.9)
qnorm(alpha/2,63.7,2.7)

#keep only the entries that either result in NAs or outsidet the nornal range
not_inches <- function(x, smallest = 50, tallest = 84){
  inches <- suppressWarnings(as.numeric(x))
  ind <- is.na(inches) | inches < 50 | inches > 84
  ind
}


#number of problematic entries
problems <- reported_heights %>% 
  filter(not_inches(height)) %>%
  .$height



problems
length(problems)


# 10 examples of x'y or x'y" or x'y\"
pattern <- "^\\d\\s*'\\s*\\d{1,2}\\.*\\d*'*\"*$"
str_subset(problems, pattern) %>% head(n=10) %>% cat


#10 example of x.y or x,y
pattern <- "^[4-6]\\s*[\\.|,]\\s*([0-9]|10|11)$"
str_subset(problems, pattern) %>% head(n=10) %>% cat


#10 examples of elntries in cm rather than inches 
ind <- which(between(suppressWarnings(as.numeric(problems))/2.54,54,81))
ind
ind <- ind[!is.na(ind)]
ind
problems[ind] %>% head(n=10) %>% cat
