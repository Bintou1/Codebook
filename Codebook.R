#Bintou Doumbia Codebook Assigment 

#How Americans like their steak and why?

library(tidyverse)
library(haven)
library(readr)

FctWhen = function(...){
  args = rlang::list2(...)
  rhs = map(args, rlang::f_rhs)
  cases = case_when(!!!args)
  exec(fct_relevel, cases, !!!rhs)
}

# change variable types and load
steak <- read_csv("steak-risk-survey.csv", 
                  col_types = cols(RespondentID = col_number(), 
                                   Age = col_number(), `Household Income` = col_number()))

summary(steak)

#rename variables
df = 
  steak %>% 
  rename( lottery = 'Consider the following hypothetical situations: <br>In Lottery A, you have a 50% chance of success, with a payout of $100. <br>In Lottery B, you have a 90% chance of success, with a payout of $20. <br><br>Assuming you have $10 to bet, would you play Lottery A or Lottery B?',
                    smoke = 'Do you ever smoke cigarettes?', 
drink = 'Do you ever drink alcohol?', 
gamble ='Do you ever gamble?',
skydiving = 'Have you ever been skydiving?',
above_speed = 'Do you ever drive above the speed limit?',
cheat = 'Have you ever cheated on your significant other?',
steak = 'Do you eat steak?',
steak_cook= 'How do you like your steak prepared?',
income = 'Household Income',
location = 'Location (Census Region)')


#relocated variables to make sense
df1 = df %>%
  relocate(steak_cook, .before = lottery)
           


df2 = df1 %>%
  relocate(steak, .before = steak_cook)
      

#label variable as factor and mutate new factor with numbers 

df2$steak_cook <- factor(df2$steak_cook)
    
df2$steak <- factor(df2$steak)


df3 = df2 %>% 
  mutate(
    cook = case_when(
    steak_cook == "Well" ~ 5,
    steak_cook == "Medium Well" ~ 4,
    steak_cook == "Medium" ~ 3, 
    steak_cook == "Medium rare" ~ 2, 
    steak_cook == "Rare" ~ 1), 
    .before = 4)
%>%
  mutate(
    steak1 = case_when(
      steak == "Yes" ~ 1,
     steak == "No" ~ 0),
     .before = 3)


#change NA to -9 in new variables  

df3["steak1"][is.na(df3["steak1"])] <- -9

df3["cook"][is.na(df3["cook"])] <- -9


#summarize factor variables 

#steak_cook
freq <- df3 %>%
  count(steak_cook) %>%       
  mutate(prop = n/sum(n)) 

#Steak 
freq1 <- df3 %>%
  count(steak) %>%       
  mutate(prop = n/sum(n))

#steak1
freq2 <- df3 %>%
  count(steak1) %>%       
  mutate(prop = n/sum(n)) 

#cook
  freq3 <- df3 %>%
  count(cook) %>%       
  mutate(prop = n/sum(n)) 


  #Age and Income (numeric) 
#stats   

age = df3 %>%
  summarise(
    mean_age = mean(Age, na.rm = TRUE),
    med_age = median(Age, na.rm = TRUE),
    sd_age = sd(Age, na.rm = TRUE),
    min_age = min(Age, na.rm = TRUE),
    max_age = max(Age, na.rm = TRUE))
  

income= df3 %>%
  summarise(
    mean_income = mean(income, na.rm = TRUE),
    med_income = median(income, na.rm = TRUE),
    sd_income = sd(income, na.rm = TRUE),
    min_income = min(income, na.rm = TRUE),
    max_income = max(income, na.rm = TRUE))



#////////////////////////////////
#save in csv
df4 = df3 %>%
  mutate(across(where(is.factor),as.numeric)) 

write.csv(df4,"SteakCook.csv",row.names=FALSE)
         
         
#save coded data in rdata     
   save(df3,file = "SteakCook.RData")


            
            