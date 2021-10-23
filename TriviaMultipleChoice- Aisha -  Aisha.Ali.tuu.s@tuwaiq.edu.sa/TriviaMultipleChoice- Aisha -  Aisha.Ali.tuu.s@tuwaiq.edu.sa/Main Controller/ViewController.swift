//
//  ViewController.swift
//  TriviaMultipleChoice- Aisha -  Aisha.Ali.tuu.s@tuwaiq.edu.sa
//
//  Created by Aisha Ali on 10/22/21.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
  
  
  
  var audioPlayer:AVAudioPlayer = AVAudioPlayer()
  var timer:Timer = Timer()
  var question = QuestionsAndAnswers()
  
  @IBOutlet weak var topView: UIView!
  @IBOutlet weak var firstButtonView: UIView!
  @IBOutlet weak var secondButtonView: UIView!
  @IBOutlet weak var thirdButtonView: UIView!
  @IBOutlet weak var fourthButtonView: UIView!
  @IBOutlet var root_View: UIView!
  
  
  
  
  @IBOutlet weak var questionsView: UIView!
  @IBOutlet weak var questionsLabel: UILabel!
  @IBOutlet weak var valueScoreLabel: UILabel!
  @IBOutlet weak var firstButton: UIButton!
  @IBOutlet weak var secondButton: UIButton!
  @IBOutlet weak var thirdButton: UIButton!
  @IBOutlet weak var fourthButton: UIButton!
  
  @IBOutlet weak var progressBarView: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    // First Button
    firstButton.layer.borderWidth = 3
    firstButton.layer.cornerRadius = 20
    firstButton.layer.borderColor = UIColor.white.cgColor
    firstButton.backgroundColor = .clear
    firstButton.titleLabel?.adjustsFontSizeToFitWidth = true
    firstButton.titleLabel?.minimumScaleFactor = 0.5
    
    //Second Button
    secondButton.layer.borderWidth = 3
    secondButton.layer.cornerRadius = 20
    secondButton.layer.borderColor = UIColor.white.cgColor
    secondButton.backgroundColor = .clear
    secondButton.titleLabel?.adjustsFontSizeToFitWidth = true
    secondButton.titleLabel?.minimumScaleFactor = 0.5
    
    //Third Button
    thirdButton.layer.borderWidth = 3
    thirdButton.layer.cornerRadius = 20
    thirdButton.layer.borderColor = UIColor.white.cgColor
    thirdButton.backgroundColor = .clear
    thirdButton.titleLabel?.adjustsFontSizeToFitWidth = true
    thirdButton.titleLabel?.minimumScaleFactor = 0.5
    
    //Forth Button
    fourthButton.layer.borderWidth = 3
    fourthButton.layer.cornerRadius = 20
    fourthButton.layer.borderColor = UIColor.white.cgColor
    fourthButton.backgroundColor = .clear
    fourthButton.titleLabel?.adjustsFontSizeToFitWidth = true
    fourthButton.titleLabel?.minimumScaleFactor = 0.5
    
    //Qyestion View
    questionsView.backgroundColor = .clear

    
    //views
    topView.backgroundColor = .clear
    firstButtonView.backgroundColor = .clear
    secondButtonView.backgroundColor = .clear
    thirdButtonView.backgroundColor = .clear
    fourthButtonView.backgroundColor = .clear
    //

    
    valueScoreLabel.text = ""
    questionsLabel.text = ""
    updateScreen()
  }
  
  
  @IBAction func answerButtonPressed(_ sender: UIButton) {
    let userAnswer = sender.currentTitle!
    if question.getAnswer(userAnswer){
      sender.backgroundColor = UIColor.green
    }else{
      sender.backgroundColor = UIColor.red
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    sender.backgroundColor = UIColor.clear})
    
    if question.getNextQuestion(){
      timer = Timer.scheduledTimer(timeInterval: 0.5
                                   , target: self
                                   , selector: #selector(updateScreen)
                                   , userInfo: nil
                                   , repeats: true)
    } else {
      resultAlert ()
    }
  }
  
  
  @objc func updateScreen (){
    
    questionsLabel.text = question.getQuestion()
    progressBarView.progress = question.getProgress()
    valueScoreLabel.text = "\(question.getScore())"
    firstButton.setTitle(question.checkChoices()[0], for: .normal)
    secondButton.setTitle(question.checkChoices()[1], for: .normal)
    thirdButton.setTitle(question.checkChoices()[2], for: .normal)
    fourthButton.setTitle(question.checkChoices()[3], for: .normal)
  }
  
  
  func  hasUserGoodScore(){
    
    if question.getRightAnswers() > question.getWrongAnswers() {
      playSound(name: "clap")
      print("Yay 🥳")
    }else{
      playSound(name: "fail")
      print("Nay 🙁")
    }
  }
  
  
  func playSound(name:String) {
    
    if  let pathSound = Bundle.main.path(forResource:name, ofType: "wav"){
      let url = URL(fileURLWithPath: pathSound)
      audioPlayer = try! AVAudioPlayer(contentsOf: url)
      audioPlayer.play()
    }
    print("It Works Good For You You Aisha")
  }
  
  
  func resultAlert(){
    
    hasUserGoodScore()
    let resetAlert = UIAlertController(title: "The Game is Over"
                                       , message: "Your Score is \(question.getScore()) out of \(question.questionsArrayLength())\nTotal Correct answers:  \(question.getRightAnswers())"
                                       , preferredStyle: .alert)
    
    resetAlert.addAction(UIAlertAction(title: "Play Again",
                                       style: UIAlertAction.Style.default
                                       ,handler: (startGameAgain)))
    present(resetAlert, animated: true)
  }
  
  
  func startGameAgain(action:UIAlertAction){
    question.startGame()
    audioPlayer.stop()
  }
}

