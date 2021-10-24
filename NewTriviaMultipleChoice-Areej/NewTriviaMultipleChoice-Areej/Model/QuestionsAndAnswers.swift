//
//  QuestionsAndAnswers.swift
//  NewTriviaMultipleChoice-Areej
//
//  Created by A A on 17/03/1443 AH.
//

import Foundation

class QuestionsAndAnswers {
  let question : String
  let choices : [String]
  let correctAnswer : String
  
  init(question:String, choices:[String],correctAnswer:String ) {
    self.question = question
    self.choices = choices
    self.correctAnswer = correctAnswer
  }
  
}
