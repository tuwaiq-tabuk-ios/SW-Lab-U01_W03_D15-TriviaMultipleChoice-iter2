//
//  QuizBrain.swift
//  TriviaMultipleChoice.MahaNasser
//
//  Created by Maha S on 22/10/2021.


import Foundation

struct QuizBrain {

   internal var questionNumber = 0
   private var score = 0
   var wrongAnswers = 0
   var rightAnswers = 0
  
  internal  let questions = [
        
        Question ( question:  "Which artist painted (The Scream) painting?",
                   answers: ["Vincent Van Gogh", "Edvard Munch", "Da Venci", "Claude Monet"],
                   correctAnswer: "Edvard Munch"),
        
        Question ( question: "Which of the followin isn't Claude Monet painting?",
                   answers: ["Poppies", "Sunrise", "Artist's Garden", "Anxiety"],
                   correctAnswer: "Anxiety"),
        
        Question ( question: "Who painted (The Old Guitarist)?",
                   answers: ["Pablo Picasso", "Rembrandt", "Salvador Dali", "Edgar Degas"],
                   correctAnswer: "Pablo Picasso"),
        
        
        Question ( question: "Which of the following was painted by William Powell?",
                   answers: ["The scream", "Night Walk", "Lilly Garden", "A private view at the Royal Academy"],
                   correctAnswer: "A private view at the Royal Academy"),
        
        Question ( question: "Who is the first president of Italy?",
                   answers : ["Luigi Einaudi", "Enrico De Nicola","Giovanni Gronchi", "Antonio Sengi"],
                   correctAnswer: "Enrico De Nicola"),
        
        Question ( question: "What is the largest Lake in Italy?",
                   answers: ["Maggiore", "Como", "Grada", "Bolsena"],
                   correctAnswer: "Grada"),
        
        Question ( question: "What is the capital of Italy?",
                   answers: ["Venice", "Rome", "Naples", "Florence"],
                   correctAnswer: "Rome"),
        
        
    ]
    
    mutating func getTheAnswer (_ selectedAnswer : String) -> Bool {

        if questionNumber < questions.count {
          if selectedAnswer == questions[questionNumber].correctAnswer {
            score += 5
            return true
          }

          else {
            score -= 10
            return false
          }
        }

       else {
          return false
        }
      }



      func getAnswers() -> [String] {

        if questionNumber < questions.count {

          return questions[questionNumber].answers
        }
        return questions[questions.count - 1].answers
      }


      func getTheProgress() -> Float {

        return Float(questionNumber) / Float(questions.count)
      }


      func getTheQuestion() -> String {

        if questionNumber < questions.count {

          return questions[questionNumber].question
        }
        return questions[questions.count - 1].question
      }


      mutating func nextQuestion () -> Bool {

        if questionNumber <= questions.count {

          questionNumber += 1
          return true
        }

        else {
          questionNumber = 0
          return false
        }
      }


      func getTheScore () -> Int {

        return score
      }

  
  mutating func startGame(){
      questionNumber = 0
      score = 0
      wrongAnswers = 0
      rightAnswers = 0
    }
  

      func hasUserGoodScore() -> Bool {

        // ternary conditional operation to check if the score is higher than 17:
        let isScoreHigh = (getTheScore() > Int(17.5)) ? true : false
        return isScoreHigh
      }

    }
