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
    
    let BUBBLE_WIDTH_HEIGHT:CGFloat = 20.0

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
    
    func checkOverlap(x: CGFloat, y: CGFloat, view: UIView, offset: CGFloat) -> Bool{
        for case let bubble as Bubble in view.subviews {
            let current_x = bubble.frame.origin.x
            let current_y = bubble.frame.origin.y
            /*
            print("x: " + String(Float(x)))
            print("Current x: " + String(Float(current_x)))
            print("x: " + String(Float(x)))
            print("Current y: " + String(Float(current_y)))
            print("Subviews count:" + String(view.subviews.count))
             */
            
            if((x >= current_x - offset && x <= current_x + offset) && (y >= current_y - offset && y <= current_y + offset)){
                //OVERLAP
                print("overlap")
                return true
            }
        }
        // NO OVERLAP
        print("no overlap")
        return false
    }
    
    @objc func generateBubble() {
        if currentBubbles < maxBubbles {
            var xPos:CGFloat = 0.0
            var yPos:CGFloat = 0.0
            repeat {
                xPos = CGFloat(Int.random(in: 30...bubblesViewWidth-30))
                yPos = CGFloat(Int.random(in: 30...bubblesViewHeight-30))
                print("x: " + String(Float(xPos)))
                print("y: " + String(Float(yPos)))
            } while(checkOverlap(x: xPos, y: yPos, view: bubblesView, offset: BUBBLE_WIDTH_HEIGHT*2))
            
            let bubble = Bubble(backgroundColor: selectColor(), frame: CGRect(x: xPos, y: yPos, width: BUBBLE_WIDTH_HEIGHT, height: BUBBLE_WIDTH_HEIGHT))
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
