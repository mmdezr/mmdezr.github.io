library(shiny)
library(DT)
library(tidyverse)
library(viridis)
library(hrbrthemes)
library(knitr)
library(plotly)
library(plotrix)
library(scales)
library(reshape2)
#---------------------------------------------------------------------------------------------------------------
setwd("~/ShinyWeb/Csv")
Total <- read.csv("Total.csv", header = TRUE,sep = ",", encoding = "UTF-8")
Comunidades <- read.csv("Comunidades.csv", header = TRUE,sep = ",", encoding = "UTF-8")
Canarias <- read.csv("Canarias.csv", header = TRUE,sep = ",", encoding = "UTF-8")
Empleo <- read.csv("Empleo.csv", header = TRUE,sep = ",", encoding = "UTF-8")
Paro <- read.csv("Paro.csv", header = TRUE,sep = ",", encoding = "UTF-8")
Interior <- read.csv("Icm.csv", header = TRUE,sep = ";", encoding = "UTF-8")
Exterior <- read.csv("Comercio.csv", header = TRUE,sep = ";", encoding = "UTF-8")
Hosteleria <- read.csv("Hosteleria.csv", header = TRUE,sep = ";", encoding = "UTF-8")
Viviendas <- read.csv("Viviendas.csv", header = TRUE,sep = ";", encoding = "UTF-8")
Sociedad <- read.csv("Sociedad.csv", header = TRUE,sep = ";", encoding = "UTF-8")
#---------------------------------------------------------------------------------------------------------------
blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )
#---------------------------------------------------------------------------------------------------------------
shinyServer(function(input,output) {
  #Total
  output$hist_Total <- renderPlot({
    Total2 <- filter(Total,between(periodo,input$noui[1],input$noui[2]) & between(Total,input$noui0[1]*10000000,input$noui0[2]*10000000))
    Total2$periodo <- as.character(Total2$periodo)
    Total_graph <- Total2 %>%
      ggplot(aes(x=as.factor(periodo),y=Total, fill = periodo)) + geom_bar(stat = "identity",colour = "transparent") + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Nacional",fill='Años') + xlab("Años") +
      theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
    output$Total <- DT::renderDataTable(DT::datatable(Total2,style = "bootstrap", options = list(pageLength = 14,paging = FALSE),rownames = FALSE))
    Total_graph
  }) #Render Plot
  #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #CCAA
  output$hist_PIB <- renderPlot({
    Comunidades2 <- filter(Comunidades, Comunidades %in% input$locInput & between(periodo,input$noui1[1],input$noui1[2]))
    if (input$PIB == "Line") {
      Comunidades_graph <- Comunidades2 %>%
        ggplot(aes(x=as.factor(periodo),y=Total, colour = Comunidades, group = Comunidades)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "CCAA") + xlab("Años") +
        theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 13),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
    }
    if (input$PIB == "Barplot") {
      Comunidades2 <- filter(Comunidades, Comunidades %in% input$locInput & between(periodo,input$noui1[1],input$noui1[2]))
      Comunidades_graph <- Comunidades2 %>%
        ggplot() + geom_bar(aes(x=as.factor(periodo),y=Total,fill= Comunidades),colour = "transparent",stat="identity") + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "CCAA") + xlab("Años") +
        theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 13),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15)) + facet_wrap(~ Comunidades) + scale_x_discrete(breaks = (seq(2007,2019,2)))
    }
    output$PIB <- DT::renderDataTable(DT::datatable(Comunidades2,style = "bootstrap", options = list(pageLength = 15),rownames = FALSE))
    Comunidades_graph
  }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Canarias
  output$hist_Canarias <- renderPlot({
    Canarias2 <- filter(Canarias,between(periodo,input$noui2[1],input$noui2[2]) & between(Total,input$noui3[1]*1000000,input$noui3[2]*1000000))
    Canarias2$periodo <- as.character(Canarias2$periodo)
      Canarias_graph <- Canarias2 %>%
        ggplot(aes(x=as.factor(periodo),y=Total, fill = periodo)) + geom_bar(stat = "identity",colour = "transparent") + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Canarias",fill='Años') + xlab("Años") +
        theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
    output$Canarias <- DT::renderDataTable(DT::datatable(Canarias2,style = "bootstrap", options = list(pageLength = 14,paging = FALSE),rownames = FALSE))
    Canarias_graph
  }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Desempleo
    output$hist_Paro <- renderPlot({
    Paro2 <- filter(Paro, between(Periodo,input$noui5[1],input$noui5[2]))
    Paro_graph <- ggplot(Paro2, aes(x="", y=Total, fill=as.factor(Periodo))) + geom_bar(width = 1, stat = "identity",color="white") + coord_polar("y", start=0) + theme_void() + theme(axis.text.x=element_blank()) +
    geom_text(data=Paro2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4,colour = 'black') + theme(legend.position="none") +
    geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4,position = position_stack(vjust = 0.5)) + geom_text(data=Paro2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4.07,colour = 'black') + theme(legend.position="none") +
      geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4.07,position = position_stack(vjust = 0.5)) + geom_text(data=Paro2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4.08,colour = 'black') + theme(legend.position="none") +
      geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4.08,position = position_stack(vjust = 0.5))
    output$Paro <- DT::renderDataTable(DT::datatable(Paro2,style = "bootstrap",options = list(paging = FALSE,searching = FALSE,pageLength = 15),class = 'cell-border stripe',rownames = FALSE))
    Paro_graph
  }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Empleo
    output$hist_Empleo <- renderPlot({
      Empleo2 <- filter(Empleo, between(Periodo,input$noui4[1],input$noui4[2]))
      Empleo_graph <- ggplot(Empleo2, aes(x="", y=Total, fill=as.factor(Periodo))) + geom_bar(width = 1, stat = "identity",color="white") + coord_polar("y", start=0) + theme_void() + theme(axis.text.x=element_blank()) +
        geom_text(data=Empleo2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4,colour = 'black') + theme(legend.position="none") +
        geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4,position = position_stack(vjust = 0.5)) + geom_text(data=Empleo2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4.07,colour = 'black') + theme(legend.position="none") +
        geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4.07,position = position_stack(vjust = 0.5)) + geom_text(data=Empleo2, aes(x = 1.6,label = percent(accuracy = 0.1,Total/sum(Total))), position = position_stack(vjust = 0.5),size=4.08,colour = 'black') + theme(legend.position="none") +
        geom_text(aes(x=1.3,y = Total, label = as.factor(Periodo)), color = "black", size=4.08,position = position_stack(vjust = 0.5)) 
      output$Empleo <- DT::renderDataTable(DT::datatable(Empleo2,style = "bootstrap",options = list(paging = FALSE,searching = FALSE,pageLength = 15),rownames = FALSE,class = 'cell-border stripe'))
      Empleo_graph
  }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Interior
      output$hist_Interior <- renderPlot({
        Interior2 <- filter(Interior, between(periodo,input$noui6[1],input$noui6[2]))
        Interior_graph <- ggplot(Interior2, aes(x=as.factor(periodo),y=Total, colour = as.character(periodo), group = 1)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Índice de cifra de negocios a precios corrientes",color='Años', x ="Años", y = "% Ventas") + 
          theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15)) 
        output$Interior <- DT::renderDataTable(DT::datatable(Interior2,style = "bootstrap",options = list(paging = FALSE,searching = FALSE,pageLength = 15),rownames = FALSE,class = 'cell-border stripe'))
        Interior_graph
 }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Exterior
      output$hist_Exterior <- renderPlot({
        Exterior2 <- filter(Exterior, between(periodo,input$noui7[1],input$noui7[2]))
        Exterior2 <- melt(Exterior2,id.vars = "periodo")
        if (input$Exterior == "Line") {
          Exterior_graph <- Exterior2 %>%
            ggplot(aes(x=as.factor(periodo),y=value, colour = variable, group = variable)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Exportaciones e importaciones comerciales",colour="Tipos") + xlab("Años") +
            theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
        }
        if (input$Exterior == "Barplot") {
          Exterior_graph <- Exterior2 %>%
            ggplot() + geom_bar(aes(x=as.factor(periodo),y=value,fill= variable),colour = "transparent",stat="identity",position=position_dodge()) + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Exportaciones e importaciones comerciales",fill="Tipos") + xlab("Años") +
            theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
          }
        output$Exterior <- DT::renderDataTable(DT::datatable(Exterior2,style = "bootstrap", options = list(pageLength = 14),rownames = FALSE))
        Exterior_graph
 }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  # Sociedad
      output$hist_Sociedad <- renderPlot({
        Sociedad2 <- filter(Sociedad, variable %in% input$locInput2 & between(periodo,input$noui8[1],input$noui8[2]))
        if (input$Sociedad == "Line") {
          Sociedad_graph <- Sociedad2 %>%
            ggplot(aes(x=as.factor(periodo),y=value, colour = variable, group = variable)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Emigración, inmigración y empresas",colour="") + xlab("Años") +
            theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
        }
        if (input$Sociedad == "Barplot") {
          Sociedad2 <- filter(Sociedad, variable %in% input$locInput2 & between(periodo,input$noui8[1],input$noui8[2]))
          Sociedad_graph <- Sociedad2 %>%
            ggplot() + geom_bar(aes(x=as.factor(periodo),y=value,fill= variable),colour = "transparent",stat="identity",position ="dodge") + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Emigración, inmigración y empresas",fill="") + xlab("Años") +
            theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15)) + scale_x_discrete(breaks = (seq(2007,2019,2)))
        }
        output$Sociedad <- DT::renderDataTable(DT::datatable(Sociedad2,style = "bootstrap", options = list(pageLength = 13),rownames = FALSE))
        Sociedad_graph
      }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  # Inmobiliario
      output$hist_Viviendas <- renderPlot({
        Viviendas2 <- filter(Viviendas, between(periodo,input$noui9[1],input$noui9[2]))
        Viviendas_graph <- Viviendas2 %>%
          ggplot(aes(x=as.factor(periodo),y=Total, colour = as.character(periodo), group = 1)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Precio viviendas",colour = "Años")+ ylab("Precio m²") + xlab("Años") +
          theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
        output$Viviendas <- DT::renderDataTable(DT::datatable(Viviendas2,style = "bootstrap", options = list(pageLength = 13),rownames = FALSE))
        Viviendas_graph
      }) #Render Plot
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  # Turismo
      output$hist_Hosteleria <- renderPlot({
        Hosteleria2 <- filter(Hosteleria, between(periodo,input$noui10[1],input$noui10[2]))
        Hosteleria_graph <- Hosteleria2 %>%
          ggplot(aes(x=as.factor(periodo),y=Total, colour = as.character(periodo), group = 1)) + geom_line() + geom_point() + scale_fill_viridis(discrete=TRUE,option = "plasma") +labs(title = "Número Turistas Extranjeros",colour = "Años")+ ylab("Turistas") + xlab("Años") +
          theme_modern_rc() + theme(strip.text = element_text(colour = 'white'),axis.text.x = element_text(size = 15),legend.text = element_text(size=15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.title = element_text(size=15))
        output$Hosteleria <- DT::renderDataTable(DT::datatable(Hosteleria2,style = "bootstrap", options = list(pageLength = 13),rownames = FALSE))
        Hosteleria_graph
      }) #Render Plot
}) #Server
