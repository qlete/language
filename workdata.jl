using PyPlot

tot = [268110961, 285797349, 296358760, 303328961]
only_english = [80.6, 80, 79.2, 78.4]
not_well = [44.6, 43.1, 40.7, 39.8]
well = 100-not_well
years = [2005, 2009, 2013, 2016]
plot(years, only_english)
plot(years, not_well)
plot(years, well)
show()
