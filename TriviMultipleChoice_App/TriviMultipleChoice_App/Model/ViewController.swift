//
//  ViewController.swift
//  TriviMultipleChoice_App
//
//  Created by Mohammed on 15/03/1443 AH.
//Mohammed Saqer Aloqbi

import UIKit
import AVFoundation
class ViewController: UIViewController {

  
    
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var optionFirstButton: UIButton!
    @IBOutlet weak var optionSecondButton: UIButton!
    @IBOutlet weak var optionThirdButton: UIButton!
    @IBOutlet weak var optionFourthButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var questions:QuestionsBrain = QuestionsBrain()
    var questionNumber:Int = 0
    var score = 0
    var player: AVAudioPlayer?
    var nextQuestion:Int = 0
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
     roundCorner()
        updateUI()
        progressBar.progress = 0.0
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
      
      let userAnswer = sender.currentTitle!
      let check = questions.checkTheAnswer(userAnswer)
      if check{
        
        sender.backgroundColor = UIColor.green
      }
      else {
        
        sender.backgroundColor = UIColor.red
      }
      
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
      if questions.nextQuestion() {
    
      }
      else {
        showGameOverMessage()
      }
    }
    
    
    @objc func updateUI(){
      questionLabel.text = questions.checkQuestion()
      progressBar.progress = questions.checkProgress()
      scoreValueLabel.text = "\(questions.checkScore())"
      
      optionFirstButton.backgroundColor = UIColor.clear
      optionSecondButton.backgroundColor = UIColor.clear
      optionThirdButton.backgroundColor = UIColor.clear
      optionFourthButton.backgroundColor = UIColor.clear
      
      optionFirstButton.setTitle(questions.checkAnswers()[0], for: .normal);
      optionSecondButton.setTitle(questions.checkAnswers()[1], for: .normal)
      optionThirdButton.setTitle(questions.checkAnswers()[2], for: .normal)
      optionFourthButton.setTitle(questions.checkAnswers()[3], for: .normal)
    }

    func hasUserGoodScore(){
      let totalCorrectAnswer = 25
      let percentage = 70 / 100
      
      let finalScore = totalCorrectAnswer * percentage
      
      if questions.getScore() > finalScore{
        playSound(soundName: "clap")
      }
      
    }
    func showGameOverMessage(){
      let ab = UIAlertController(title:"GAME OVER!", message: "You have achieved \(questions.getScore()) Score", preferredStyle: .alert)
      ab.addAction(UIAlertAction(title:"Play again",
                                 style:.default,
                                 handler:startGameAgain))
      
      present(ab, animated: true)
      playSound(soundName: "clap")
        reStart()
    }
      
    
    
    func playSound(soundName: String) {
      guard let url = Bundle.main.url(forResource: soundName , withExtension: "wav")
      else { return
        
      }
      do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = player else {
          return
        }
        player.play()
        
      } catch let error {
        print("ERROR: The audio does not work.\n \(error.localizedDescription)")
      }
    }
    
    
    func stopSound() {
      player?.stop()
    }
    
    
    func reStart() {
      questions.start()
      updateUI()
    }
    
    
    func roundCorner (){
      optionFirstButton.backgroundColor = .clear
      optionFirstButton.layer.cornerRadius = 20
      optionFirstButton.layer.borderWidth = 3
      optionFirstButton.layer.borderColor = UIColor.white.cgColor
      
      optionSecondButton.backgroundColor = .clear
        optionSecondButton.layer.cornerRadius = 20
        optionSecondButton.layer.borderWidth = 3
        optionSecondButton.layer.borderColor = UIColor.white.cgColor
      
      optionThirdButton.backgroundColor = .clear
        optionThirdButton.layer.cornerRadius = 20
        optionThirdButton.layer.borderWidth = 3
        optionThirdButton.layer.borderColor = UIColor.white.cgColor
      
      optionFourthButton.backgroundColor = .clear
        optionFourthButton.layer.cornerRadius = 20
        optionFourthButton.layer.borderWidth = 3
        optionFourthButton.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func startGameAgain(action:UIAlertAction! = nil){
      questions.startGame()
    }
    
    
  }





















