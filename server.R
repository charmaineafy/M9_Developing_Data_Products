#server.R

library(shiny)
require(stats) # for mosaicplot()

# Load data used by this application.
data(Titanic)
tdf<-as.data.frame(Titanic)
tdf$Survived<-factor(tdf$Survived, levels=c("Yes", "No"))

plotTitle <- "Titanic Survival Analysis"

shinyServer(
  function(input,output) {
    # Reactive: Output Analysis and Conclusion after after pressing Submit button.
    output$oAnalysis <- renderText({
      input$goButton
      isolate(paste(input$iAnalysis))
    }) #end-output$plot

    output$oConclusion <- renderText({
      input$goButton
      isolate(paste(input$iConclusion))
    }) #end-output$plot
    
    # Reactive: Output plot based on user selection of check box.
    output$oPlot <- renderPlot({
      if (input$goButton>=0) {
         if (input$iAge==1 & input$iClass==1 & input$iSex==1) {
            isolate(mosaicplot(Titanic, col=rainbow(2), main=paste(plotTitle)))
         } 
         if (input$iAge==0 & input$iClass==0 & input$iSex==1) {
            isolate(mosaicplot(~ Sex+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))        
         }
         if (input$iAge==0 & input$iClass==1 & input$iSex==0) {
            isolate(mosaicplot(~ Class+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))
         }
         if (input$iAge==1 & input$iClass==0 & input$iSex==0) {
            isolate(mosaicplot(~ Age+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))
         }
         if (input$iAge==1 & input$iClass==1 & input$iSex==0) {
            isolate(mosaicplot(~ Age+Class+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))
         }
         if (input$iAge==1 & input$iClass==0 & input$iSex==1) {
            isolate(mosaicplot(~ Age+Sex+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))
         }         
         if (input$iAge==0 & input$iClass==1 & input$iSex==1) {
            isolate(mosaicplot(~ Class+Sex+Survived, data=Titanic, main=paste(plotTitle), col=rainbow(2)))
         }                  
      }
    }) #end-output$oPlot

    output$oTableAge <- renderTable({
      if (input$goButton>=0) {
        if (input$iAge==1 & input$iClass==0 & input$iSex==0) {
          isolate(addmargins(xtabs(Freq~Age+Survived, data=tdf)))
        }
      }
    }) #end-output$oTableAge
    
    output$oTableClass <- renderTable({
      if (input$goButton>=0) {
        if (input$iAge==0 & input$iClass==1 & input$iSex==0) {
          isolate(addmargins(xtabs(Freq~Class+Survived, data=tdf)))
        }
      }
    }) #end-output$oTableClass
    
    output$oTableSex <- renderTable({
      if (input$goButton>=0) {
        if (input$iAge==0 & input$iClass==0 & input$iSex==1) {
          isolate(addmargins(xtabs(Freq~Sex+Survived, data=tdf)))
        }
      }
    }) #end-output$oTableSex
    
  } #end-function(input,output)
)