library(gplots)
library(RColorBrewer)

#########################################################
### reading in data and transform it to matrix format
#########################################################

data <- read.csv("dataset.csv", comment.char="#")
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[,2:ncol(data)])  # transform column 2-5 into a matrix
rownames(mat_data) <- rnames                  # assign row names



#########################################################
### customizing and plotting heatmap
#########################################################

# creates a own color palette from red to green
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 299)

# creates a 5 x 5 inch image
png("h3_categorizing.png",
  width = 5*300,        # 5 x 300 pixels
  height = 5*300,
  res = 300,            # 300 pixels per inch
  pointsize = 8)        # smaller font size

heatmap.2(mat_data,
  cellnote = mat_data,  # same data set for cell labels
  RowSideColors = c(    # grouping row-variables into different
     rep("gray", 3),   # categories, Measurement 1-3: green
     rep("blue", 3),    # Measurement 4-6: blue
     rep("black", 4)),    # Measurement 7-10: red
  main = "Categories",  # heat map title
  notecol="black",      # change font color of cell labels to black
  density.info="none",  # turns off density plot inside color legend
  trace="none",         # turns off trace lines inside the heat map
  margins =c(12,9),     # widens margins around plot
  col=my_palette,       # use on color palette defined earlier 
  dendrogram="row",     # only draw a row dendrogram
  Colv="NA")            # turn off column clustering

# adding a color legend for the categories
par(lend = 1)           # square line ends  for the color legend
legend("topright",      # location of the legend on the heatmap plot
    legend = c("category1", "category2", "category3"), # category labels
    col = c("gray", "blue", "black"),  # color key
    lty = 1,            # line style
    lwd = 10,           # line width
   )

dev.off()
