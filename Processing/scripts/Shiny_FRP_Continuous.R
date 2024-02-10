# Shiny_FRP_Continuous.R

library(shiny)
library(ggplot2)

rm(list = ls())

load(here::here("working","QCd_Data_FRP.RData"))
'%ni%' = Negate('%in%')
col2sub <- c("Site","dts","TempC","SPC","DOmgL","DOsat","Turb","ChlRFU","PCRFU","fDOMRFU","fDOMQSU","Depthm")

list_stn.2 <- list()
for(i in 1:length(list_all_qc)){
  list_stn <- list_all_qc[[i]]
  list_stn.sub <- list()
  for(j in 1:length(list_stn)){
  df_stn <- list_stn[[j]][,which(colnames(list_stn[[j]]) %in% col2sub)]
  for(k in 1:length(col2sub)){
    if(col2sub[k] %ni% colnames(df_stn)){
      df_stn$x <- NA
      colnames(df_stn)[which(colnames(df_stn)=="x")] <- col2sub[k]
    }
  }
  df_stn$station <- names(list_all_qc)[i]
  df_stn.a <- df_stn[,col2sub]
  list_stn.sub[[j]] <- df_stn
  }
  list_stn.2[[i]] <- do.call(rbind.data.frame, list_stn.sub)
}


stn.data <- do.call(rbind.data.frame, list_stn.2)
varWQ <- names(stn.data)[c(2:10,12)]
stn.data[varWQ] <- lapply(stn.data[varWQ], as.numeric)
stnames <- names(list_all_qc)
#varWQ <- colnames(list_all_qc[[1]]$`19C101658 2020-01-28 2020-02-12`)[5:13]
rm(list_all_qc, list_stn,list_stn.2,list_stn.sub, df_stn, df_stn.a)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "station", label = "Station",
                  choices = stnames,
                  selected = "DECK_Pool"),
      selectInput(inputId = "constituent", label = "Constituent",
                  choices = varWQ,
                  selected = "TempC")
    ),
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)
server <- function(input, output, session) {
  

  output$scatterplot <- renderPlot({
    req(input$station)
    req(input$constituent)
    stn.data.2 <- stn.data[which(stn.data$station == input$station),]
    ggplot(data = stn.data.2, aes_string(x = stn.data.2$dts, y = input$constituent)) +
      geom_point()
  })

}

shinyApp(ui, server)
