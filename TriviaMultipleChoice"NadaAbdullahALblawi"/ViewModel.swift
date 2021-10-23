//
//  ViewModel.swift
//  TriviaMultipleChoice"NadaAbdullahALblawi"
//
//  Created by Abdurrahman Alfudeghi on 23/10/2021.
//

import Foundation
import AVFoundation

class ViewModel {
    var player: AVAudioPlayer?
    var question: QuestionModel {
        questions[currentQuestionIndex]
    }
    let questions: [QuestionModel] = [
        QuestionModel(question: "Which is the world's tallest peak?", answers: ["Klimanjaro", "Everest", "Jabal Sawda", "Montblanc"], correctAnswer: "Everest"),
        QuestionModel(question: "Which is the Capital of Australia?", answers: ["Canberra", "Sydney", "Melbourne", "Australia does not have a capital"], correctAnswer: "Canberra"),
        QuestionModel(question: "Rigoletto opera was composed by", answers: ["Giacomo Puccini", "Wolfgang Amadeus Mozart",
                                                                             "Giuseppe Verdi", "Richard Wagner"], correctAnswer: "Giuseppe Verdi"),
        QuestionModel(question: "Turandot opera was composed by", answers: ["Richard Wagner", "Giacomo Puccini", "Wolfgang Amadeus Mozart", "Giuseppe Verdi"], correctAnswer: "Giacomo Puccini"),
        QuestionModel(question: "The magic flute opera was composed by", answers: ["Giacomo Puccini", "Giuseppe Verdi", "Wolfgang Amadeus Mozart", "Richard Wagner"], correctAnswer: "Wolfgang Amadeus Mozart")
    ]
    var currentQuestionIndex: Int = 0
    var score: Int = 0
    var correct: Int = 0
    var wrong: Int = 0
    
    func check(tag: Int) -> Bool {
        if question.answers[tag] == question.correctAnswer {
            score += 5
            if hasUserGoodScore() {
                playSound()
            }
            return true
        } else {
            score -= 10
            if hasUserGoodScore() {
                playSound()
            }
            return false
        }
    }
    
    func hasUserGoodScore() -> Bool {
        let maxScore = questions.count * 5
        let reqScore = Double(maxScore) * 0.7
        return Double(score) >= reqScore ? true : false
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
