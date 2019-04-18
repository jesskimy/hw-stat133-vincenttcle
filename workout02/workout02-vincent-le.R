#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(scales)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Comparing Various Investing Scenarios"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(
      column(4,
         sliderInput("initial_amount",
                     "Initial amount",
                     min = 1,
                     max = 100000,
                     value = 1000,
                     pre = "$",
                     sep = ",",
                     step = 500
                     ),
         sliderInput("annual_contrib",
                     "Annual Contribution",
                     min = 0,
                     max = 50000,
                     value = 2000,
                     pre = "$",
                     sep = ",",
                     step = 500)),
      column(4,
         sliderInput("return_rate",
                     "Return Rate (in %)",
                     min = 0,
                     max = 20, 
                     value = 5,
                     step = 0.1),
         sliderInput("growth_rate",
                     "Growth Rate (in %)",
                     min = 0,
                     max = 20, 
                     value = 2,
                     step = 0.1
                     )),
      column(4,
      
         sliderInput("years",
                     "Years",
                     min = 0,
                     max = 50, 
                     value = 20,
                     step = 1),
         selectInput("facet",
                     "Facet?",
                     choices = c("No", "Yes")
         )
      )),
      hr(),
      # Show a plot of the generated distribution
      h4("Timelines"),
         plotOutput("investPlot"),
   h4("Balances"),
          verbatimTextOutput("investtable", placeholder = TRUE)
      
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$investPlot <- renderPlot({
     ########## Making Necessary Functions
     
     #'@Title Future Value
     #'@Description Using a simplified version of the Future Value formula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, and the number of years
     #'@param amount a numeric value that represents the intitial invested amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     future_value <- function(amount = 0, rate = 0, years = 1){
       f <- amount*((1+rate)^years)
       return(f)
     }
     
     #'@Title Annuity
     #'@Description Using a simplified version of the Future Value of Annuity forumula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, and the number of years. Note that an additinoal fixed amount is getting invested each year.
     #'@param contrib a numeric value that represents the intitial invested amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value of annuity; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     annuity <- function(contrib = 0, rate = 0.05, years = 0){
       f <- contrib*((((1+rate)^years)-1)/rate)
       return(f)
     }
     
     #'@Title Annuity
     #'@Description Using a simplified version ofo the Future Value of Annuity forumula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, the annual growth rate, and the number of years. Note that an additional amount that is increasing by 3% each year is being invested each year.
     #'@param contrib a numeric value that represents the intitial contributed amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param growth a numeric value that represents the annual growth rate
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value of annuity; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     growing_annuity <- function(contrib = 0, rate = 0.05, growth = 0, years = 0){
       f <- contrib*(((1+rate)^years)-((1+growth)^years))/(rate-growth)
       return(f)
     }
     
     ########## For Loops
     year <- seq(0,input$years,1)
     
     #Mode 1: no contribution
     no_contrib <- c()
     for (i in year){
       x <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100))
       no_contrib[i+1] <- x
     }
     
     #Mode 2: fixed contribution
     fixed_contrib <- c()
     for (i in year){
       y <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100)) + annuity(contrib = input$annual_contrib, rate = (input$return_rate/100), year = i)
       fixed_contrib[i+1] <- y
     }
     
     #Mode 3: growing contribution
     growing_contrib <- c()
     for (i in year){
       z <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100)) + growing_annuity(contrib = input$annual_contrib, growth = (input$growth_rate/100), years = i, rate = (input$return_rate/100))
       growing_contrib[i+1] <- z
     }
     
     ########## Combining into a table
     #if no facet
     modalities <- data.frame(year, no_contrib, fixed_contrib, growing_contrib)
     
     #if yes facet
     dfno_contrib <- as.data.frame(no_contrib)
     dfno_contrib$type <- "no_contrib"
     dfno_contrib$year <- seq(0,input$years,1)
     names(dfno_contrib)[1] <- c("amount")
     
     dffixed_contrib <- as.data.frame(fixed_contrib)
     dffixed_contrib$type <- "fixed_contrib"
     dffixed_contrib$year <- seq(0,input$years,1)
     names(dffixed_contrib)[1] <- c("amount")
     
     dfgrowing_contrib <- as.data.frame(growing_contrib)
     dfgrowing_contrib$type <- "growing_contrib"
     dfgrowing_contrib$year <- seq(0,input$years,1)
     names(dfgrowing_contrib)[1] <- c("amount")
     
     modalities_facetyes <- rbind(dfno_contrib, dffixed_contrib, dfgrowing_contrib)
     modalities_facetyes$type <- factor(modalities_facetyes$type)
     modalities_facetyes$type <- factor(modalities_facetyes$type, c("no_contrib", "fixed_contrib", "growing_contrib"))
     
      
     ########## Plotting
     
     
    if (input$facet == "No"){
     ggplot(data = modalities, aes(x = year)) +
       geom_point(aes(y = no_contrib, color = "no contribution")) + 
       geom_line(aes(y = no_contrib, color = "no contribution")) +
       geom_point(aes(y = fixed_contrib, color = "fixed contribution")) +
       geom_line(aes(y = fixed_contrib, color = "fixed contribution")) +
       geom_point(aes(y = growing_contrib, color = "growing contribution")) +
       geom_line(aes(y = growing_contrib, color = "growing contribution")) +
       scale_y_continuous(labels = comma) +
        theme_bw() +
       labs(x = "Years Invested", y = "Balance in Dollars", title = "Three Modes of Investing") +
       scale_color_manual(values=c("no contribution" = "red","fixed contribution" = "#67C043","growing contribution"="blue"), name = "Variable",breaks=c("growing contribution","fixed contribution","no contribution")) 
    }else{
      ggplot(modalities_facetyes, aes(x = year)) +
        geom_point(aes(y = amount, col = type)) +
        geom_line(aes(y = amount, col = type)) +
        geom_area(aes(y = amount, col = type, fill = type), alpha = 0.5) +
        theme_bw() +
        scale_y_continuous(labels = comma) +
        labs(x = "Years Invested", y = "Balance in Dollars", title = "Three Modes of Investing") +
        facet_wrap(~type)
    }
   })
   output$investtable <- renderPrint({
     ########## Making Necessary Functions
     
     #'@Title Future Value
     #'@Description Using a simplified version of the Future Value formula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, and the number of years
     #'@param amount a numeric value that represents the intitial invested amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     future_value <- function(amount = 0, rate = 0, years = 1){
       f <- amount*((1+rate)^years)
       return(f)
     }
     
     #'@Title Annuity
     #'@Description Using a simplified version of the Future Value of Annuity forumula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, and the number of years. Note that an additinoal fixed amount is getting invested each year.
     #'@param contrib a numeric value that represents the intitial invested amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value of annuity; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     annuity <- function(contrib = 0, rate = 0.05, years = 0){
       f <- contrib*((((1+rate)^years)-1)/rate)
       return(f)
     }
     
     #'@Title Annuity
     #'@Description Using a simplified version ofo the Future Value of Annuity forumula, this function computes the future value of annuity given the intitial contributed amount, the interest rate, the annual growth rate, and the number of years. Note that an additional amount that is increasing by 3% each year is being invested each year.
     #'@param contrib a numeric value that represents the intitial contributed amount
     #'@param rate a numeric value that represents the annual rate of return
     #'@param growth a numeric value that represents the annual growth rate
     #'@param years a numeric value that represents the number of years invested
     #'@return This returns the future value of annuity; ie. the amount that an individual will get if they invest a certain amount for a number of years with a certain interest rate.
     
     growing_annuity <- function(contrib = 0, rate = 0.05, growth = 0, years = 0){
       f <- contrib*(((1+rate)^years)-((1+growth)^years))/(rate-growth)
       return(f)
     }
     
     ########## For Loops
     year <- seq(0,input$years,1)
     
     #Mode 1: no contribution
     no_contrib <- c()
     for (i in year){
       x <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100))
       no_contrib[i+1] <- x
     }
     
     #Mode 2: fixed contribution
     fixed_contrib <- c()
     for (i in year){
       y <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100)) + annuity(contrib = input$annual_contrib, rate = (input$return_rate/100), year = i)
       fixed_contrib[i+1] <- y
     }
     
     #Mode 3: growing contribution
     growing_contrib <- c()
     for (i in year){
       z <- future_value(amount = input$initial_amount, years = i, rate = (input$return_rate/100)) + growing_annuity(contrib = input$annual_contrib, growth = (input$growth_rate/100), years = i, rate = (input$return_rate/100))
       growing_contrib[i+1] <- z
     }
     
     ########## Combining into a table
     modalities <- data.frame(year, no_contrib, fixed_contrib, growing_contrib)
     
     
     head(modalities, input$years)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

