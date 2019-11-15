  library(ggplot2)
  library(gghighlight)
  
  # read in cleaned data
  national_long <- read.csv(paste0(proj_path, "/data/national_long_HDI.csv"), 
                          stringsAsFactors = FALSE)
  national_long <- na.omit(national_long)

  #af <- national_long[national_long$region == "Africa", ]
  
  # plot the data
  ggplot(national_long) + 
    geom_line(aes(year, HDI, colour = Country)) +
    ylim(0, 1) +
    ylab("Human Development Index") +
    scale_x_continuous(name="Year", breaks=seq(1990, 2017,5)) +
    labs(title = "National HDI (1990-2017)",
    #      subtitle = "Maputo City and Province have the highest HDI of Mozambique's Provinces", 
         caption = "Source: https://globaldatalab.org/shdi") +
    theme_minimal() + 
    gghighlight(max_highlight = 3, use_direct_label = TRUE) +
    facet_wrap(~ region, drop = TRUE)

  ggsave(paste0(proj_path, "/static/national_HDI.png"))
  