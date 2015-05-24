source("helpers.R")
require(markdown)

shinyUI(
    navbarPage("Passenger movement in the San Francisco 
                International Airport (SFO)",
    tabPanel("App",
    sidebarPanel(
        
        #define the period of activity of passenger
        dateRangeInput("period", "Date range:",
                       start = "2008-07-01",
                       end = "2010-07-01", 
                       min = "2005-07-01", 
                       max = "2015-03-31", 
                       format = "yyyy-M", 
                       startview = "year"),
        helpText("Note: define the period of time at which passenger activity 
                 took place in the airport. The Activity Period is always 
                 defined in years and months, so when you select a specific 
                 day of the month is taken into account only the month and day 
                 is omitted."),
        
        #select the region of which arrive or depart of the flight
        checkboxGroupInput('region', 'Region:',
                           levels(SFO_data$GEO.Region),
                           selected = levels(SFO_data$GEO.Region)),
        helpText("Note: define the region in the world where activity in 
                 relation to SFO arrive from or depart to without stops."),
        
        #select the action a passenger took in relation to a flight
        checkboxGroupInput('action_type', 'Action of the passenger:',
                           levels(SFO_data$Activity.Type.Code),
                           selected = levels(SFO_data$Activity.Type.Code)),
        helpText("Note: A description of the physical action a passenger took
                 in relation to a flight, which includes boarding a flight
                 (“enplanements”), getting off a flight (“deplanements”) and 
                 transiting to another location (“in‐transit”)."),
        
        #select the airport terminal where passenger activity took place.
        checkboxGroupInput('terminal', 'Airport terminal:',
                           levels(SFO_data$Terminal),
                           selected = levels(SFO_data$Terminal)),
        helpText("Note: The airport terminal designations at SFO where passenger
                 activity took place.")
    ),
    mainPanel(
        h4('Total passenger traffic in time', align = "center"),
        plotOutput('plotPeriodVsPassenger'),
        h4('Distribution of passengers according to flight region', align = "center"),
        plotOutput('plotPeriodVsRegion'),
        h4('Action a passenger took in relation to a flight', align = "center"),
        plotOutput('plotPeriodVsActionType'),
        h4('Movement of passengers in the different airport terminals', align = "center"),
        plotOutput('plotPeriodVsTerminal')
    )),
    tabPanel("Help", 
             mainPanel(includeMarkdown("Help.md")))
))
