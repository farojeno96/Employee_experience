library(haven)
library(lmtest)
library(sandwich)
library(ggplot2)
library(tidyverse)

# Setting the working directory

setwd("C:/Users/Jenő/Desktop/ELTE/2024 ősz - GTK/Egyebek/Laurának segítség")

# Reading the data which have been preprocessed in SPSS
data <- read_sav("C:/Users/Jenő/Desktop/ELTE/2024 ősz - GTK/Egyebek/Laurának segítség/PCA_and_interactions_FINAL.sav")
attach(data)
# We exclude the cases, where no valid answer has been received for the question: In which sector do you work?
data <- data %>% filter(!is.na(Kéremjelöljemeghogyholdolgozik))


# Modeling the physical EX dimension (Eq. (3) in the paper):

model_1_with_interactions_fizikai <- lm(FAC_fizikai_1 ~ FAC_klan_1 +FAC_adhok_1 + FAC_hierar_1 + FAC_piac_1 + 
                                  Kozszfera + Nonprofit +
                                  Klan_kozszfera + Klan_nonprofit + 
                                  Adhokracia_kozszfera + Adhokracia_nonprofit + 
                                  Hierarchia_kozszfera + Hierarchia_nonprofit + 
                                  Piac_kozszfera + Piac_nonprofit)

# Checking the estimated coefficients and their equality to those estimated using SPSS

summary(model_1_with_interactions_fizikai)

# Testing homoscedasticity using BP-test

bptest(model_1_with_interactions_fizikai)

# Modeling the technological EX dimension (Eq. (4) in the paper): 

model_1_with_interactions_tech <- lm(FAC_tech_1 ~ FAC_klan_1 +FAC_adhok_1 + FAC_hierar_1 + FAC_piac_1 + 
                                          Kozszfera + Nonprofit +
                                          Klan_kozszfera + Klan_nonprofit + 
                                          Adhokracia_kozszfera + Adhokracia_nonprofit + 
                                          Hierarchia_kozszfera + Hierarchia_nonprofit + 
                                          Piac_kozszfera + Piac_nonprofit)

# Checking the estimated coefficients and their equality to those estimated using SPSS

summary(model_1_with_interactions_tech)

# Testing homoscedasticity using BP-test

bptest(model_1_with_interactions_tech)


# Modeling the cultural EX dimension (Eq. (5) in the paper): 

model_1_with_interactions_kult <- lm(FAC_kultura_1 ~ FAC_klan_1 +FAC_adhok_1 + FAC_hierar_1 + FAC_piac_1 + 
                                       Kozszfera + Nonprofit +
                                       Klan_kozszfera + Klan_nonprofit + 
                                       Adhokracia_kozszfera + Adhokracia_nonprofit + 
                                       Hierarchia_kozszfera + Hierarchia_nonprofit + 
                                       Piac_kozszfera + Piac_nonprofit)

# Checking the estimated coefficients and their equality to those estimated using SPSS

summary(model_1_with_interactions_kult)

# Testing homoscedasticity using BP-test

bptest(model_1_with_interactions_kult)

# Estimating robust standard errors in case of the cultural EX dimension

coeftest(model_1_with_interactions_kult, vcov = vcovHC(model_1_with_interactions_kult, type = "HC0"))

# Extracting variance-covariance matrices for the model having the...
  # physical EX dimension as outcome variable
vcov(model_1_with_interactions_fizikai)
# technological EX dimension as outcome variable
vcov(model_1_with_interactions_tech)
# cultural EX dimension as outcome variable
vcovHC(model_1_with_interactions_kult, type = "HC0")

# Further calculations are made in Excel

