





#header---------------------------------------------------------------------------
header <-
    dashboardHeader(title = "SUICIDE RATES OVERVIEW 1985-2015",
                    titleWidth = 400)






#sidebar--------------------------------------------------------------------------
sidebar <- dashboardSidebar(sidebarMenu(
    menuItem(
        text = "Global Overview",
        tabName = "global",
        icon = icon("globe-americas")
    ),
    
    menuItem(
        text = "Demographic Overview",
        tabName = "demo",
        icon = icon("venus-mars")
    ),
    
    
    menuItem(
        text = "Distribution",
        tabName = "map",
        icon = icon("globe-americas")
    ),
    
    menuItem(
        text = "Data",
        tabName = "data",
        icon = icon("table")
    )
    
))



#body ----------------------------------------------------------------------------
body <- dashboardBody(
    tabItems(
    tabItem(
    tabName = "global",
    
    fluidRow(
        box(
            title = "WORLDWIDE OVERVIEW",
            width = 12,
           
            valueBoxOutput(outputId = "numsui", width = 3),
            
            valueBoxOutput(outputId = "ratesui", width = 3),
            
            
            valueBoxOutput(outputId = "maxcountry", width = 3),
            
            
            valueBoxOutput(outputId = "ratemaxcountry", width = 3)
            
        )
        
        
    ),
    
    fluidRow(
        
        
        box(
            title = "CONTINENT OVERVIEW",
            width = 2,
            height = "500px",
         
            radioButtons(
                inputId = "continentrate",
                label = "Select the Continent:",
                choices = unique(suicide$continent),
                selected = "Europe",
                inline=F
            ),
            
            valueBoxOutput(outputId = "numsuicont", width = 12),
            
            valueBoxOutput(outputId = "ratesuicont", width = 12)
            
            
            
        ),
        
        box(
            title = "Timeline Number of Suicides by Continent",
            width = 5,
            height = "500px",
            plotlyOutput("suitimeline")
            
        ),
        
        box(
            title = "Timeline Number of Suicides/100k Population by Continent",
            width = 5,
            height = "500px",
            plotlyOutput("suiyearly")
                
            )
            
        ),
        
        
        
        
        
    
    
    
    
    
    
    fluidRow(
        box(
            title = "COUNTRY OVERVIEW",
            width = 2,
            height = "465px",
        
            selectInput(
                inputId = "countryrate",
                label = "Select the Country:",
                choices = unique(suicide$country),
                selected = "Luxembourg",
            ),
            
            valueBoxOutput(outputId = "numsuicountry", width = 12),
            
            valueBoxOutput(outputId = "ratesuicountry", width = 12)
            
            
            
        ),
        
        box(
            title = "Timeline Number of Suicides by Country",
            width = 5,
            plotlyOutput("suitimelinecountry")
            
        ),
        
        box(
            title = "Timeline Number of Suicides/per 100k Population by Country ",
            width = 5,
            plotlyOutput("suiage")
        )
        
        
    )
    
    
),

tabItem(
    tabName = "demo",
    
    fluidRow(
        box(
            title = "WORLWIDE GENDER OVERVIEW",
            
            width = 6,
            valueBoxOutput(outputId = "nummale", width = 6),
            
            valueBoxOutput(outputId = "numfemale", width = 6),
            
            
        ),
        
        box(
            title = "WORLDWIDE AGE GROUP OVERVIEW",
            width = 6,
          
            valueBoxOutput(outputId = "maxage", width = 6),
            
            valueBoxOutput(outputId = "minage", width = 6),
            
            
        )
        
        
        
    ),
    
    fluidRow(
        
        
        box(
            title = "CONTINENT OVERVIEW",
            width = 3,
            height = "463px",
            radioButtons(
                inputId = "contgender",
                label = "Select the Continent:",
                choices = unique(suicide$continent),
                selected = "Europe",
                inline=F
            ),
            
            valueBoxOutput(outputId = "numcontmale", width = 12),
            
            valueBoxOutput(outputId = "numcontfemale", width = 12)
            
            
            
        ),
        
        box(
            title = "Number of Suicides by Continent Demographic","Hover the cursor over the plot to display the detail",
            width = 9,
            plotlyOutput("numgendercount")
            
        )
        
    ),
    
    fluidRow(
        
        
        box(
            title = "COUNTRY OVERVIEW",
            width = 3,
            height = "463px",
            selectInput(
                inputId = "countrygender",
                label = "Select the Country:",
                choices = unique(suicide$country),
                selected = "Australia"
            ),
            
            valueBoxOutput(outputId = "numcountrymale", width = 12),
            
            valueBoxOutput(outputId = "numcountryfemale", width = 12)
            
            
            
        ),
        
        
        
        box(
            title = "Number of Suicides by Country Demographic ", "Hover the cursor over the plot to display the detail",
            width = 9,
            plotlyOutput("numgendercountry")
            
        )
        
    )  
        ),



tabItem(
    tabName = "map",
    
    fluidRow(
        
        
        
        box(
            title = "WORLDWIDE SUICIDE DISTRIBUTION MAP", "Zoom and Hover to see the number of suicides and the country",
            width = 8,
           
            selectInput(
                inputId = "peta_bundir",
                label = "Select the Year:",
                choices = sort(unique(suicide$date_year)),
                selected="1993"
                
            ),
            height = "920px",
            plotlyOutput(outputId = "petamapsui",width="100%",height="700px" )
            
            
            
        ),
        
        box(
            title = "TOTAL NUMBER OF SUICIDES RECORDED ON SELECTED YEAR",
            width = 4,
            height = "330px",
            
            valueBoxOutput(outputId = "totalcountry", width = 6),
            valueBoxOutput(outputId = "totalnumyear", width = 6),
            valueBoxOutput(outputId = "totalrateyear", width = 12)
            
            
            
        ),
        
        box(
            title = "TOTAL DEMOGRAPHIC ON SELECTED YEAR", "Hover the cursor over the plot to display the detail",
            width = 4,
            height = "570px",
            plotlyOutput("totaldemographic",height="480px")
            
        )
        
       
        
        
        
    )
    
),


tabItem(
    tabName = "data",
    
    fluidRow(
        box(
            title = "Data Source", " link source: https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016", "",
            width = 12,
            dataTableOutput(outputId = "datasuicide" )
            
            
            
        )
        
        
        
        
        
    )
    
)


)


)


































#dashboard-----------------------------------------------------------------------

dashboardPage(header, sidebar, body, skin = "red")
