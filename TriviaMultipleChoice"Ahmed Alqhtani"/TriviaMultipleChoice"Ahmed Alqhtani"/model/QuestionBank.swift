//
//  QuestionBank.swift
//  TriviaMultipleChoice"Ahmed Alqhtani"
//
//  Created by Ahmed awadh alqhtani on 17/03/1443 AH.
//

import Foundation

struct QuizManager {
  
  let quiz = [
    Question(question: "The capital of Saudi Arabia ?", choices: ["Riyadh", "Abha", "arar", "Tabuk"], answer: "Riyadh"),
    Question(question: "Winner of the 2014 World Cup ?", choices: ["Germany", "Farnce","Saudi","Italy"], answer: "Germany"),
    Question(question: "Where is the Eiffel Tower ?", choices: ["Germany", "Farnce","Saudi","Italy"], answer: "Farnce"),
    Question(question: "What is the largest country in the world ?", choices: ["Russia", "America","Spain","Saudi"], answer: "Russia"),
    Question(question: "The language of Saudi Arabia is ?", choices: ["English", "Arabic","china","Hindi"], answer: "Arabic")]
  
  private var questionNumber = 0
  var score = 0
  
  
  mutating func checkAnswer(_ userAnswer:String) -> Bool {
    print(userAnswer)
    print(quiz[questionNumber].answer)
    if userAnswer == quiz[questionNumber].answer{
      score += 15
      return true
    }
    score -= 15
    return false
  }
  func checkQuestion() -> String {
    return quiz[questionNumber].question
  }
  func checkChoices() -> [String] {
    return quiz[questionNumber].choices
  }
  func checkProgress() -> Float {
    return Float(questionNumber) / Float(quiz.count);
  }
  func checkScore() -> Int {
    return score
  }
  
  mutating func nextQuestion() -> Bool {
    //questionNumber += 1
    if (questionNumber + 1 < quiz.count){
      questionNumber += 1
      //  questionNumber = 0
      //   score = 0
      return true
    }
    else{
      return false
    }
  }
  
  
  mutating func start() {
    questionNumber = 0
    score = 0
  }
}
