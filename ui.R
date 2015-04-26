# ui.R
library("shiny")
data(Titanic)

shinyUI(
  pageWithSidebar(
    # Application Title
    headerPanel(
      h3("Titanic Survival Analysis")
      ),
  
    # Input Panel
    sidebarPanel(
      h4('Perform Analysis by:'),
      checkboxInput('iAge', 'Age'),
      checkboxInput('iClass', 'Class'),
      checkboxInput('iSex', 'Sex'),
      textInput(inputId="iAnalysis", label="Input your analysis and observations:"),
      textInput(inputId="iConclusion", label="Input your conclusion:"),
      actionButton("goButton","Print my analysis and conclusion."),
      
      tags$br(),
      strong(h5('Notes:')),
      h6('The application uses the Titanic dataset in R, with the following variables'),
      h6('Age: Child, Adult'),
      h6('Class: Economic Status of Passenger (1st ~ Upper; 2nd ~ Middle; 3rd ~ Lower; Crew)'),
      h6('Sex: Male, Female'),
      h6('Survived: Yes, No')
    ),
  
    # Output Panel
    mainPanel(
      h4('Exploratory Analysis of Titanic'),
      h5('The sinking of the Titanic is a famous event. Many well-known facts-from the proportions of first-class passengers to the -Women and Children First- policy, and the fact that that policy was not entirely successful in saving the women and children in the third class-are reflected in the survival rates for various classes of passenger.'),
      h5('This is a simple web application for you to analyze the fate of passengers on the fatal maiden voyage of the ocean liner Titanic, by summarizing survival according to Age, Class (economic status), and Sex.'),
      
      strong('Getting Started'),
      p('On the left panel, you can check/uncheck one or more of the checkbox(es) to control the display of the mosiac plot. The mosiac plot will be refreshed automatically upon any changes to the checkboxes.'),
     
      strong('About the Plot'),
      p('The plot allows user to compare the survivors by the chosen dimensions (Age, Class, Sex), and hence find answer to the following questions: '),
      tags$ul(
        tags$li('Compare the survivors by age. Any prevailing pattern?'),
        tags$li('Compare the survivors by class. Any prevailing pattern?'),
        tags$li('Compare the survivors by sex. Any prevailing pattern?'),
        tags$li('Compare the survivors by age and class. Any new pattern?'),
        tags$li('Compare the survivors by age, class and sex. Any new pattern?'),
        tags$li('etc')
      ),
      
      strong('Printing of User Analysis and Conclusion'),
      p('After analyzing the plots, the user may input his/her findings and then print them together with the plot.'),
      
      tags$br(),
      textOutput('oAnalysis'),
      tags$br(),
      textOutput('oConclusion'),
      plotOutput('oPlot'),
      tableOutput('oTableAge'),
      tableOutput('oTableClass'),
      tableOutput('oTableSex')
    )
  ) #end-pageWithSidebar
) #end-shinyUI
   