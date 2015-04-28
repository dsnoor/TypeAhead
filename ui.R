# Load packages
library(shiny)

shinyUI(fluidPage(

    titlePanel("Word Prediction Model using NLP"),
    
    # Copy the line below to make a text input box
    
    hr(),

    h4('Message: ', style = "color:blue;"),
    fluidRow(column(3, verbatimTextOutput("message"), style="color:red")),
    
    # Text input box
    h4('Enter your text below: ', style = "color:blue;"),
    fluidRow(column(3, textInput("text", label ="", value = "Good"))),
    
    h4('Predicted next word(s) are:', style = "color:blue;"),
    fluidRow(column(3, verbatimTextOutput("value"))),
    h6('Note: first word is of high probability than the subsequent words shown above. '),
    hr(),
    
    h4('Sample phrases from corpus(for testing):', style ="color:grey"),
    h5('Example #1: Hey sunshine, can you follow me and make me the happiest', style = "color:grey"),
    h5('Example #2: Be grateful for the good times and keep the faith', style = "color:grey"),
    h5('Example #3: Every inch of you is perfect from the bottom to the top', style = "color:grey"),
    h5('Example #4: Id give anything to see arctic monkeys', style = "color:grey"),
    h5('Example #5: It would mean the world', style = "color:grey"),
    h5('Example #6: Good morning everyone.', style = "color:grey"),
    
    hr()
))
