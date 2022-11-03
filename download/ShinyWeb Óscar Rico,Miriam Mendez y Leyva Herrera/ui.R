library(shiny)
library(shinythemes)
library(shinyWidgets)
library(DT)

shinyUI(fluidPage(theme = shinytheme("slate"),
                    navbarPage(
                    "Crisis en Canarias",
                    tabPanel("💸 PIB",
                            sidebarPanel(
                              conditionalPanel( condition ="input.tabselected==0",
                                                tags$h3("Modifica la gráfica aquí"),
                                                numericRangeInput(inputId = "noui", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                                                numericRangeInput(inputId = "noui0", label = "Escoge un intervalo de dinero (En cientos de millones):",value = c(100, 130),min = 100,max = 130,step = 5)
                              ), # Condition 1
                               conditionalPanel(condition ="input.tabselected==1",
                             tags$h3("Modifica la gráfica aquí"),
                             
                             numericRangeInput(inputId = "noui1", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                             
                             pickerInput("locInput","CCAA",selected = c("Andalucia", "Aragon", "Principado de Asturias","Illes Balears","Canarias","Cantabria","Castilla y Leon","Castilla - La Mancha",
                             "Cataluña","Comunitat Valenciana","Extremadura","Galicia","Comunidad de Madrid","Region de Murcia","Comunidad Foral de Navarra","Pais Vasco","La Rioja","Ceuta","Melilla"),
                             choices=c("Andalucia", "Aragon","Principado de Asturias","Illes Balears","Canarias","Cantabria","Castilla y Leon","Castilla - La Mancha","Cataluña","Comunitat Valenciana",
                             "Extremadura","Galicia","Comunidad de Madrid","Region de Murcia","Comunidad Foral de Navarra","Pais Vasco","La Rioja","Ceuta","Melilla"), options = list(`actions-box` = TRUE),
                             multiple = T),
                             
                             radioButtons("PIB", "Escoge el tipo de la gráfica:",c("Barplot"="Barplot","Line"="Line"),inline = TRUE)
                             ), # Condtition 2
                             conditionalPanel( condition ="input.tabselected==2",
                             tags$h3("Modifica la gráfica aquí"),
                             numericRangeInput(inputId = "noui2", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                             numericRangeInput(inputId = "noui3", label = "Escoge un intervalo de dinero (En millones):",value = c(38, 48),min = 38,max = 48,step = 1)
                             ), # Condition 3
                             width = 2), # sidebarPanel
                    mainPanel(
                      tabsetPanel(
                        tabPanel("Nacional", value = 0,
                                 br(),
                                 p("Aquí podemos observar una gráfica en la que se plasmán las ganancias brutas a nivel nacional.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                                 br(),
                                 fluidRow(plotOutput("hist_Total", width = "90%",height = "700px"),align = "center"),
                                 hr(),
                                 fluidRow(DT::dataTableOutput('Total')),
                                 hr()
                        ), # Tab Panel 1
                        tabPanel("CCAA", value = 1,
                                 br(),
                      p("Aquí podemos observar una gráfica en la que se plasmán las ganancias brutas del conjuto CCAA españolas.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                      br(),
                      fluidRow(plotOutput("hist_PIB", width = "90%",height = "700px"),align = "center"),
                      hr(),
                      fluidRow(DT::dataTableOutput('PIB')),
                      hr()
                      ), # Tab Panel 2
                      tabPanel("Canarias", value = 2,
                               br(),
                               p("Aquí podemos observar una gráfica en la que se plasmán las ganancias brutas de Canarias.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                               br(),
                               fluidRow(plotOutput("hist_Canarias", width = "90%",height = "700px"),align = "center"),
                               hr(),
                               fluidRow(DT::dataTableOutput('Canarias')),
                               hr()),#Tab Panel 3 
                      id = "tabselected"), #Tab Set Panel
                  width = 10 
                  ), #Main Panel
                ), # PIB
                    tabPanel("👷 Trabajo",
                             sidebarPanel(
                               conditionalPanel( condition ="input.tabselected2==0",
                                                 tags$h3("Modifica la gráfica aquí"),
                                                 numericRangeInput(inputId = "noui4", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020)
                               ), # Condition 1
                               conditionalPanel( condition ="input.tabselected2==1",
                                                 tags$h3("Modifica la gráfica aquí"),
                                                 numericRangeInput(inputId = "noui5", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020)
                               ), # Condition 2
                               width = 2), # sidebarPanel
                    mainPanel(
                      tabsetPanel(
                        tabPanel("Empleo", value = 0,
                      br(),
                      p("Aquí podemos observar un pie chart en el que se refleja la evolución del empleo en Canarias",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                      br(),
                      fluidRow(column(offset = 1,width = 4,tags$h4("EMPLEO"),plotOutput("hist_Empleo",width = "700px",height = "600px"),align = "center", bg="transparent"),
                               column(offset = 1,width = 4,DT::dataTableOutput('Empleo'))),
                      hr()),
                      tabPanel("Desempleo", value = 1,
                               br(),
                      p("Aquí podemos observar un pie chart en el que se refleja la evolución del desempleo en Canarias",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                      br(),
                      fluidRow(column(offset = 1,width = 4,tags$h4("DESEMPLEO"),plotOutput("hist_Paro",width = "700px",height = "600px"),align = "center", bg="transparent"),
                               column(offset = 1,width = 4,DT::dataTableOutput('Paro'))),
                      hr()),
                      id = "tabselected2"), #TabSetPanel
                      width = 10
                    ), # Main Panel
                   ), # Tab Panel
                tabPanel("📈 Comercio",
                         sidebarPanel(
                           conditionalPanel( condition ="input.tabselected3==0",
                                             tags$h3("Modifica la gráfica aquí"),
                                             numericRangeInput(inputId = "noui6", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                           ), # Condition 1
                           conditionalPanel( condition ="input.tabselected3==1",
                                             tags$h3("Modifica la gráfica aquí"),
                                             numericRangeInput(inputId = "noui7", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                                             radioButtons("Exterior", "Escoge el tipo de la gráfica:",c("Barplot"="Barplot","Line"="Line"),inline = TRUE),
                           ), # Condtition 2
                           width = 2), # sidebarPanel
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Interior", value = 0,
                                      br(),
                                      p("Aquí se observa la variación de precios corrientes en los Comercios al por menor canarios.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                                      br(),
                                      fluidRow(plotOutput("hist_Interior",width = "90%",height = "700px"),align = "center", bg="transparent"),
                                      hr(),
                                      fluidRow(DT::dataTableOutput('Interior')),
                                      hr()),
                             tabPanel("Exterior", value = 1,
                                      br(),
                                      p("Aquí se observa la variación de los valores en las exportaciones e importaciones comerciales en Canarias.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                                      br(),
                                      fluidRow(plotOutput("hist_Exterior", width = "90%",height = "700px"),align = "center"),
                                      hr(),
                                      fluidRow(DT::dataTableOutput('Exterior')),
                                      hr()),
                             id = "tabselected3"), #TabSetPanel
                           width = 10
                         ), # Main Panel
                ), # Tab Panel
                tabPanel("👪 Sociedad",
                         sidebarPanel(width = 2,
                                      tags$h3("Modifica la gráfica aquí"),
                                      numericRangeInput(inputId = "noui8", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                                      pickerInput("locInput2","Variables",selected = c("Emigración","Inmigración","Empresas"),
                                                  choices=c("Emigración","Inmigración","Empresas"), options = list(`actions-box` = TRUE),
                                                  multiple = T),
                                      radioButtons("Sociedad", "Escoge el tipo de la gráfica:",c("Barplot"="Barplot","Line"="Line"),inline = TRUE)
                         ), # sidebarPanel
                         mainPanel(
                         br(),
                         p("Aquí podemos observar la evolución de los moviminetos emigratorios e inmigratorios, además del número de empresas en Canarias",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                         br(),
                         fluidRow(plotOutput("hist_Sociedad", width = "90%",height = "700px"),align = "center"),
                         hr(),
                         fluidRow(DT::dataTableOutput('Sociedad')),
                         hr()
                ), # Main Panel
                ), # Tab Panel
                tabPanel("🏡 Inmobiliario",
                         sidebarPanel(width = 2,
                                      tags$h3("Modifica la gráfica aquí"),
                                      numericRangeInput(inputId = "noui9", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020),
                         ), # sidebarPanel
                         mainPanel(
                           br(),
                           p("Aquí podemos observar la evolución del precio de las viviendas por m² en Canarias",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                           br(),
                           fluidRow(plotOutput("hist_Viviendas", width = "90%",height = "700px"),align = "center"),
                           hr(),
                           fluidRow(DT::dataTableOutput('Viviendas')),
                           hr()
                         ), # Main Panel
                ), # Tab Panel
                  tabPanel("🛌 Turismo",
                           sidebarPanel(width = 2,
                                        tags$h3("Modifica la gráfica aquí"),
                                        numericRangeInput(inputId = "noui10", label = "Escoge los años:",value = c(2007, 2020),min = 2007,max = 2020)
                           ), # sidebarPanel
                           mainPanel(
                             br(),
                             p("Aquí podemos observar el número de turistas extranjeros en Canarias",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                             br(),
                             fluidRow(plotOutput("hist_Hosteleria", width = "90%",height = "700px"),align = "center"),
                             hr(),
                             fluidRow(DT::dataTableOutput('Hosteleria')),
                             hr()
                           ), # Main Panel
                  ), # Tab Panel
                  tabPanel("📒 Información",
                             br(),
                             fluidRow(
                             p("Todos los datos recopilados en está página han sido sacados de la",tags$a(href="https://www.ine.es/index.htm","INE",style = "color:blue"),"el",tags$a(href="http://www.gobiernodecanarias.org/istac/","ISTAC",style = "color:blue"), "y", tags$a(href="https://es.statista.com","Statista",style = "color:blue"),".",tags$br(),"La intención de está página es dar a conocer el como afector la crisis del 2008 a Canarias en los diversos sectores socio-económicos. En ella podemos encontrar el PIB tanto nacional, como por CCAA y el PIB en Canarias, además de la tasa de empleo y desempleo,diversos estudios sobre el comercio,la hostelería y la sociedad en Canarias entre otros.",style="text-align:center;color:black;background-color:lavender;padding:15px;border-radius:10px"),
                             aling = "center"),
                             br(),
                             fluidRow(column(width = 4,img(src="logoinecaja.jpg",title="Example Image Link",width="600",height="400")),column(width = 4,img(src="descarga.png",title="Example Image Link",width="600",height="400")),column(width = 4,img(src="descarga.jpg",title="Example Image Link",width="600",height="400")),align = "center"),
                             br(),
                             hr()
                    )
                )# NavBar
      )# Fluid Page
)#Shiny UI