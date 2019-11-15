  # read in the globalambique National and Subnational HDI data from 1990 to 2017
  global <- read.csv(paste0(proj_path, "/data/GDL-national-HDI-data.csv"))
  head(global)  
  
  # add an y_ to year vars
  names(global) <- gsub("^X", "y_", names(global))  
  
  # can remove unnecessary columns
  global <- global[ c(1,2,6:length(global))]
  names(global)
  
  #need to reshape the data to be long instead of wide!
  global_long <- reshape(global, 
                      varying = c(names(global)[3:30]), 
                      v.names = "HDI",
                      timevar = "year", 
                      times = c(names(global)[3:30]), 
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
  write.csv(global_long, paste0(proj_path, "/data/global_long_HDI.csv"), row.names = FALSE)
  