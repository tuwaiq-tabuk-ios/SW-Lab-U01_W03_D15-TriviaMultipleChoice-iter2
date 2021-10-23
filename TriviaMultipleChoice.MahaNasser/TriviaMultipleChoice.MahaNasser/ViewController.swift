//
//  ViewController.swift
//  TriviaMultipleChoice.MahaNasser
//
//  Created by Maha S on 22/10/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var scoreValueLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var lastButton: UIButton!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    var currentProgress = 0
    var quiz : QuizBrain = QuizBrain ()
    var score = 0
    var player:AVAudioPlayer? = AVAudioPlayer()
    var timer:Timer = Timer()
    var questionNumber = 0
    
    
    override func viewDidLoad () {

        super.viewDidLoad ()
        configureButtons ()
        progressBar.progress = 0
        scoreLabel.text = "Score:"
        scoreValueLabel.text = "\(score)"
        updateScreen ()
      }
    
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
    
        let playerAnswer = sender.currentTitle!
          
          let isCorrect = quiz.getTheAnswer(playerAnswer)
          if isCorrect {
    
              sender.backgroundColor = UIColor.green
              scoreValueLabel.text = "\(score)"
              playRightAnswerSound()
              
          } else {
              sender.backgroundColor = UIColor.red
              scoreValueLabel.text = "\(score)"
              playWrongAnswerSound()
          }

    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
    sender.backgroundColor = UIColor.clear
    })
    
    if quiz.nextQuestion () {
    
    updateScreen()
    
    if quiz.questionNumber == quiz.questions.count {
    if quiz.hasUserGoodScore () {
    playHighScoreSound ()
    }
    
    let alert = UIAlertController(title: "QUIZ OVER!",
    message: "You did great \n your score is \(quiz.getTheScore()) / 35",
    preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Quit the quiz", style: .default, handler:  { (action:UIAlertAction!) -> Void in
    
    }))
    
    self.present(alert, animated: true)
    }
    }
    }
    
    
    @objc func updateScreen () {
        
        progressBar.progress = quiz.getTheProgress ()
        
        if quiz.questionNumber < quiz.questions.count {
            questionLabel.text = quiz.getTheQuestion ()
        }
        
        questionLabel.text = quiz.getTheQuestion ()
        progressBar.progress = quiz.getTheProgress ()
        scoreValueLabel.text = "\(quiz.getTheScore ())"
        
        let answers = quiz.getAnswers ()
        
        firstButton.setTitle(answers [0], for: .normal)
        secondButton.setTitle(answers [1], for: .normal)
        thirdButton.setTitle(answers [2], for: .normal)
        lastButton.setTitle(answers [3], for: .normal)
    }
    
    
    func configureButtons () {
        
        firstButton.layer.cornerRadius = 40
        firstButton.layer.borderWidth = 3
        firstButton.layer.borderColor = UIColor.white.cgColor
        
        secondButton.layer.cornerRadius = 40
        secondButton.layer.borderWidth = 3
        secondButton.layer.borderColor = UIColor.white.cgColor
        
        thirdButton.layer.cornerRadius = 40
        thirdButton.layer.borderWidth = 3
        thirdButton.layer.borderColor = UIColor.white.cgColor
        
        lastButton.layer.cornerRadius = 40
        lastButton.layer.borderWidth = 3
        lastButton.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func playRightAnswerSound () {
        
        guard let url = Bundle.main.url(forResource: "clap",
                                        withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func playWrongAnswerSound () {
        
        guard let url = Bundle.main.url(forResource: "Wrong",
                                        withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func playHighScoreSound () {
        
        guard let url = Bundle.main.url(forResource: "clap",
                                        withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

