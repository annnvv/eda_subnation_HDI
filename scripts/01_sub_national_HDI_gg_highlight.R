  # read in the Mozambique National and Subnational HDI data from 1990 to 2017
  moz <- read.csv(paste0(proj_path, "/data/GDL-Sub-national-HDI-data.csv"))
  head(moz)  

  # add an y_ to year vars
  names(moz) <- gsub("^X", "y_", names(moz))  
  
  # can remove unnecessary columns
  moz <- moz[ c(5:length(moz))]
  names(moz)

  #need to reshape the data to be long instead of wide!
  moz_long <- reshape(moz, 
                           varying = c(names(moz)[2:29]), 
                           v.names = "HDI",
                           timevar = "year", 
                           times = c(names(moz)[2:29]), 
                           new.row.names = 1:336,
                           direction = "long")
  
  #review the structure of reshaped dataframe
  str(moz_long)
  
  # replace Total with Country (to indicate the country HDI score)
  moz_long$Region <- as.character(moz_long$Region)
  moz_long$Region[moz_long$Region == "Total"] <- "Country"
  
  # remove y_ from year and make numeric
  moz_long$year <- as.character(moz_long$year)
  moz_long$year <- as.numeric(gsub("y_", "", moz_long$year))

  # save cleaned data
  write.csv(moz_long, paste0(getwd(), "/data/moz_long_HDI.csv"), row.names = FALSE)