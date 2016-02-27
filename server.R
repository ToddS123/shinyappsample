library(shiny)
library(datasets)
library(plyr)

#SERVER###################

#Step 1 ##################
#Reference R Dataset mtcars
mpgData <- mtcars
#Convert the transmission variable to a factor and create more user friendly labels
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))


#Step 2 ################
# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  

#Step 3 #################
  # Return the formula text for printing as a caption which will include mpg and the variable selected to be comparted to mpg
  output$caption <- renderText({
    formulaText()
  })
  

#Step 4 #################
  # Generate a plot of the requested variable against mpg
  # Set boxplot parameters including: color, outlier setting, x axis labels, motch style and label font

  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            outline = input$outliers,
            col = input$variable2,
            notch=input$NotchStyle,
            horizontal=input$HorizontalStyle,
            xlab = input$variable,
            cex.lab=input$obs)
           
  })
  
  # Generate summary of the MPG mean value compared to the selected variable to compare to the mpg
  output$view <- renderTable({
    aggregate(as.formula(formulaText()), mpgData,mean)
  })
  
  

  
})