  # read in the nationalambique National and Subnational HDI data from 1990 to 2017
  national <- read.csv(paste0(proj_path, "/data/GDL-national-HDI-data.csv"))
  head(national)  
  
  # add an y_ to year vars
  names(national) <- gsub("^X", "y_", names(national))  
  
  # can remove unnecessary columns
  national <- national[ c(1,2,6:length(national))]
  names(national)
  
  # left merge in regions by ISO3 code
  iso3_regions <- read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv")
  iso3_regions <- iso3_regions[ , c(3,6)]
  names(iso3_regions)[1] <- "ISO_Code"
  
  national <- merge(national, iso3_regions, by = "ISO_Code", all.x = TRUE, all.y = FALSE)
  
  national <- national[ ,c(1,2,length(national), 3:30)]
  
  national$region[national$Country == "Kosovo"] <- "Europe"
  
  #need to reshape the data to be long instead of wide!
  national_long <- reshape(national, 
                      varying = c(names(national)[4:31]), 
                      v.names = "HDI",
                      timevar = "year", 
                      times = c(names(national)[4:31]), 
                      new.row.names = 1:4508,
                      direction = "long")
  
  #review the structure of reshaped dataframe
  str(national_long)
  
  # replace Total with Country (to indicate the country HDI score)
  national_long$Country <- as.character(national_long$Country)
  national_long$ISO_Code <- as.character(national_long$ISO_Code)
  
  # remove y_ from year and make numeric
  national_long$year <- as.character(national_long$year)
  national_long$year <- as.numeric(gsub("y_", "", national_long$year))
  
  # save cleaned data
  write.csv(national_long, paste0(proj_path, "/data/national_long_HDI.csv"), 
            row.names = FALSE)
  