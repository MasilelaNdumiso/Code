######Libraries 

library(SPEI)
library(tidyverse)
library(writexl)
library(readxl)



###################
#                 #
#   In-Situ Data  #
#                 # 
##################


####### Importing all the Data

df_list <- map(set_names(excel_sheets("Selected Stations.xlsx")), read_excel, path = "Selected Stations.xlsx", col_types = 'numeric')
list2env(df_list, envir = .GlobalEnv)

Stellenbosch <- pivot_longer(Stellenbosch, cols = -c("Year"), names_to = 'month', values_to = "Rain(mm)")
write_xlsx(Stellenbosch,"C:\\Users\\MasilelaNd\\Documents\\Drought Projects\\Rainfall\\Ndumiso- Rainfall Data\\In-situ\\Stellenbosch2023.xlsx")

####### Timeseries Analysis

par(mfrow = c(3,1))

Altydgedacht.ts <- ts(Altydgedacht[,-c(1,2)], start = c(1960,01), end = c(2023,05), frequency = 12)
plot.ts(Altydgedacht.ts, ylab = "Rain(mm)", xlab = "", main = "Altydgedacht.ts")


Atlantis.ts <- ts(Atlantis[,-c(1,2)], start = c(1979,10), end = c(2023,08), frequency = 12)
plot.ts(Atlantis.ts)

CapePoint.ts <- ts(`Cape Point`[,-c(1,2)], start = c(1960,01), end = c(2023,08), frequency = 12)
plot.ts(CapePoint.ts)

CapeTown.ts <- ts(`Cape Town`[,-c(1,2)], start = c(1960,01), end = c(2023,08), frequency = 12)
plot.ts(CapeTown.ts)

FishHoek.ts <- ts(`Fish Hoek`[,-c(1,2)], start = c(1987,09), end = c(2020,12), frequency = 12)
plot.ts(FishHoek.ts)

Kerenkrag.ts <-  ts(Kerenkrag[,-c(1,2)], start = c(1988,01), end = c(2023,07), frequency = 12)
plot.ts(Kerenkrag.ts)

Malmesbury.ts <-  ts(Malmesbury[,-c(1,2)], start = c(1993,03), end = c(2022,02), frequency = 12)
plot.ts(Malmesbury.ts)

Stellenbosch.ts <- ts(Stellenbosch[,-c(1,2)], start = c(1978,01), end = c(2023,08), frequency = 12)
plot.ts(Stellenbosch.ts)

Strand.ts <- ts(Strand[,-c(1,2)], start = c(1996,05), end = c(2022,03), frequency = 12)
plot.ts(Strand.ts)

###### %Missing Data Calculation


missing.values <- `Stellenbosch` %>%
  gather(key = "key", value = "val") %>%
  mutate(is.missing = is.na(val)) %>%
  group_by(key, is.missing) %>%
  summarise(num.missing = n()) %>%
  filter(is.missing==T) %>%
  select(-is.missing) %>%
  arrange(desc(num.missing))


missing.values2 <- `Strand` %>%
  gather(key = "key", value = "val") %>%
  mutate(isna = is.na(val)) %>%
  group_by(key) %>%
  mutate(total = n()) %>%
  group_by(key, total, isna) %>%
  summarise(num.isna = n()) %>%
  mutate(pct = num.isna / total * 100)



######## Standardized Precipitation Index 1-,3-month timescales 

###### Per Station 
par(mfrow = c(3,1))

Altydgedacht.spi1 <- spi(Altydgedacht.ts, 1, na.rm = T)
Altydgedacht.spi3 <- spi(Altydgedacht.ts, 3, na.rm = T)

plot.spei(Altydgedacht.spi1, ylab = "SPI",  main = "Altydgedacht (1-Month) ")
legend("topleft", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Altydgedacht.spi3,  main = "Altydgedacht (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Altydgedacht.spi1
Altydgedacht.spi3



Atlantis.spi1 <- spi(Atlantis.ts, 1, na.rm = T)
Atlantis.spi3 <- spi(Atlantis.ts, 3, na.rm = T)

plot.spei(Atlantis.spi1, ylab = "SPI",  main = "Atlantis (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Atlantis.spi3,  main = "Atlantis (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Atlantis.spi1
Atlantis.spi3



CapePoint.spi1 <- spi(CapePoint.ts, 1, na.rm = T)
CapePoint.spi3 <- spi(CapePoint.ts, 3, na.rm = T)

plot.spei(CapePoint.spi1, ylab = "SPI",  main = "Cape Point (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Atlantis.spi3,  main = "Cape Point (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

CapePoint.spi1
CapePoint.spi3


####  123

Selected_Stations[253:763,
                  ]
CapeTown.ts <- ts(Selected_Stations[,-c(1,2)], start = c(1960,01), end = c(2023,07), frequency = 12)
plot.ts(CapeTown.ts)


CapeTown.spi1 <- spi(CapeTown.ts, 1, na.rm = T)
CapeTown.spi3 <- spi(CapeTown.ts, 3, na.rm = T)

plot.spei(CapeTown.spi1, ylab = "SPI",  main = "Cape Town WO (1-Month) ")
legend("topleft", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(CapeTown.spi3,  main = "Cape Town WO (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

CapeTown.spi1
CapeTown.spi3



FishHoek.spi1 <- spi(FishHoek.ts, 1, na.rm = T)
FishHoek.spi3 <- spi(FishHoek.ts, 3, na.rm = T)

plot.spei(FishHoek.spi1, ylab = "SPI",  main = "Fish Hoek (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(FishHoek.spi3,  main = "Fish Hoek (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

FishHoek.spi1
FishHoek.spi3



Kerenkrag.spi1 <- spi(Kerenkrag.ts, 1, na.rm = T)
Kerenkrag.spi3 <- spi(Kerenkrag.ts, 3, na.rm = T)

plot.spei(Kerenkrag.spi1, ylab = "SPI",  main = "Kerenkrag (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Kerenkrag.spi3,  main = "Kerenkrag (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Kerenkrag.spi1
Kerenkrag.spi3



####123
Malmesbury.spi1 <- spi(Malmesbury.ts, 1, na.rm = T)
Malmesbury.spi3 <- spi(Malmesbury.ts, 3, na.rm = T)

plot.spei(Malmesbury.spi1, ylab = "SPI",  main = "Malmesbury (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Malmesbury.spi3,  main = "Malmesbury (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Malmesbury.spi1
Malmesbury.spi3



Stellenbosch.spi1 <- spi(Stellenbosch.ts, 1, na.rm = T)
Stellenbosch.spi3 <- spi(Stellenbosch.ts, 3, na.rm = T)

plot.spei(Stellenbosch.spi1, ylab = "SPI",  main = "Stellenbosch (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Stellenbosch.spi3,  main = "Stellenbosch (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Stellenbosch.spi1
Stellenbosch.spi3



Strand.spi1 <- spi(Strand.ts, 1, na.rm = T)
Strand.spi3 <- spi(Strand.ts, 3, na.rm = T)

plot.spei(Strand.spi1, ylab = "SPI",  main = "Strand (1-Month) ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(Strand.spi3,  main = "Strand (3-Month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 

Strand.spi1
Strand.spi3
###### Catchment Level 



G2.Catchment <- ts(Catchment_Scale[,-c(1,2)], start = c(1988,01), end = c(2020,12), frequency = 12)
plot.ts(G2.Catchment, main = "G2 Secondary Catchment Rainfall")


G2.Catchment.spi1 <- spi(G2.Catchment, 1)
G2.Catchment.spi3 <- spi(G2.Catchment, 3)

par(mfrow = c(2,1))

plot.spei(G2.Catchment.spi1, ylab = "SPI",  main = "1-Month Timescale ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                  "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(G2.Catchment.spi3,  main = "3-Month Timescale")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                  "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 



###################
#                 #
#   Ex-Situ Data  #
#                 # 
##################



####### Importing all the Data

df_list <- map(set_names(excel_sheets("Extracted/Selected_Stations.xlsx")), read_excel, path = "Extracted/Selected_Stations.xlsx", col_types = 'numeric')
list2env(df_list, envir = .GlobalEnv)


###### Summing up daily values into monthly values 

Strand <- Strand %>%
  group_by(Year, Month) %>%
  summarise(Rain = sum(`Rainfall(mm)`))


########### Exporting Monthly rainfall data 

write_xlsx(list(sheet1 = Altydgedacht, sheet2 = Atlantis, sheet3 = `Cape Point`, sheet4 = `Cape Town`, sheet5= `Fish Hoek`, sheet6 = Kerenkrag ,sheet7 = Malmesbury,
                sheet8= Stellenbosch , sheet9= Strand), "Selected Stations.xlsx")




######## Standardized Precipitation Index 1-,3-month timescales 


###### Catchment Level 



G2.Catchment <- ts(Catchment[,-c(1,2)], start = c(1988,01), end = c(2020,12), frequency = 12)
plot.ts(G2.Catchment , main = "G2 Secondary Catchment Rainfall")



G2.Catchment.spi1 <- spi(G2.Catchment, 1)
G2.Catchment.spi3 <- spi(G2.Catchment, 3)

par(mfrow = c(2,1))

plot.spei(G2.Catchment.spi1, ylab = "SPI (1-month)",  main = "Ex-Situ SPI ")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=2, pch=15) 
plot.spei(G2.Catchment.spi3,  main = "G2 Secondary Catchment (3-month)")
legend("topright", legend=c("Dry","Wet"), col=c(rgb(1,0,0,1), 
                                                "#0000EE", rgb(0.2,0.2,0.2,0.2)), pt.cex=1, pch=10) 


Transposing 

df_list <- map(set_names(excel_sheets("Drought Transposed.xlsx")), read_excel, path = "Drought Transposed.xlsx", col_types = 'numeric')
list2env(df_list, envir = .GlobalEnv)

Catchment_Insitu<- pivot_longer(`Ctachment In-Situ`, cols = -c(1), names_to = 'month', values_to = "SPI")
Catchment_Exsitu<- pivot_longer(`Catchment Ex-Situ`, cols = -c(1), names_to = 'month', values_to = "SGI")
Cape_Town_InSitu<- pivot_longer(`Cape Town In-situ`, cols = -c(1), names_to = 'month', values_to = "SGI")
Cape_Town_ExSitu<- pivot_longer(`Cape Town Ex-Situ`, cols = -c(1), names_to = 'month', values_to = "SGI")



####Exporting to excel

write_xlsx(list(sheet1 = `Catchment_Insitu`, sheet2 = `Catchment_Exsitu`, sheet3 = `Cape_Town_InSitu`, sheet4 = `Cape_Town_ExSitu`), "DTransposed.xlsx")








