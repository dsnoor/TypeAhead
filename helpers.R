#helpers.R

#load libraries
library(stringr)
library(data.table)

#load ngrams data frame
#load("data/ngrams.RData")

# function to clean input phrase
clean_input <- function(x){
    # remove non-print characters
    x <- iconv(x, from = "UTF-8", to = "ASCII", sub = "")
    
    #convert lowercase
    x <- tolower(x) 
    
    # remove non-alpha and space characters
    x <- gsub("[^'[:alpha:][:space:]]", "", x)
    
    # trim excess whitespace
    x <- str_trim(x, side = "both")
 
    return(x)    
}

# Extract word count from the phrase
wordcount <- function(str) {
    sapply(gregexpr("\\b\\W+\\b", str, perl=TRUE), function(x) sum(x>0) ) + 1 
}

# Extract the context from the input phrase
getContext <- function(x)
{
    inpLen <- wordcount(x)
    context <- ifelse((inpLen>=4),word(x,inpLen-3,-1), 
                      ifelse((inpLen>=3),word(x,inpLen-2,-1), 
                             ifelse((inpLen>=2),word(x,inpLen-1,-1),word(x,-1)                             
                                   )       
                            )
                     )
    
    context
} 

#Function to predict next word based on input with help of ngrams dataframe
predictNext <- function(inputString, ngrams) {
    inputString <- clean_input(inputString)
    context <- getContext(inputString)
    
    if (nchar(context)>0){
        maxgram <- wordcount(context)
        #predictDone <- FALSE
        
        Tokens <- unlist(strsplit(context,split = " +"))
        
        #Filter ngrams dataframe with last word (column 5 in ngrams) from the context
        #dfPredict <- ngrams %>% filter(ngrams[,5] == Tokens[maxgram]) 
        dfPredict <- ngrams[ngrams$LastWord==Tokens[maxgram],]
    #    dfPredict <- ngrams %>% filter(LastWord == Tokens[maxgram]) 
        
        #sort by columns NGrams(descending) and then by Probability(descending) 
        dfPredict[ order( -dfPredict[,4], -dfPredict[,3]), ]
 #       dfPredict[ order(-nGrams, -Probability), ]    
    
        #look for exact matches in Context column of dataframe
        # result <- dfPredict %>% filter(dfPredict[,1] == context)
        result <- dfPredict[dfPredict$Context==context,]
 #        result <- dfPredict %>% filter(Context == context)
        
        tok <- maxgram
        
        repeat{
            tok <- tok-1
            if(tok==0){
                break
            }
            result <- rbind(result, dfPredict[dfPredict$Context==word(context,(length(Tokens)-tok+1),-1),])
        #    result <- rbind(result, dfPredict %>% filter(dfPredict[,1] == word(context,length(Tokens)-tok+1, -1)))
        }
        prediction <- unique(result$NextWord)
 
        if (length(prediction)<3) { 
            prediction <- append(prediction, rep(" ",(3-length(prediction))))
            
        }

#         # trim blanks
#         prediction <- str_trim(prediction, side = "both")
 
        return(str_trim(paste(prediction, collapse=" "), side="both"))
    }
    else {
        # if no prediction can be made, prompt the user to keep typing
       return("Type few words for prediction...")
        # return(paste(prediction<-rep("Continue typing...",each=3)),collapse=' ')
    }
}        
