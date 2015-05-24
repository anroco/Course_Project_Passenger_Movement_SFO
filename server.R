source("helpers.R")
library(ggplot2)

shinyServer(function(input, output, session) {
    
    #load the data using the defined filter
    loadData <- reactive({
        filterByPeriod(SFO_data, input$period[1], input$period[2], input$region, 
                       input$action_type, input$terminal)
    })
    
    #render plot Period Vs Passengers
    output$plotPeriodVsPassenger <- renderPlot({
        data <- loadData()
        ggplot(group_by_fields(data, c("Activity.Period")), 
               aes(Activity.Period, Passenger.Count/1000)) + 
            geom_bar(stat="identity") + 
            scale_x_date(labels = date_format("%b-%Y")) + 
            labs(x = "Period of activity", y = "Passenger numbers (in thousands)")
    })
    
    #render plot Period Vs Region
    output$plotPeriodVsRegion <- renderPlot({
        data <- loadData()
        ggplot(group_by_fields(data, c("Activity.Period", "GEO.Region")), 
               aes(Activity.Period, Passenger.Count/1000, 
                   group=GEO.Region, colour=GEO.Region)) +
            geom_line() + geom_point() + 
            scale_x_date(labels = date_format("%b-%Y")) + 
            labs(x = "Period of activity", y = "Passenger numbers (in thousands)")
    })
    
    #render plot Period Vs Action Type
    output$plotPeriodVsActionType <- renderPlot({
        data <- loadData()
        ggplot(group_by_fields(data, c("Activity.Period", "Activity.Type.Code")), 
               aes(Activity.Period, Passenger.Count/1000, 
                   fill = Activity.Type.Code)) +
            geom_bar(stat="identity") + 
            scale_x_date(labels = date_format("%b-%Y")) + 
            labs(x = "Period of activity", y = "Passenger numbers (in thousands)")
    })
    
    #render plot Period Vs Terminal
    output$plotPeriodVsTerminal <- renderPlot({
        data <- loadData()
        ggplot(group_by_fields(data, c("Activity.Period", "Terminal")), 
               aes(Activity.Period, Passenger.Count/1000, 
                   group=Terminal, colour=Terminal)) +
            geom_line() + geom_point() + 
            scale_x_date(labels = date_format("%b-%Y")) + 
            labs(x = "Period of activity", y = "Passenger numbers (in thousands)")
    })
})