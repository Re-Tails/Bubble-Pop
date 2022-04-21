import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bubbleCountLabel: UILabel!
    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    
    let minutes = Array(0...5)
    let seconds = Array(0...59)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        minutePicker.dataSource = self
        minutePicker.delegate = self
        secondPicker.dataSource = self
        secondPicker.delegate = self
        nameTextField.delegate = self
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
            return String(minutes[row]) + " min"
        }
        else if pickerView == secondPicker {
            return String(seconds[row]) + " sec"
        }
            return ""
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
            /*
            VC.name = nameTextField.text!
            VC.remainingTime = Int(timeSlider.value)
             */
        }
    }
    
  
}
