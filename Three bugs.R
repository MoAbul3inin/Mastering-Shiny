library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")

ui <- fluidPage(
  selectInput("dataset", "Dataset", choices = datasets),
  verbatimTextOutput("summary"),
  plotOutput("plot")  # instead of tableOutput ✅ Bug 1 fixed
)

server <- function(input, output, session) {
  dataset <- reactive({
    as.data.frame(get(input$dataset, "package:ggplot2"))  # adding as.data.frame ✅ Bug 3 fixed
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  
  output$plot <- renderPlot({
    plot(dataset())  # $plot instead of $summary  ✅ Bug 2 fixed
  }, res = 96)
}

shinyApp(ui, server)
