import UIKit

class GameViewController: UIViewController {
    
    var name: String?
    var remainingTime = 60
    var maxBubbles:Int = 15
    var currentBubbles:Int = 0
    var timer = Timer()
    var currentScore:Int = 0

    var bubblesViewWidth:Int = 0
    var bubblesViewHeight:Int = 0

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var bubblesView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeLeftLabel.text = "Time left: " + String(remainingTime)
        scoreLabel.text = "Score: " + String(currentScore)

        bubblesViewWidth = Int(bubblesView.bounds.size.width)
        bubblesViewHeight = Int(bubblesView.bounds.size.height)
        // active timer, and generate bubble each second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.generateBubble()
            self.counting()
        }
        
    }
    
    @objc func counting() {
        remainingTime -= 1
        timeLeftLabel.text = "Time left: " + String(remainingTime)
        
        if remainingTime == 0 {
            timer.invalidate()
            
            // show HighScore Screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.navigationItem.setHidesBackButton(true, animated: true)
            
            
            
        }
    }
    
    @objc func generateBubble() {
        if currentBubbles < maxBubbles {
            let bubble = Bubble(backgroundColor: selectColor(), frame: CGRect(x: Int.random(in: 30...bubblesViewWidth-30), y: Int.random(in: 30...bubblesViewHeight-30), width: 20, height: 20))
            bubble.animation()
            bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside)
            bubblesView.addSubview(bubble)
            currentBubbles = currentBubbles + 1
        }
        
    }
    
    func selectColor() -> UIColor {
        var selectedColor:UIColor
        let selectedInt = Int.random(in: 0..<100)
        switch(selectedInt) {
        case 0..<40:
            selectedColor = .red
        case 40..<70:
            selectedColor = .systemPink
        case 70..<85:
            selectedColor = .green
        case 85..<95:
            selectedColor = .blue
        default:
            //equivalent to case 95..<100
            selectedColor = .black
        }
        return selectedColor
    }
    
    @IBAction func bubblePressed(_ sender: Bubble) {
        // remove pressed bubble from view
        sender.removeFromSuperview()
        currentBubbles = currentBubbles - 1
        switch(sender.backgroundColor!) {
        case .red:
            currentScore = currentScore + 1
        case .green:
            currentScore = currentScore + 5
        case .blue:
            currentScore = currentScore + 8
        case .black:
            currentScore = currentScore + 10
        default:
            //equivalent to pink
            currentScore = currentScore + 2
        }
        scoreLabel.text = "Score: " + String(currentScore)
    }
    
  


}
