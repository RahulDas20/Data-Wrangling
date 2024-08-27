#load raw heights and inspect
library(dslabs)
data("reported_heights")
class(reported_heights$height)


#convert to numeric, inspect and count NAs
x <- as.numeric(reported_heights$height)

sum(is.na(x))

#keep only the entries that results in NAs
reported_heights %>% mutate(new_height = as.numeric(height)) %>%
  filter(is.na(new_height))

#calculate the cutoffs that cover 99.999% of human population