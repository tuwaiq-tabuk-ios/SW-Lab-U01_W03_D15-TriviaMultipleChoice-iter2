//
//  TriviaMultiple.swift
//  TriviaMultiple"Ahlam.Abdullah.tuu,s@tuwaiq.edu.sa
//
//  Created by ahlam  on 15/03/1443 AH.
//

import Foundation
import AVFoundation

class TriviaBrain {
    
    static var player: AVAudioPlayer?
    
    static func getQuestions() -> [MultipleChoiceQuestion] {
        let questions = [
            MultipleChoiceQuestion(question: "Which is the world's tallest peak?", answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"], correctAnswer: "Everest"),
            
          
            MultipleChoiceQuestion(question: "Which is the Capital of Australia?", answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"], correctAnswer: "Canberra"),
            
            
            MultipleChoiceQuestion(question: "Rigoletto opera was composed by", answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart","Giuseppe Verdi", "Richard Wagner"], correctAnswer: "Giuseppe Verdi"),
            
            MultipleChoiceQuestion(question: "Turandot opera was composed by?", answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"], correctAnswer: "Giacomo Puccini"),
            
            
            MultipleChoiceQuestion(question: "The magic flute opera was composed by", answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"], correctAnswer: "Wolfgang Amadeus Mozart")
        ]
        return questions
    }
    
    static func playSound() {
        guard let path = Bundle.main.path(forResource: "Clapping Sound Effects - Applause - Audience - Crowd Sound Effect (128  kbps) (shabakngy.com)", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func hasUserGoodScore(score: Int) {
        let maxScore = TriviaBrain.getQuestions().count * 5
        if Float(score) / Float(maxScore) >= 0.75 {
            TriviaBrain.playSound()
        }
    }
}
