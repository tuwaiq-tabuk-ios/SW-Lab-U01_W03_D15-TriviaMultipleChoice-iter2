//
//  Question.swift
//  TriviaMultipleChoice"Ahmed Alqhtani"
//
//  Created by Ahmed awadh alqhtani on 17/03/1443 AH.
//

import Foundation
struct Question { //convention to make struct the file name
  let question: String
  let choices: [String]
  let answer: String
  init(question: String, choices: [String], answer: String){
    self.question = question
    self.choices = choices
    self.answer = answer
    
  }
}
