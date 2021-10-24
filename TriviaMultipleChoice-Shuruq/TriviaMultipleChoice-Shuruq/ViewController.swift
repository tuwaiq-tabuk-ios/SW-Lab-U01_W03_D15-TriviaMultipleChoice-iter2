//
//  ViewController.swift
//  TriviaMultipleChoice-Shuruq
//
//  Created by Shorouq AlAnzi on 15/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  var quizManager = QuizManager()
  var player: AVAudioPlayer?
  var playerErrors : AVAudioPlayer?
  var timer:Timer = Timer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButons()
    valueScoreLabel.text = "Score: \(quizManager.getScore())"
    updateUI()
  }
  
  
  @IBOutlet weak var valueScoreLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  
  @IBOutlet weak var optionFirstButton: UIButton!
  
  @IBOutlet weak var optionSecondButton: UIButton!
  
  @IBOutlet weak var optionThirdButton: UIButton!
  
  @IBOutlet weak var optionFourthButton: UIButton!
  
  @IBOutlet weak var ProgressBar: UIProgressView!
  
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    
    let userAnswer = sender.currentTitle!
    let check = quizManager.getAnswer(userAnswer)
    
    if check {
      sender.backgroundColor = .systemGreen
      
    }
    
    else {
      sender.backgroundColor = .systemRed
      
    }
    timer = Timer.scheduledTimer(timeInterval: 1.2,
                         target: self,
                         selector: #selector(updateUI),
                         userInfo: nil,
                         repeats: false)
    if quizManager.nextQuestion(){
      
    } else {
      hasUserGoodScore()
    }
  }
  
  
  func  configureButons() {
   
    optionFirstButton.layer.cornerRadius = 20
    optionFirstButton.layer.borderColor = UIColor.white.cgColor
    optionFirstButton.layer.borderWidth = 3
    optionFirstButton.titleLabel?.adjustsFontSizeToFitWidth = true
    optionFirstButton.titleLabel?.minimumScaleFactor = 0.5
    
    optionSecondButton.layer.cornerRadius = 20
    optionSecondButton.layer.borderColor = UIColor.white.cgColor
    optionSecondButton.layer.borderWidth = 3
    optionSecondButton.titleLabel?.adjustsFontSizeToFitWidth = true
    optionSecondButton.titleLabel?.minimumScaleFactor = 0.5
    
    optionThirdButton.layer.cornerRadius = 20
    optionThirdButton.layer.borderColor = UIColor.white.cgColor
    optionThirdButton.layer.borderWidth = 3
    optionThirdButton.titleLabel?.adjustsFontSizeToFitWidth = true
    optionThirdButton.titleLabel?.minimumScaleFactor = 0.5
    
    optionFourthButton.layer.cornerRadius = 20
    optionFourthButton.layer.borderColor = UIColor.white.cgColor
    optionFourthButton.layer.borderWidth = 3
    optionFourthButton.titleLabel?.adjustsFontSizeToFitWidth = true
    optionFourthButton.titleLabel?.minimumScaleFactor = 0.5
  }
  
  
  func startGame(action: UIAlertAction! = nil){
    print(#function)
    quizManager.startGame()
    updateUI()
    
  }
  
  
  @objc func updateUI(){
    valueScoreLabel.text = String(quizManager.getScore())
    questionLabel.text = quizManager.getQuestion()
    optionFirstButton.backgroundColor = UIColor.clear
    optionSecondButton.backgroundColor = UIColor.clear
    optionThirdButton.backgroundColor = UIColor.clear
    optionFourthButton.backgroundColor = UIColor.clear
    
    
    optionFirstButton.setTitle(quizManager.getChoices()[0], for: .normal)
    optionSecondButton.setTitle(quizManager.getChoices()[1], for: .normal)
    
    optionThirdButton.setTitle(quizManager.getChoices()[2], for: .normal)
    optionFourthButton.setTitle(quizManager.getChoices()[3], for: .normal)
    ProgressBar.progress = quizManager.getProgress()
  }
  
  
  func hasUserGoodScore(){
   
    let userScore = quizManager.getScore()
    let goodScore = (userScore * 70) / 100
    print("good score = \(goodScore)")
    
    if quizManager.getScore() >= goodScore {
      let alert = UIAlertController(title: " 🥳 Congrationas! 🥳", message: " Your Score is \(quizManager.getScore()) out of 25", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .cancel , handler:startGame ))
      present(alert, animated : true, completion: nil)
      playSound()
    }else{
      let alert = UIAlertController(title: "game Over ", message: " Your Score is \(quizManager.getScore()) out of 25", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Okay", style: .cancel , handler:startGame ))
      present(alert, animated : true, completion: nil)
      playError()
    }
  }
  
  
  func playSound() {
    guard let url = Bundle.main.url(forResource: "clapping", withExtension: "mp3") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      /* The following line is required for the player to work on
       iOS 11. Change the file type accordingly*/
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      
      guard let player = player else { return }
      
      player.play()
      
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func stopSound(){
    player?.stop()
  }

  
func playError() {
  guard let url = Bundle.main.url(forResource: "error", withExtension: "mp3") else { return }
  
  do {
    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    try AVAudioSession.sharedInstance().setActive(true)
    /* The following line is required for the player to work on
     iOS 11. Change the file type accordingly*/
    
    playerErrors = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    
    guard playerErrors != nil else { return }
    
    playerErrors!.play()
    
  } catch let error {
    print(error.localizedDescription)
  }
}
}
