//
//  Quiz.swift
//  NewTriviaMultipleChoice-Areej
//
//  Created by A A on 17/03/1443 AH.
//

import Foundation

struct Quiz {
  
  internal var score = 0
  private var questionNumber = 0
  
  private let quiz = [
    QuestionsAndAnswers(question: "Saudi Arabia is the biggest producer of ?", choices: ["Coffee","Oil","Coal","Tea"], correctAnswer: "Oil"),
    QuestionsAndAnswers(question: "What is the capital city of Turkey ?", choices: ["Riyadh","Doha","Istanbul","Ankara"], correctAnswer: "Ankara"),
    QuestionsAndAnswers(question: "Which of the follwing country is the most populous country ?", choices: ["China","India","US","Indonesia"], correctAnswer: "China"),
    QuestionsAndAnswers(question: "Which is the smallest country in the world ?", choices: ["Vatican City","Vanuatu","Monaco","Kuwait"], correctAnswer: "Vatican City"),
    QuestionsAndAnswers(question: "Which is the biggest country in the world ? ?", choices: ["Eygpt","Saudi Arabia","China","Russia"], correctAnswer: "Russia")
  ]
  
  
  func getQuestion() -> String{
    return self.quiz[questionNumber].question
  }
  
  
  func getChoices() -> [String]{
    return self.quiz[questionNumber].choices
  }
  
  
  mutating func checkAnswer(_ selectedChoice:String) -> Bool{
    if selectedChoice == quiz[questionNumber].correctAnswer{
      score += 5
      return true
    }
    score -= 10
    return false
  }
  
  
  mutating func nextQuestion() -> Bool{
    questionNumber += 1
    if questionNumber < quiz.count {
      return true
    } else{
      questionNumber = 0
      return false
    }
  }
  
  
  func getScore() -> Int{
    return score
  }
  
  
  func getProgress() -> Float{
    return Float(questionNumber) / Float(quiz.count);
  }
  
}
