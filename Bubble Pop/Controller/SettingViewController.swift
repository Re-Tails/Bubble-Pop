import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var bubbleCountLabel: UILabel!
    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bubbleCountSliderValueChanged(_ sender: UISlider) {
        bubbleCountLabel.text = String(Int(sender.value))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            /*
            VC.name = nameTextField.text!
            VC.remainingTime = Int(timeSlider.value)
             */
        }
    }
  
}
