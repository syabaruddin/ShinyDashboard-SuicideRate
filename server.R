function(input, output)  {
   
#PAGE1    
#row1-----------------------------------------------------------------------------------------------------------   
    
    output$numsui <- renderValueBox({
        num_sui <-  suicide %>%
            group_by(continent)  %>%
            summarise(jumlah=sum(suicides_numbers)) %>% 
            summarise(freq=sum(jumlah)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_sui),
            subtitle = "Number of Suicides Recorded",
            color = "red",
            icon = icon("exclamation-triangle"),
            width = 12
        )
        
    })
    
    output$ratesui <- renderValueBox({
        rate_sui <- suicide %>%
            group_by(continent)  %>%
            summarise(ratarata=mean(suicides_rate)) %>% 
            summarise(freq=round(mean(ratarata),1)) %>% 
            pull(round(freq,1))
        
        
        
        valueBox(
            value = rate_sui,
            subtitle = "Number of Suicides per 100k Population",
            icon = icon("exclamation-triangle"),
            color = "red",
            width = 12
        )
        
    })
    

    
    output$maxcountry <- renderValueBox({
        max_country <- suicide %>% 
            group_by(country) %>% 
            summarise(freq=sum(suicides_numbers)) %>% 
            arrange(desc(freq)) %>% 
            head(1) %>% 
            pull(country)
        
        
        
        valueBox(
            value = max_country,
            subtitle = "Country With The Highest Numbers of Suicides",
            color = "red",
            icon = icon("exclamation"),
            width = 12
        )
        
    })
    

    
    output$ratemaxcountry <- renderValueBox({
        rate_max_country <- suicide %>% 
            group_by(country) %>% 
            summarise(freq=mean(suicides_rate)) %>% 
            arrange(desc(freq)) %>% 
            head(1) %>% 
            pull(country)
        
        
        
        valueBox(
            value = rate_max_country,
            subtitle = "Country With The Highest Suicides/100k Population",
            icon = icon("exclamation"),
            color = "red",
            width = 12
        )
        
    })
    
#row2---------------------------------------------------------------------------------------------------   
    
    reactive_continent <- reactive({
        suicide %>%
            filter(continent == input$continentrate)
    })
    
    output$numsuicont <- renderValueBox({
        num_sui_cont <- reactive_continent() %>%
            group_by(continent)  %>%
            summarise(jumlah=sum(suicides_numbers)) %>% 
            summarise(freq=sum(jumlah)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_sui_cont),
            subtitle = "Number of Suicides",
            
            color = "orange",
            width = 12
        )
        
    })
    
    output$ratesuicont <- renderValueBox({
        
        rate_sui_cont <- reactive_continent () %>%
            group_by(continent) %>%
            summarise(freq= round(mean(suicides_rate),1)) %>%
            pull(freq)
        
        
        
        valueBox(
            value = rate_sui_cont,
            subtitle = "Suicides per 100k Population",
            
            color = "orange",
            width = 12
        )
        
    })
    
    
    
    
    output$suitimeline <- renderPlotly({
        
        sui_timeline <- reactive_continent () %>%
            group_by(year,continent) %>%
            summarise(freq = sum(suicides_numbers)) %>%
            mutate(
                label = glue(
                    "Year Recorded: {year}
                     Continent: {continent}
                     Number of Suicides: {comma(freq)}"
                )
            ) %>%
            ggplot(aes(
                x = year,
                y = freq,
                text = label,
                group = 1
            )) +
            geom_line(aes(col=continent)) + geom_point() + geom_area(fill="#6c9ed4",alpha=0.4)+
            scale_y_continuous(labels=comma)+
            labs(title = "",
                 x = "Year",
                 y = "Number of Suicides") +
            theme_bw()
        
        ggplotly(sui_timeline, tooltip = "text") %>% layout(showlegend = F)
        
    })
    
    
    output$suiyearly <- renderPlotly({
        
        suicideyear <- reactive_continent () %>%
            group_by(year,continent) %>%
            summarise(suicidesrate = round(mean(suicides_rate),1)) %>%
            mutate(
                label = glue(
                    "Year Recorded: {year}
                     Continent: {continent}
                     Avg Number of Suicides/100k Population: {suicidesrate}"
                )
            ) %>%
            ggplot(aes(
                x = year,
                y = suicidesrate,
                text = label,
                group = 1
            )) +
            geom_line(aes(col=continent)) + geom_point() + geom_area(fill="#54e88f",alpha=0.4)+
            labs(title = "",
                 x = "Year",
                 y = "Avg Number of Suicides/100k Population") +
            theme_bw()
        
        ggplotly(suicideyear, tooltip = "text") %>% layout(showlegend = F)
        
    })
    
#Row3------------------------------------------------------------------------------------------------------------    
    
    reactive_country <- reactive({
        suicide %>%
            filter(country == input$countryrate)
    })
    
    output$numsuicountry <- renderValueBox({
        num_sui_country <- reactive_country() %>%
            group_by(country)  %>%
            summarise(jumlahcountry=sum(suicides_numbers)) %>% 
            summarise(freq=sum(jumlahcountry)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_sui_country),
            subtitle = "Number of Suicides",
            
            color = "orange",
            width = 12
        )
        
    })
    
    output$ratesuicountry <- renderValueBox({
        
        rate_sui_country <- reactive_country () %>%
            group_by(country) %>%
            summarise(freq= round(mean(suicides_rate),1)) %>%
            pull(freq)
        
        
        
        valueBox(
            value = rate_sui_country,
            subtitle = "Suicides per 100k Population",
            
            color = "orange",
            width = 12
        )
        
    })
    
    output$suitimelinecountry <- renderPlotly({
        
        sui_timeline_country <- reactive_country () %>%
            group_by(year,country) %>%
            summarise(freq = sum(suicides_numbers)) %>%
            mutate(
                label = glue(
                    "Year Recorded: {year}
                     Country: {country}
                     Number of Suicides: {comma(freq)}"
                )
            ) %>%
            ggplot(aes(
                x = year,
                y = freq,
                text = label,
                group = 1
            )) +
            geom_line(aes(col="darkblue")) + geom_point() + geom_area(fill="#6c9ed4",alpha=0.4)+
            scale_y_continuous(labels=comma)+
            labs(title = "",
                 x = "Year",
                 y = "Number of Suicides") +
            theme_bw()
        
        ggplotly(sui_timeline_country, tooltip = "text") %>% layout(showlegend = F)
        
    })
    
    
   
    
    output$suiage <- renderPlotly({
        
        sui_age <- reactive_country() %>%
            group_by(year,country) %>%
            summarise(freq = round(mean(suicides_rate),1)) %>%
            mutate(
                label = glue(
                    "Year Recorded: {year}
                     Country: {country}
                     Avg Number of Suicides/100k Population: {freq}"
                )
            ) %>%
            ggplot(aes(
                x = year,
                y = freq,
                text = label,
                group = 1
            )) +
            geom_line(aes(col="darkblue")) + geom_point() + geom_area(fill="#54e88f",alpha=0.4)+
            labs(title = "",
                 x = "Year",
                 y = "Avg Number of Suicides/100k Population") +
            theme_bw()
        
        ggplotly(sui_age, tooltip = "text") %>% layout(showlegend = F)
        
        
    })
    
    
#PAGE2
#Row1--------------------------------------------------------------------------------------------------------------------------------------------
    
    output$nummale <- renderValueBox({
        num_male <-  suicide %>% 
            filter(sex=="male") %>% 
            group_by(sex)  %>%
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
           
       
        
        
        
        valueBox(
            value = comma(num_male),
            subtitle = "Number of Suicides by Male",
            color = "red",
            icon = icon("mars"),
            width = 12
        )
        
    })
    
    output$numfemale <- renderValueBox({
        num_female <- suicide %>% 
            filter(sex=="female") %>% 
            group_by(sex)  %>%
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_female),
            subtitle = "Number of Suicides by Female",
            icon = icon("venus"),
            color = "red",
            width = 12
        )
        
    })
    
    output$maxage <- renderValueBox({
        max_age <- suicide %>% 
            group_by(group_age)  %>%
            summarise(freq=sum(suicides_numbers)) %>% 
            arrange(desc(freq)) %>% 
            head(1) %>% 
            pull(group_age)
        
        
        
        valueBox(
            value = max_age,
            subtitle = "Age Group With The Highest Numbers of Suicides",
            icon = icon("child"),
            color = "red",
            width = 12
        )
        
    })
    
    output$minage <- renderValueBox({
        min_age <- suicide %>% 
            group_by(group_age)  %>%
            summarise(freq=sum(suicides_numbers)) %>% 
            arrange(desc(freq)) %>% 
            tail(1) %>% 
            pull(group_age)
        
        
        
        valueBox(
            value = min_age,
            subtitle = "Age Group With The Lowest Numbers of Suicides",
            icon = icon("child"),
            color = "red",
            width = 12
        )
        
    })
    
#Row2------------------------------------------------------------------------------------------------------------------------------------------    
    
    reactive_gender <- reactive({
        suicide %>%
            filter(continent == input$contgender)
    })
    
    output$numcontmale <- renderValueBox({
        
        num_cont_male <- reactive_gender() %>%
            filter(sex=="male")  %>%
            group_by(sex) %>% 
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_cont_male),
            subtitle = "Number of Suicides by Male ",
            icon = icon("mars"),
            color = "orange",
            width = 12
        )
        
    })
    
    output$numcontfemale <- renderValueBox({
        
        num_cont_female <- reactive_gender() %>%
            filter(sex=="female")  %>%
            group_by(sex) %>% 
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_cont_female),
            subtitle = "Number of Suicides by Female",
            icon = icon("venus"),
            color = "orange",
            width = 12
        )
        
    })
    
    output$numgendercount <- renderPlotly({
        
        num_gender_count <- reactive_gender () %>%
            group_by(sex,group_age) %>% 
            
            summarise(freq=sum(suicides_numbers)) %>% 
            mutate(label=glue(
                "Age Group: {group_age}
                 Number of Sucides by {sex}: {comma(freq)}
                 Continent: {input$contgender}"
            )) %>% 
            ggplot(aes(y=sex,x=freq,text=label)) + geom_col(aes(col=group_age,fill=group_age),stat="identity", width=0.7) +
            scale_x_continuous(labels=comma)+
            scale_color_viridis_d() +
            scale_fill_viridis_d() +
            theme_bw() +
            labs(x="Number of Suicides",
                 y="",
                 fill=""
                 
            )
        
        ggplotly(num_gender_count, tooltip = "text") %>% layout(legend = list(orientation = "h", x = 0.2, y = -0.3))
        
        
    })
    
#Row3--------------------------------------------------------------------------------------------------------------------------------------------   
 
    reactive_gendercountry <- reactive({
        suicide %>%
            filter(country == input$countrygender)
    })
    
    output$numcountrymale <- renderValueBox({
        
        num_country_male <- reactive_gendercountry() %>%
            filter(sex=="male")  %>%
            group_by(sex) %>% 
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_country_male),
            subtitle = "Number of Suicides by Male",
            icon = icon("mars"),
            color = "orange",
            width = 12
        )
        
    })
    
    output$numcountryfemale <- renderValueBox({
        
        num_country_female <- reactive_gendercountry() %>%
            filter(sex=="female")  %>%
            group_by(sex) %>% 
            summarise(freq=sum(suicides_numbers)) %>% 
            pull(freq)
        
        
        
        valueBox(
            value = comma(num_country_female),
            subtitle = "Number of Suicides by Female",
            icon = icon("venus"),
            color = "orange",
            width = 12
        )
        
    })
    
    output$numgendercountry <- renderPlotly({
        
        num_gender_country <- reactive_gendercountry () %>%
            group_by(sex,group_age) %>% 
            
            summarise(freq=sum(suicides_numbers)) %>% 
            mutate(label=glue(
                "Age Group: {group_age}
                 Number of Sucides by {sex}: {comma(freq)}
                 Country : {input$countrygender}"
            )) %>% 
            ggplot(aes(y=sex,x=freq,text=label)) + geom_col(aes(col=group_age,fill=group_age),stat="identity", width=0.7) +
            scale_x_continuous(labels=comma)+
            scale_color_viridis_d() +
            scale_fill_viridis_d() +
            theme_bw() +
            labs(x="Number of Suicides",
                 y="",
                 fill=""
                 
            )
        
        ggplotly(num_gender_country, tooltip = "text") %>% layout(legend = list(orientation = "h", x = 0.2, y = -0.3))
        
        
    })
    
#Page3---------------------------------------------------------------------------------------------------------------------------------------------   
    
    
    reactive_petabundir <- reactive({
      suicide %>%
        filter(tahun == input$peta_bundir)
    })
    
    output$totalcountry <- renderValueBox({
      total_country <-  reactive_petabundir() %>%
        group_by(country)  %>%
        summarise(sui=sum(suicides_numbers)) %>% 
        group_by(country) %>% 
        summarise(freq=n()) %>% 
        count() %>% 
        pull(n)
      
      
      
      valueBox(
        value = total_country,
        subtitle = "Countries ",
        color = "red",
        icon = icon("globe"),
        width = 12
      )
      
    })
    
    output$totalnumyear <- renderValueBox({
      total_numyear <-  reactive_petabundir() %>%
        group_by(continent)  %>%
        summarise(sui=sum(suicides_numbers)) %>% 
        summarise(freq=sum(sui)) %>% 
        pull(freq)
      
      
      
      valueBox(
        value = comma(total_numyear),
        subtitle = "Number of Suicides ",
        color = "red",
        icon = icon("globe"),
        width = 12
      )
      
    })
    
    output$totalrateyear <- renderValueBox({
      total_rateyear <-  reactive_petabundir() %>%
        group_by(continent)  %>%
        summarise(sui=mean(suicides_rate)) %>% 
        summarise(freq=mean(sui)) %>% 
        pull(freq)
      
      
      
      valueBox(
        value = round(total_rateyear,1),
        subtitle = "Number of Suicides/100K Population ",
        color = "red",
        icon = icon("globe"),
        width = 12
      )
      
    })
    
    
    output$petamapsui <- renderPlotly({
      
      petasui <- reactive_petabundir() %>% group_by(country) %>% summarise(freq=round(sum(suicides_numbers),2)) %>% 
        mutate(country_code=countrycode(country,origin="country.name",destination="iso3c"))
    
      
    l <- list(color = toRGB("grey"), width = 0.5)
    
    g <- list(
      resolution=200,
      showcoastlines=T, coastlinecolor="RebeccaPurple",
      showland=F, landcolor="grey85",
      showocean=T, oceancolor="white",
      showlakes=T, lakecolor="Lightblue",
      showrivers=T, rivercolor="Lightblue",
      projection = list(type = 'natural earth', scale = 1)
    )
    
    plot_ly(petasui, z = petasui$freq , text = petasui$country ,locations = petasui$country_code,  type = 'choropleth',
            color = petasui$freq, colors = 'YlGnBu', marker = list(line = l ),colorbar = list(title = "Number of Suicides")) %>% 
    layout(geo=g)
    
    
    
    })
    
    output$totaldemographic <- renderPlotly({
      
      total_demographic <- reactive_petabundir () %>%
        group_by(sex,group_age) %>% 
        
        summarise(freq=sum(suicides_numbers)) %>% 
        mutate(label=glue(
          "Age Group: {group_age}
                 Number of Sucides by {sex}: {comma(freq)}
                 year: {input$peta_bundir}
          "
        )) %>% 
        ggplot(aes(x=sex,y=freq,text=label)) + geom_bar(aes(col=group_age,fill=group_age),stat="identity",width=0.5) +
        scale_y_continuous(labels=comma)+
        theme_bw() +
        labs(y="Number of Suicides",
             x="",
             fill=""
             
        )
      
      ggplotly(total_demographic, tooltip = "text") %>% layout(legend = list(orientation = "h", x = 0.1, y = -0.1))
      
      
    })
    
#Page4-------------------------------------------------------------------------------------------------------------------------------------------    
    
    output$datasuicide <- renderDataTable({suicide})
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}