library(shiny)
library(plotly)
library(ggplot2)
library(shinythemes)

options(shiny.host = "0.0.0.0")
options(shiny.port = 5000)

ui <- fluidPage(
  includeCSS("https://fonts.googleapis.com/css2?family=Raleway:wght@400&display=swap"),
  includeCSS("www/custom.css"),
  theme = shinytheme("darkly"),
  headerPanel("Plotting MT Cars data using plotly"),
  sidebarPanel(
    selectInput("xcol", "X Variable",
      names(mtcars),
      selected = names(mtcars)[[1]]
    ),
    selectInput("ycol", "Y Variable",
      names(mtcars),
      selected = names(mtcars)[[3]]
    ),
    selectInput("color", "Color", names(mtcars), selected = names(mtcars)[[2]])
  ),
  mainPanel(
    plotlyOutput("plot")
  ),
  div(
    class = "footer",
    includeHTML("www/footer.html")
  )
)

server <- function(input, output) {
  x <- reactive({
    mtcars[, input$xcol]
  })

  y <- reactive({
    mtcars[, input$ycol]
  })

  color <- reactive({
    mtcars[, input$color]
  })


  output$plot <- renderPlotly(
    plot1 <- plot_ly(
      x = x(),
      y = y(),
      color = color(),
      text = color(),
      type = "scatter",
      mode = "markers",
      colors = c("#fcdd14", "#ffffff", "#8f0fd4"),
      size = I(60),
      hovertemplate = paste(
        "<br><b>X</b>: %{x}",
        "<br><b>Y</b>: %{y}",
        "<br><b>Color</b>:",
        "<b>%{text}</b><extra></extra>"
      )
    )
    %>% layout(
        paper_bgcolor = "#303030",
        plot_bgcolor = "#303030",
        xaxis = list(
          color = "#ffffff"
        ),
        yaxis = list(
          color = "#ffffff"
        ),
        font = list(color = "#ffffff")
      )
  )
}

shinyApp(ui, server)
