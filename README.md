This repository contains files related to Capstone project of Coursera Data Science Specialization Course.

Type Ahead Prediction: Data Science Capstone Project
========================================================
author: Noor Ahmed - April 2015


<small>Around the world, people are spending an increasing amount of time on their mobile devices for email, social networking, banking and a whole range of other activities. A type ahead prediction model suggests words as the user types to improve typing efficiency on constrained mobile devices. This is similar to products such as [Swiftkey](http://swiftkey.com) which is available for mobile devices. </small>


Data Preparation
========================================================

- Dataset: Data used for building the model is a corpus of over 4.2 million lines collected from diverse sources including Twitter, News, and Blogs. <small>([Capstone Dataset](http://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip))</small>
- Randomly sampled lines from each data file to form a training or test dataset
- Splitlines into sentences and trimmed excess whitespace
- Kept only Latin alphanumerics, whitespace and ' (for contractions)
- Transformed all letters to lower case and removed numbers
- Build <small>[N-Gram](http://en.wikipedia.org/wiki/N-gram)</small> dataframe
- A profanity filter was also utilized on all output using a bad words list. <small>.
 ([Profanity filter list for English](https://github.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/)</small>


N-Gram Model
========================================================
- Conditions the probability of the next word based on the previous 'N-1' words (context)
    - Phrase: 'Good morning everyone'
    - Context: 'Good morning'
    - LastWord: 'morning'
    - Next Word: 'everyone'
- The length of the context depends on 'N'
    - 2-gram models consider the previous word only
    - 3-gram model considers the previous 2 words
    - 4-gram model considers the previous 3 words
    - Probability of a phrase is the number of times the phrase occurred divided by the number of times the context occurred
    - p(Good morning everyone) = #(Good morning everyone) / #(Good morning)


Katz Back-off Rule
========================================================
- The language model combines a unigram, bigram, trigram and quadgram model and developed 
 using Katz Back-off Rule.  
- Models where 'N' is larger...
   - Account for greater context and tend to be more accurate
   - But, more frequently encounter n-grams not in the training data and thus have no basis to make a prediction
- Using a [Katz Back-off model](http://en.wikipedia.org/wiki/Katz%27s_back-off_model) balances the advantages and disadvantages of each
   - First consult the larger 'N' models (quadgram/trigram) and only consult the lower order models, as needed.


Shiny Application
========================================================
- The application provides a text box for entering text and makes suggestions as the user types
- Upto Top 5 suggestions are updated in real-time using N-Grams captured.
- At the bottom of the screen, the predicted next word(s) are shown.
- [Click here for Shiny Application](https://dsnoor.shinyapps.io/TypeAhead/)

![alt text][img1]




[img1]: TypeAhead-figure/ShinyApp.png "Shiny Application Image"

Resources
========================================================

- [Shiny Application](https://dsnoor.shinyapps.io/TypeAhead/)
- [Source Code](https://github.com/dsnoor/TypeAhead)
- [Presentation](http://rpubs.com/dsnoor/TypeAhead)
