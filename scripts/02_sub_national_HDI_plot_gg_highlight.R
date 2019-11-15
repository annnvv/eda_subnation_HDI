  library(ggplot2)
  library(gghighlight)
  
  # read in cleaned data
  moz <- read.csv(paste0(proj_path, "/data/GDL-Sub-national-HDI-data.csv"))

 # plot the data
  ggplot() +
    geom_line(aes(year, HDI, colour = Region) , data = moz_long[moz_long$Region != "Country", ]) +
    ylim(0, 0.7) +
    ylab("Human Development Index") +
    scale_x_continuous(name="Year", breaks=seq(1990, 2017,5)) +
    labs(title = "Mozambique: National and Subnational HDI (1990-2017)", 
         subtitle = "Maputo City and Province have the highest HDI of Mozambique's Provinces", 
         caption = "Source: https://globaldatalab.org/shdi/shdi") +
    theme_minimal() + 
    gghighlight(max(HDI)>0.5, use_direct_label = TRUE) +
    geom_line(aes(year, HDI) , data = moz_long[moz_long$Region == "Country", ], colour = "black", size = 0.75) +
    annotate("text", x = 2011.5, y = 0.02, label = "Note: National HDI is in bolded black")
  
  ggsave(paste0(proj_path, "/static/MOZ_HDI.png"))
  
  # need to fix the fact that labels cover last few years of data when use_direct_label = TRUE