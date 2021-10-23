//
//  ViewController.swift
//  TriviaMultipleChoice-“Ressam”
//
//  Created by Ressam Al-Thebailah on 17/03/1443 AH.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  var triviaBrain = TriviaBrain()
  var player: AVAudioPlayer?
  var timer:Timer = Timer()
  var score : Int = 0
  var selectedAnswer : String = ""
  var quetionNumber = 0
  var rightQuestion = 0
  var wrongQuestion = 0
  
  
  @IBOutlet weak var ValueScoreLabel: UILabel!
  @IBOutlet weak var QuestionLabel: UILabel!
  @IBOutlet weak var FirstOption: UIButton!
  @IBOutlet weak var SecondOption: UIButton!
  @IBOutlet weak var ThirdOption: UIButton!
  @IBOutlet weak var FourthOption: UIButton!
  @IBOutlet weak var ProgressBar: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view
    configureButtons()
    ValueScoreLabel.text = ""
    ProgressBar.progress = 0.0
    updateQuestion()
  }
  
  
  @IBAction func AnswerButton(_ sender: UIButton) {
    let userSelected = sender.currentTitle!
    if userSelected == selectedAnswer {
      sender.backgroundColor = UIColor.green
      score += 5
      rightQuestion += 1
      print(rightQuestion)
      ValueScoreLabel.text = "\(score)"
      
    }else{
      
      sender.backgroundColor = UIColor.red
      score -= 10
      wrongQuestion += 1
      print(wrongQuestion)
      ValueScoreLabel.text = "\(score)"
      
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    sender.backgroundColor = UIColor.clear})
    
    if getNextQuestion() {
      timer = Timer.scheduledTimer(timeInterval: 0.5
                                   , target: self
                                   , selector: #selector(updateQuestion)
                                   , userInfo: nil
                                   , repeats: true)
    }else{
      resultAlert()
    }
  }
  
  
  @objc func updateQuestion (){
    if quetionNumber <= triviaBrain.questions.count - 1  {
      ProgressBar.setProgress(Float(getProgress()), animated: true)
      QuestionLabel.text = triviaBrain.questions[quetionNumber].question
      FirstOption.setTitle(triviaBrain.questions[quetionNumber].answers[0], for: .normal)
      SecondOption.setTitle(triviaBrain.questions[quetionNumber].answers[1], for: .normal)
      ThirdOption.setTitle(triviaBrain.questions[quetionNumber].answers[2], for: .normal)
      FourthOption.setTitle(triviaBrain.questions[quetionNumber].answers[3], for: .normal)
      selectedAnswer = triviaBrain.questions[quetionNumber].correctAnswer
      ProgressBar.setProgress(Float(getProgress()), animated: true)
    }
  }
  
  
  func  hasUserGoodScore(){
    if rightQuestion  > wrongQuestion{
      playSound ()
    }
  }
  
  
  func resultAlert(){
    hasUserGoodScore ()
    let resetAlert = UIAlertController(title: "The Game is Over"
                                       , message: "Your Score is \(score) out of 10"
                                       , preferredStyle: .alert)
    
    resetAlert.addAction(UIAlertAction(title: "Play Again",
                                       style: UIAlertAction.Style.default
                                       ,handler: (startGameAgain)))
    present(resetAlert, animated: true)
  }
  
  
  func startGameAgain(action:UIAlertAction){
    score = 0
    updateQuestion ()
    quetionNumber = 0
    wrongQuestion = 0
    rightQuestion = 0
    
  }
  
  
  func playSound() {
    guard let url = Bundle.main.url(forResource: "clap", withExtension: "wav") else { return }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
      try AVAudioSession.sharedInstance().setActive(true)
      
      /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
      /* iOS 10 and earlier require the following line:
       player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
      guard let player = player else {
        return
      }
      player.play()
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  
  func getProgress() -> Float{
    return Float(quetionNumber+1) / Float(triviaBrain.questions.count)
  }
  
  
  func getNextQuestion() ->Bool{
    if quetionNumber + 1  < triviaBrain.questions.count{
      quetionNumber += 1
      return true
    }else{
      return false
    }
  }
  
  
  func configureButtons(){
    FirstOption.layer.borderWidth = 3
    FirstOption.layer.cornerRadius = 20
    FirstOption.layer.borderColor = UIColor.white.cgColor
    FirstOption.backgroundColor = .clear
    FirstOption.titleLabel?.adjustsFontSizeToFitWidth = true
    FirstOption.titleLabel?.minimumScaleFactor = 0.5
    
    SecondOption.layer.borderWidth = 3
    SecondOption.layer.cornerRadius = 20
    SecondOption.layer.borderColor = UIColor.white.cgColor
    SecondOption.backgroundColor = .clear
    SecondOption.titleLabel?.minimumScaleFactor = 0.5
    SecondOption.titleLabel?.adjustsFontSizeToFitWidth = true
    
    ThirdOption.layer.borderWidth = 3
    ThirdOption.layer.cornerRadius = 20
    ThirdOption.layer.borderColor = UIColor.white.cgColor
    ThirdOption.backgroundColor = .clear
    ThirdOption.titleLabel?.minimumScaleFactor = 0.5
    ThirdOption.titleLabel?.adjustsFontSizeToFitWidth = true
    
    FourthOption.layer.borderWidth = 3
    FourthOption.layer.cornerRadius = 20
    FourthOption.layer.borderColor = UIColor.white.cgColor
    FourthOption.backgroundColor = .clear
    FourthOption.titleLabel?.minimumScaleFactor = 0.5
    FourthOption.titleLabel?.adjustsFontSizeToFitWidth = true
    
    QuestionLabel.layer.borderWidth = 10
    QuestionLabel.layer.cornerRadius = 10
    QuestionLabel.layer.borderColor = UIColor.white.cgColor
  }
}
