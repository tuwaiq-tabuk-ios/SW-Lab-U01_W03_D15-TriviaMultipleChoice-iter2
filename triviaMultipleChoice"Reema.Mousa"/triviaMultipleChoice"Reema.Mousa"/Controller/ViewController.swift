
import UIKit
import AVFoundation
class ViewController: UIViewController {
  
  var currenrQuastion = QuastionBank()
  var score1 = 0
  var questionNumber = 0
  var player : AVAudioPlayer?

  //topView
  @IBOutlet weak var score: UILabel!
  @IBOutlet weak var scoreValue: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  //Butoon
  @IBOutlet weak var firstButton: UIButton!
  @IBOutlet weak var socendButto: UIButton!
  @IBOutlet weak var thirdButton: UIButton!
  @IBOutlet weak var furthButton: UIButton!
  //progress
  @IBOutlet weak var progress: UIProgressView!
  //Views
  
  
  @IBOutlet weak var questionView: UIView!
  
  @IBOutlet weak var centrallView: UIView!
  
  @IBOutlet weak var bottomView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
    progress.progress = 0.0
    
    // Do any additional setup after loading the view.
    
    //scorelavel
    score.layer.cornerRadius = 10
    score.layer.borderWidth = 3
    score.layer.borderColor = UIColor.white.cgColor
    //quiestion
    questionLabel.layer.cornerRadius = 10
    questionLabel.layer.borderWidth = 3
    questionLabel.layer.borderColor = UIColor.white.cgColor
    //Buttons
    //#1
    firstButton.layer.cornerRadius = 10
    firstButton.layer.borderWidth = 3
    firstButton.layer.borderColor = UIColor.white.cgColor
    
    //#2
    socendButto.layer.cornerRadius = 10
    socendButto.layer.borderWidth = 3
    socendButto.layer.borderColor = UIColor.white.cgColor
    //#3
    thirdButton.layer.cornerRadius = 10
    thirdButton.layer.borderWidth = 3
    thirdButton.layer.borderColor = UIColor.white.cgColor
    //#4
    
    furthButton.layer.cornerRadius = 10
    furthButton.layer.borderWidth = 3
    furthButton.layer.borderColor = UIColor.white.cgColor
    
    
    //Views
    
   questionView.layer.cornerRadius = 10
    questionView.layer.borderWidth = 3
    questionView.layer.borderColor = UIColor.white.cgColor
    
  centrallView.layer.cornerRadius = 10
    centrallView.layer.borderWidth = 3
    centrallView.layer.borderColor = UIColor.white.cgColor
    
    
  bottomView.layer.cornerRadius = 10
    bottomView.layer.borderWidth = 3
    bottomView.layer.borderColor = UIColor.white.cgColor
  }
  
  @IBAction func anwerPressed(_ sender: UIButton)
  {
    
    let  checkAnswer = sender.currentTitle!
    
    if  currenrQuastion.rightAnswer(checkAnswer)
    
    { sender.backgroundColor = UIColor.green
      
    } else {
      sender.backgroundColor = UIColor.red
    }
    
    DispatchQueue.main.asyncAfter(deadline:.now() + 0.2, execute: {
                                    sender.backgroundColor = UIColor.clear})
    
    if currenrQuastion.nextQuestion()
    {
      Timer.scheduledTimer(timeInterval:1.5,
                           target: self,
                           selector: #selector(updateUI),
                           userInfo: nil,
                           repeats: true ) }
    else {
      
      showAleart()
   
      
    }
  }
  
  @objc func updateUI (){
    
    questionLabel.text = currenrQuastion.getQuestion()
    scoreValue.text = " \(currenrQuastion.getScore())"
    progress.progress = currenrQuastion.progrssBar()
    
    firstButton.setTitle(currenrQuastion.checkAnswers()[0],for:.normal)
    
    socendButto.setTitle(currenrQuastion.checkAnswers()[1],for:.normal)
    
    thirdButton.setTitle(currenrQuastion.checkAnswers()[2],for:.normal)
    
    furthButton.setTitle(currenrQuastion.checkAnswers()[3],for:.normal)
  }
  
  func showAleart() {
    
    let resetAleart = UIAlertController(
      title: "GAME OVER",
      message: "YOUR SCORE IS \(currenrQuastion.getScore()) out of 10  your Answered \(currenrQuastion.getright())",
      preferredStyle: .alert)
    
    resetAleart.addAction(UIAlertAction(title: "play again",
                                        style: UIAlertAction.Style.default,
                                        handler: startGame))
    present(resetAleart,animated: true)
    
    hasUserGoodScore()
  }
  
  
  func startGame (action: UIAlertAction)
  {
    currenrQuastion.startGame()
    stopSound()
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
  func stopSound(){
    player?.stop()
  }
  
  func hasUserGoodScore()
  {
    if currenrQuastion.getright() > currenrQuastion.getwrong()
    
    {
      playSound()
    }
  

}

}
