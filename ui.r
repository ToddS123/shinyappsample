library(shiny)

#Step 1##################################
#Set up the shiny web page
shinyUI(pageWithSidebar(
  
  
#Step 2 #################################
  # Title of the Page
  headerPanel("Assess Miles per Gallon based on car features"),
  
#Step 3 #################################
  # Sidebar to include the following elements for comparing MPG
  # Variable to compare to mpg - cylinder, transmission or gear
  # color of the box plot
  # visual style of the boxplot
  # direction of the boxplot
  # Outliers in the data - include or not include
  # slider control to set font size of x axis label

  sidebarPanel(
    selectInput("variable", "Variable:",
                list("Cylinders" = "cyl", 
                     "Transmission" = "am", 
                     "Gears" = "gear")),
    
    selectInput("variable2", "Color:",
                list("Red" = "red", 
                     "Green" = "green", 
                     "Blue" = "blue")),
    
    checkboxInput("NotchStyle", "Show as notch look", FALSE),
    
    checkboxInput("HorizontalStyle", "Show chart Horizontal", FALSE),
    
    checkboxInput("outliers", "Show outliers", FALSE),
    
    sliderInput("obs", 
                "Label Font Size:", 
                min = 1,
                max = 5, 
                value = 2)
  ),
  

#Step 4##############################################################
  # Show the caption, plot and mean comparison summary of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("mpgPlot"),
    
    tableOutput("view")
  )
))