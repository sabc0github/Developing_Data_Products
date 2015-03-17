# ---------------------------
# Author: Aravind Sesetty
# Course: Developing Data Products
# Assignment: Course Project
# Date: 03/16/2015
# ---------------------------

library(shiny)
library(markdown)

shinyUI(
        fluidPage(
                
                # Global Page Style Settings
                style = "padding-top: 10px; padding-bottom: 50px; font-family: times new roman;",
                
                # Menu Bar
                navbarPage(
                        
                        title = "Motor Trend Car Road Tests",
                        position = "static-top",
                        
                        # Menu-1
                        tabPanel("Data Set", 
                                 dataTableOutput("data")
                        ),
                        
                        # Menu-2
                        tabPanel("Generic Plot", 
                                 pageWithSidebar(
                                         headerPanel(""),
                                         sidebarPanel(
                                                 h1("Plot Options"),
                                                 selectInput("dataset", "Data Set", choices = "mtcars"),
                                                 selectInput("xaxis", "X - Axis", choices = names(mtcars), selected = "mpg"),
                                                 selectInput("yaxis", "Y - Axis", choices = names(mtcars), selected = "wt"),
                                                 selectInput("colorby", "Color By", choices = names(mtcars), selected = "cyl"),
                                                 radioButtons("plottype", 
                                                              label = ("Select Plot Type"),
                                                              choices = list(
                                                                      "Line" = "line",
                                                                      "Point" = "point"
                                                              ),
                                                              selected = "line"
                                                 ),
                                                 actionButton("goButton", "Generate Plot")
                                         ),
                                         mainPanel(
                                                 h1("Generic Plot for mtcars dataset"),
                                                 em(h5("User can compare 3 parameters of mtcars dataset")),
                                                 plotOutput("genericplot", width = 600, height = 500)
                                         )
                                 )
                        ),
                        
                        # Menu-3
                        tabPanel("Statistical Inference",
                                 pageWithSidebar(
                                         headerPanel("Welch Two Sample t-test"),
                                         sidebarPanel(
                                                 sliderInput("conflevel", label = "Confidence Level of the Interval", min = 0, max = 1, value = .05)
                                         ),
                                         mainPanel(
                                                 htmlOutput("ttest")
                                         )
                                 )
                        ),
                        
                        # Menu-4
                        tabPanel("Regression Models",
                                 pageWithSidebar(
                                         headerPanel(""),
                                         sidebarPanel(
                                                 h1("Plot Options"),
                                                 selectInput("dataset", "Data Set", choices = "mtcars"),
                                                 selectInput("outcome", "Outcome", choices = names(mtcars) ),
                                                 checkboxGroupInput("predictors", 
                                                                    label = ("Predictors"),
                                                                    choices = list(
                                                                            "mpg" = "mpg",
                                                                            "cyl" = "cyl",
                                                                            "disp" = "disp",
                                                                            "hp" = "hp",
                                                                            "drat" = "drat",
                                                                            "wt" = "wt",
                                                                            "qsec" = "qsec",
                                                                            "vs" = "vs",
                                                                            "am" = "am",
                                                                            "gear" = "gear",
                                                                            "carb" = "carb"
                                                                    )
                                                 )
                                         ),
                                         mainPanel(
                                                 h1("Fitting Linear Models"),
                                                 tableOutput("lmfit")
                                         )
                                 )
                        ),
                        
                        # Menu-5
                        navbarMenu("Help",
                                   tabPanel("About the Data",
                                            p(h1("Motor Trend Car Road Tests")),
                                            p(strong(h5("Description"))),
                                            helpText(
                                                    "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."
                                            ),
                                            
                                            p(strong(h5("Usage"))),
                                            helpText(
                                                    "mtcars"
                                            ),
                                            
                                            p(strong(h5("Format"))),
                                            helpText(
                                                    "A data frame with 32 observations on 11 variables.", br(),
                                                    br(),
                                                    "[, 1] mpg  - Miles/(US) gallon", br(),
                                                    "[, 2] cyl  - Number of cylinders", br(),
                                                    "[, 3] disp - Displacement (cu.in.)", br(),
                                                    "[, 4] hp   - Gross horsepower", br(),
                                                    "[, 5] drat - Rear axle ratio", br(),
                                                    "[, 6] wt   - Weight (lb/1000)", br(),
                                                    "[, 7] qsec - 1/4 mile time", br(),
                                                    "[, 8] vs   - V/S", br(),
                                                    "[, 9] am   - Transmission (0 = automatic, 1 = manual)", br(),
                                                    "[, 10] gear - Number of forward gears", br(),
                                                    "[, 11] carb - Number of carburetors", br()
                                            ),
                                            
                                            p(strong(h5("Source"))),
                                            helpText(
                                                    "Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391-411."
                                            )
                                   ),
                                   tabPanel("App Documentation",
                                            navlistPanel(
                                                    "Tabel of Contents",
                                                    tabPanel("App Summary",
                                                             h1("Shiny App Summary"),
                                                             p("This Shiny Application is developed as part of", strong("Developing Data Products"), em(" - Course Project.")),
                                                             br(),
                                                             p("The Evaluation criteria for this application is as below..."),
                                                             p("1. Was there enough documentation on the shiny site for a user to get started using the application?"),
                                                             p("2. Did the application run as described in the documentation?"),
                                                             p("3. Was there some form of widget input (slider, textbox, radio buttons, checkbox, ...) in either ui.R or a custom web page?"),
                                                             p("4. Did server.R perform some calculations on the input in server.R?"),
                                                             p("5. Was the server calculation displayed in the html page?"),
                                                             p("6. Was the app substantively different than the very simple applications built in the class?", br(), "Note, it's OK if the app is simple and based on the one presented in class, I just don't want it to be basically a carbon copy of the examples we covered.", br(), "As an example, if someone simply changed the variable names, then this would not count. However, a prediction algorithm that had a similar layout would be fine")
                                                    ),                                                    
                                                    tabPanel("Data Set",
                                                             h1("mtcars Data Set"),
                                                             p("On this page we try to summarize the data"),
                                                             p("User has option to select number of rows to be displayed on the screen"),
                                                             p("User can search for a specific word, so that the relevent rows are displayed on the screen"),
                                                             p("User can sort all the columns Ascending or Descending order by clicking on the Headers"),
                                                             p("User can filter the data based on the columns so that the relevent rows are displayed on the screen"),
                                                             p("In case the data overflows the screen, User has pagination option to select")
                                                    ),
                                                    tabPanel("Generic Plot",
                                                             h1("Plot"),
                                                             p("User can generate a Plot based on any 3 column data"),
                                                             p("User can choose a column for X-axis, it is defaulted to 'mpg'"),
                                                             p("User can choose a column for Y-axis, it is defaulted to 'wt'"),
                                                             p("User can choose a column for Color By, it is defaulted to 'cyl'"),
                                                             p("User can choose between a Line or Point Plot"),
                                                             p("On click of 'Generate Plot' button the Plot will be generated")
                                                    ),
                                                    tabPanel("Statistical Inference",
                                                             h1("Welch Two Sample t-test"),
                                                             p("We performe t-test on mpg and am"),
                                                             p("t, df, p-value and sample estimates are displayed as a result"),
                                                             p("User can change the Confidence Level of the Interval")
                                                    ),
                                                    tabPanel("Regression Models",
                                                             h1("Linear Model Fit"),
                                                             p("User can select a Outcome"),
                                                             p("User can select one or more Predictors"),
                                                             p("App will automatically calculate the lm fit and will generate the Intercept and slope values")
                                                    ),
                                                    tabPanel("Help - About the Data",
                                                             h1("Motor Trend Car Road Tests"),
                                                             p("This is a help page for mtcars dataset")
                                                    ),
                                                    tabPanel("Help - App Documentation",
                                                             h3("Source Code URLs"),
                                                             p("https://github.com/sabc0github/Developing_Data_Products"),
                                                             p("ui.R"),
                                                             p("server.R")
                                                    )
                                            )
                                   )
                        )
                ),
                
                # Footer with Data & Time Stamp
                absolutePanel(
                        bottom = 0, 
                        left = 0, 
                        right = 0,
                        fixed = TRUE,
                        div(
                                style="padding: 8px; background: #575757; position:relative; z-index:10; text-align:right; color:white;",
                                textOutput("currentTime")
                        )
                )
        ) # end of fluidPage
) # end of shinyUI
