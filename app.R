library(shiny)
library(tidyverse)
library(shinyWidgets)
library(dslabs)
library(plotly)

#Load data
data("us_contagious_diseases")
disease_data <- us_contagious_diseases %>% 
  mutate(percapita = count/(population/1000000)) %>% 
  pivot_longer(cols = c(count, percapita), 
               names_to = "data", values_to = "value")
# Custom theme
my_theme <- theme_bw() +
  theme(
    plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
    axis.title = element_text(size = 16, face = "bold"),
    axis.text = element_text(size = 14),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12),
    panel.grid = element_blank()
  )

# User interface 
ui <- fluidPage(
  titlePanel("US Contagious Diseases (1928-2011)"),
  tabsetPanel(
    tabPanel("Visualization",
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("stateInput", "Select a state:",
                                choices = unique(disease_data$state),  
                                selected = "Illinois", multiple = FALSE), 
                 checkboxGroupInput("diseaseInput", "Select diseases:",
                                    choices = c("Hepatitis A",
                                                "Measles",
                                                "Mumps", "Pertussis",
                                                "Polio", "Rubella", 
                                                "Smallpox"),
                                    selected = c("Smallpox", "Polio")),
                 sliderInput("yearInput", "Select years:", min = 1928, max = 2011, 
                             value = c(1928, 2011), sep = "")
               ),  
               mainPanel(
                 plotOutput("diseaseplot"),
                 br(), br(),
                 verbatimTextOutput("stats")
               ) 
             )
    ),
    tabPanel("Insights",
             fluidRow(
               column(width = 12,
                      h2("Core Concepts and Insights"),
                      p("The visualization communicates the number of cases of contagious diseases in the US between 1928 and 2011, broken down by state, disease, and time. The core insight is that some diseases, such as smallpox and polio, were widespread in the US in the early part of the period but were largely eradicated due to vaccination campaigns. Other diseases, such as pertussis and measles, have seen occasional spikes in cases over the years. The app allows users to select specific states, diseases, and years of interest, which helps them explore patterns and trends in the data.The app uses several widgets to allow users to explore the data in different ways. The selectizeInput widget allows users to choose a specific state, while the checkboxGroupInput widget lets them select one or more diseases of interest. The sliderInput widget enables users to choose a range of years to display. The plotOutput widget displays a line plot of the selected data, while the verbatimTextOutput widget shows the aggregate number of cases for each selected disease.

Overall, the app helps users understand how the incidence of different contagious diseases has changed over time in the US, and how those changes have varied by state and disease. By allowing users to interact with the data in various ways, the app can help them identify patterns and trends that might not be immediately apparent from the raw data.")
               )
             )
    )
  )
)   

# Server logic
# Server logic
server <- function(input, output) {
  selected_disease_data <- reactive({
    disease_data %>%
      filter(state == input$stateInput,
             disease %in% input$diseaseInput,
             year >= input$yearInput[1],
             year <= input$yearInput[2])
  }) 
  
  output$diseaseplot <- renderPlot({
    ggplot(selected_disease_data(), aes(x = year, y = value, color = disease)) +
      geom_line() + 
      my_theme +
      xlab("Year") +
      ylab("Cases") +
      ggtitle(paste("Number of Cases", "over Time", "\n", input$stateInput))
  
  })
  
  output$stats <- renderPrint({
    aggregate(value ~ disease, data = selected_disease_data(), sum)
  })
  
}

# Run app
shinyApp(ui = ui, server = server)
