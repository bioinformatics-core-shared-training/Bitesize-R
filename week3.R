## ----eval = FALSE---------------------------------------------------------------
# library(tibble)


## -------------------------------------------------------------------------------
library(tidyverse)


## ----eval = FALSE---------------------------------------------------------------
# install.packages("tidyverse")


## -------------------------------------------------------------------------------
beatles <- tibble(
  name = c("John", "Paul", "Ringo", "George"),
  birth_year = c(1940, 1942, 1940, 1943),
  instrument = c("guitar", "bass", "drums", "guitar")
)
beatles


## -------------------------------------------------------------------------------
iris_tibble <- as_tibble(iris)


## -------------------------------------------------------------------------------
class(iris)
class(iris_tibble)


## ----results=TRUE---------------------------------------------------------------
## inspect the data
str(iris_tibble)


## ----eval=FALSE, purl=TRUE------------------------------------------------------
# download.file(url="https://bioinformatics-core-shared-training.github.io/Bitesize-R/data/brca_metabric_clinical_data.tsv",destfile = "data/brca_metabric_clinical_data.tsv")
# download.file(url="https://bioinformatics-core-shared-training.github.io/Bitesize-R/data/metabric_clinical_and_expression_data.csv",destfile = "data/metabric_clinical_and_expression_data.csv")


## -------------------------------------------------------------------------------
metabric <- read_tsv("data/brca_metabric_clinical_data.tsv")


## -------------------------------------------------------------------------------
metabric


## **`read_csv()`** and **`read_tsv()`**
## 
## `read_csv()` reads data from a comma-separated value (CSV) file into a tibble.
## `read_tsv()` is the equivalent function that works on tab-delmited files.
## 
## These functions expect the first line to contain column names and try to make
## sensible guesses at the type of data in each column. You can change this by
## specifying various arguments, e.g. to skip comment lines beginning with a
## specific character (e.g. "#") or to tell the function what the column types
## are.
## 

## -------------------------------------------------------------------------------
#install.packages("janitor")
library(janitor)
metabric <- clean_names(metabric)


## -------------------------------------------------------------------------------
table(metabric$chemotherapy)


## -------------------------------------------------------------------------------
summary(metabric$mutation_count)


## ----eval = FALSE---------------------------------------------------------------
# getwd()


## -------------------------------------------------------------------------------
metabric$mutation_count[1:10]


## **Missing values** (**`NA`**)
## 
## Missing values in R are represented as **`NA`**, which stands for 'not available'.

## -------------------------------------------------------------------------------
mean(metabric$mutation_count)


## -------------------------------------------------------------------------------
mean(metabric$mutation_count, na.rm = TRUE)


## -------------------------------------------------------------------------------
first_ten_mutation_counts <- metabric$mutation_count[1:10]
is.na(first_ten_mutation_counts)


## -------------------------------------------------------------------------------
sum(is.na(metabric$mutation_count))


## -------------------------------------------------------------------------------
library(tidyverse)


## ----message = FALSE------------------------------------------------------------
metabric <- read_csv("data/metabric_clinical_and_expression_data.csv")
metabric



## -------------------------------------------------------------------------------
deceased <- filter(metabric, Vital_status == "Died of Disease")
deceased


## ----eval = FALSE---------------------------------------------------------------
# filter(metabric, Vital_status == "Died of Disease")
# # is equivalent to
# metabric[metabric$Vital_status == "Died of Disease", ]


## -------------------------------------------------------------------------------
table(metabric$Vital_status)


## -------------------------------------------------------------------------------
deceased <- filter(metabric, Vital_status != "Living")
nrow(deceased)


## -------------------------------------------------------------------------------
deceased <- filter(metabric, Vital_status %in% c("Died of Disease", "Died of Other Causes"))
nrow(deceased)


## -------------------------------------------------------------------------------
deceased <- filter(metabric, str_starts(Vital_status, "Died"))
nrow(deceased)


## -------------------------------------------------------------------------------
# create a new logical variable called 'Deceased'
metabric$Deceased <- metabric$Survival_status == "DECEASED"
#
# filtering based on a logical variable - only selects TRUE values
deceased <- filter(metabric, Deceased)
#
# only display those columns we're interested in
deceased[, c("Patient_ID", "Survival_status", "Vital_status", "Deceased")]


## ----eval = FALSE---------------------------------------------------------------
# filter(metabric, !Deceased)


## -------------------------------------------------------------------------------
missing_vital_status <- filter(metabric, is.na(Vital_status))
missing_vital_status[, c("Patient_ID", "Survival_status", "Vital_status", "Deceased")]


## -------------------------------------------------------------------------------
filter(metabric, Survival_status == "LIVING", Survival_time > 120)


## ----eval = FALSE---------------------------------------------------------------
# metabric[metabric$Survival_status == "LIVING" & metabric$Survival_time > 120, ]


## ----eval = FALSE---------------------------------------------------------------
# filter(metabric, Survival_status == "LIVING", Survival_time > 120)


## -------------------------------------------------------------------------------
selected_patients <- filter(metabric, Tumour_stage >= 3, ER_status == "Positive" | PR_status == "Positive")
nrow(selected_patients)


## ----eval = FALSE---------------------------------------------------------------
# filter(metabric, Tumour_stage >= 3 & (ER_status == "Positive" | PR_status == "Positive"))


## -------------------------------------------------------------------------------
deceased[, c("Patient_ID", "Survival_status", "Vital_status", "Deceased")]


## -------------------------------------------------------------------------------
select(metabric, Patient_ID, Survival_status, Vital_status, Deceased)


## -------------------------------------------------------------------------------
select(metabric, Patient_ID, Vital_status, Survival_status, Deceased)


## -------------------------------------------------------------------------------
select(metabric, Patient_ID, Chemotherapy:Tumour_stage)


## -------------------------------------------------------------------------------
select(metabric, contains("status"))


## -------------------------------------------------------------------------------
select(metabric, ends_with("status"))


## -------------------------------------------------------------------------------
select(metabric, -Cohort)


## -------------------------------------------------------------------------------
selected_columns <- select(metabric, Patient_ID, starts_with("Tumour_"), `3-gene_classifier`:Integrative_cluster, -Cellularity)
selected_columns


## -------------------------------------------------------------------------------
select(metabric, Patient_ID, Survival_status, Tumour_stage, everything())


## -------------------------------------------------------------------------------
select(metabric, Patient_ID, Classification = `3-gene_classifier`, NPI = Nottingham_prognostic_index)


## -------------------------------------------------------------------------------
arrange(metabric, Survival_time)


## -------------------------------------------------------------------------------
arrange(metabric, desc(Survival_time))


## -------------------------------------------------------------------------------
arrange(metabric, Tumour_stage, Nottingham_prognostic_index)


