import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bubbleCountLabel: UILabel!
    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    @IBOutlet weak var startGameButton: UIButton!
    
    let minutes = Array(0...5)
    let seconds = Array(0...59)
    var selectedMinutes:Int = 1
    var selectedSeconds:Int = 0
    var enteredName:String = ""
    
    @IBAction func nameTextFieldEditingChanged(_ sender: UITextField) {
        enteredName = sender.text!
        checkStartConditions()
    }
    func checkStartConditions() {
        if !(selectedMinutes == 0 && selectedSeconds == 0) && !enteredName.isEmpty {
            startGameButton.isEnabled = true
        }
        else {
            startGameButton.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        minutePicker.dataSource = self
        minutePicker.delegate = self
        secondPicker.dataSource = self
        secondPicker.delegate = self
        nameTextField.delegate = self
        minutePicker.selectRow(1, inComponent: 0, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == minutePicker {
            return minutes.count
        }
        else if pickerView == secondPicker {
            return seconds.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == minutePicker {
            selectedMinutes = minutes[row]
            return String(minutes[row]) + " min"
        }
        else if pickerView == secondPicker {
            selectedSeconds = seconds[row]
            return String(seconds[row]) + " sec"
        }
            return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == minutePicker {
            selectedMinutes = minutes[row]
        }
        else if pickerView == secondPicker {
            selectedSeconds = seconds[row]
        }
        checkStartConditions()
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func bubbleCountSliderValueChanged(_ sender: UISlider) {
        bubbleCountLabel.text = String(Int(sender.value))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let VC = segue.destination as! GameViewController
            VC.name = enteredName
            VC.remainingTime = Int(selectedMinutes * 60 + selectedSeconds)
            VC.maxBubbles = Int(bubbleCountLabel.text!)!
        }
    }
    
  
}
