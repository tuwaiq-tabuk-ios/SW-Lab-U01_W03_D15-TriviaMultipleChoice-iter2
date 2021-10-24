//
//  ViewController.swift
//  TriviaMultipleChoice"rawabi Ahmed
//
//  Created by روابي باجعفر on 15/03/1443 AH.
//

import UIKit
import AVFoundation
var valuescore = QuizManager()
var timer:Timer = Timer()
var wrongQuestion = 0
var rightQuestion = 0
class ViewController: UIViewController {

  @IBOutlet weak var valueScoreLable: UILabel!
  @IBOutlet weak var questionLable: UILabel!
  @IBOutlet weak var firstChoiceButtom: UIButton!
  @IBOutlet weak var secandChoiceBottom: UIButton!
  @IBOutlet weak var thirdChoiceButton: UIButton!
  @IBOutlet weak var fourthChoiceButton: UIButton!
  @IBOutlet weak var progressBottom: UIProgressView!
  
  // Do any additional setup after loading the view.
  
  var quizManager = QuizManager()
  var questionNumber:Int = 0
  var score = 0
  var player: AVAudioPlayer?
  var nextQuestion:Int = 0
  





  override func viewDidLoad() {
    super.viewDidLoad()
    
    questionLable.layer.cornerRadius = 50
        questionLable.layer.borderWidth = 1
        questionLable.layer.masksToBounds = true
    
    
    firstChoiceButtom.layer.cornerRadius = 50
    firstChoiceButtom.layer.borderWidth = 3
    firstChoiceButtom.layer.masksToBounds = true
    firstChoiceButtom.layer.borderColor = UIColor.white.cgColor
    
    secandChoiceBottom.layer.cornerRadius = 50
    secandChoiceBottom.layer.borderWidth = 3
    secandChoiceBottom.layer.masksToBounds = true
    secandChoiceBottom.layer.borderColor = UIColor.white.cgColor
    
    thirdChoiceButton.layer.cornerRadius = 50
    thirdChoiceButton.layer.borderWidth = 3
    thirdChoiceButton.layer.masksToBounds = true
     thirdChoiceButton.layer.borderColor = UIColor.white.cgColor
    
    fourthChoiceButton.layer.cornerRadius = 50
    fourthChoiceButton.layer.borderWidth = 3
    fourthChoiceButton.layer.masksToBounds = true
      fourthChoiceButton.layer.borderColor = UIColor.white.cgColor
    
    updateUI()
    progressBottom.progress = 0.0
    // Do any additional setup after loading the view.
  }
  @IBAction func answerSelected(_ sender: UIButton) {
  
  let userAnswer = sender.currentTitle!
  let check = quizManager.checkAnswer(userAnswer)
  
  if check{
    sender.backgroundColor = UIColor.green
  }
  else {
    sender.backgroundColor = UIColor.red
  }
  
  
  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
  
  
  if quizManager.nextQuestion() {
    
  }
  else {
    showAlertView()
  }
}
  @objc func updateUI() {
  questionLable.text = quizManager.checkQuestion()
    progressBottom.progress = quizManager.checkProgress()
    valueScoreLable.text = "\(quizManager.checkScore())"
    
    
    firstChoiceButtom.backgroundColor = UIColor.clear
    secandChoiceBottom.backgroundColor = UIColor.clear
    thirdChoiceButton.backgroundColor = UIColor.clear
    fourthChoiceButton.backgroundColor = UIColor.clear
    
    
    firstChoiceButtom.setTitle(quizManager.checkChoices()[0], for: .normal);
    secandChoiceBottom.setTitle(quizManager.checkChoices()[1], for: .normal)
    thirdChoiceButton.setTitle(quizManager.checkChoices()[2], for: .normal)
    fourthChoiceButton.setTitle(quizManager.checkChoices()[3], for: .normal)
  }
  
 
  func hasUserGoodScore() {
    if rightQuestion > wrongQuestion{
      playSound()
    }
  }
  
  
  func showAlertView() {
    let alert = UIAlertController(title: "End game 🥳", message: "play agine?", preferredStyle: .alert)
  
    alert.addAction(UIAlertAction(title: "yes", style: .cancel, handler: {action in
      print("yes clicked")
      self.start()
      
    }))
    alert.addAction(UIAlertAction(title: "no", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    playSound()
  }
  
  



func playSound() {
  guard let url = Bundle.main.url(forResource: "clapping", withExtension: "mp3") else { return }
  
  do {
    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
    try AVAudioSession.sharedInstance().setActive(true)
    
    /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    
    /* iOS 10 and earlier require the following line:
     player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
    
    guard let player = player else { return }
    
    player.play()
    
  } catch let error {
    print(error.localizedDescription)
  }
  
  }

func start() {
  quizManager.start()
  updateUI()
}

}
