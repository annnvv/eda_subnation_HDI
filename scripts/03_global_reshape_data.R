  # read in the globalambique National and Subnational HDI data from 1990 to 2017
  global <- read.csv(paste0(proj_path, "/data/GDL-national-HDI-data.csv"))
  head(global)  
  
  # add an y_ to year vars
  names(global) <- gsub("^X", "y_", names(global))  
  
  # can remove unnecessary columns
  global <- global[ c(1,2,6:length(global))]
  names(global)
  
  # left merge in regions by ISO3 code
  iso3_regions <- read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")
  iso3_regions <- iso3_regions[ , c(3,6)]
  names(iso3_regions)[1] <- "ISO_Code"
  
  global <- merge(global, iso3_regions, by = "ISO_Code", all.x = TRUE, all.y = FALSE)
  
  global <- global[ ,c(1,2,length(global), 3:30)]
  
  global$region[global$Country == "Kosovo"] <- "Europe"
  
  #need to reshape the data to be long instead of wide!
  global_long <- reshape(global, 
                      varying = c(names(global)[4:31]), 
                      v.names = "HDI",
                      timevar = "year", 
                      times = c(names(global)[4:31]), 
                      new.row.names = 1:4508,
                      direction = "long")
  
  #review the structure of reshaped dataframe
  str(global_long)
  
  # replace Total with Country (to indicate the country HDI score)
  global_long$Country <- as.character(global_long$Country)
  global_long$ISO_Code <- as.character(global_long$ISO_Code)
  
  # remove y_ from year and make numeric
  global_long$year <- as.character(global_long$year)
  global_long$year <- as.numeric(gsub("y_", "", global_long$year))
  
  # save cleaned data
  write.csv(global_long, paste0(proj_path, "/data/global_long_HDI.csv"), 
            row.names = FALSE)
  