##Collecting GST data###
#Put in word pair of interest in parentheses of line 8
#After running gtrends searches (lines 10-22), change the saved file name in lines 24-30 appropriately. 
#Then update the keywords in UkrSpell and rerun for the new keywords

library(gtrendsR)

UkrSpell <- c("Myrnohrad", "Dymytrov")

Sep21 <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2021-09-1 2021-09-30")

Sep22 <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2022-09-1 2022-09-30")

Week1 <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2022-02-24 2022-03-2")

Week2 <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2022-03-3 2022-03-9")

Week3 <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2022-03-10 2022-03-17")

Recent <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2023-01-1 2023-01-7")

Cohesive <- gtrends(c(UkrSpell), geo = ("US"), compared_breakdown = TRUE, low_search_volume = TRUE, time = "2021-09-1 2023-01-7")

write.csv(Sep21[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateSept2021Comp.csv", row.names=FALSE)
write.csv(Sep22[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateSept2022Comp.csv", row.names=FALSE)
write.csv(Week1[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateWeek1Comp.csv", row.names=FALSE)
write.csv(Week2[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateWeek2Comp.csv", row.names=FALSE)
write.csv(Week3[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateWeek3Comp.csv", row.names=FALSE)
write.csv(Recent[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateRecentComp.csv", row.names=FALSE)
write.csv(Cohesive[["interest_by_region"]], "C:\\Users\\1896c\\Documents\\gtrendsR results\\Myrnohrad_StateSept2021Comp.csv", row.names=FALSE)


###Reformatting### 

library(dplyr)
library(stringr)

#Use files made from GST data collection step#
#steps: set RStudio search to "whole word", replace keyword_comp with new df, replace keyword_comp_reformatted with new df_reformatted, run, remove used df, use "remove after fin" space (line 44) to search new df

#search
Pokrov_StateCohesiveComp
Pokrov_StateCohesiveComp_reformatted
#remove after fin 
Pokrov_StateCohesiveComp

##Run from here after changing out words##
#Make a new df that has the states from the original file
Pokrov_StateCohesiveComp_reformatted = data.frame(Pokrov_StateCohesiveComp[1:51,1])

#Add columns to the new df that is filled with the hits from the orig df
Pokrov_StateCohesiveComp_reformatted$Pct.Ukr = Pokrov_StateCohesiveComp$hits[1:51]
Pokrov_StateCohesiveComp_reformatted$Pct.Rus = Pokrov_StateCohesiveComp$hits[52:102]

#Based on Pct.Ukr Values add majority. NEEDS TO BE RAN IN THIS ORDER.
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr > 50] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr < 50] <- "Anti-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr =="" & Pokrov_StateCohesiveComp_reformatted$Pct.Rus =="" ] <- "NA"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Rus > 50] <- "Anti-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "100%"] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "92%"] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "91%"] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "93%"] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "94%"] <- "Pro-Ukraine"
Pokrov_StateCohesiveComp_reformatted$Majority[Pokrov_StateCohesiveComp_reformatted$Pct.Ukr == "50%"] <- "Equal"

View(Pokrov_StateCohesiveComp)
View(Pokrov_StateCohesiveComp_reformatted)

#write csv
write.csv(Pokrov_StateCohesiveComp_reformatted,"D:\\Lab\\EAGER\\GSTCompBreakDown\\Reformatted\\Pokrov_StateCohesiveComp_reformatted.csv", row.names=FALSE)
rm(Pokrov_StateCohesiveComp)