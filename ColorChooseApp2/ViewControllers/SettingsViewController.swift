//
//  ViewController.swift
//  ColorChooseApp2
//
//  Created by Михаил Иванов on 07.02.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var colorWindowView: UIView!
    
    @IBOutlet var valueOfRed: UILabel!
    @IBOutlet var valueOfGreen: UILabel!
    @IBOutlet var valueOfBlue: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTF: UITextField!
    @IBOutlet var greenColorTF: UITextField!
    @IBOutlet var blueColorTF: UITextField!
    
    //MARK: - Public Properties
    var mainViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: - Private Properties
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    
    
    //MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        colorWindowView.layer.cornerRadius = 10
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self
        
        //default color
        mainViewColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        redColorSlider.value = Float(red)
        greenColorSlider.value = Float(green)
        blueColorSlider.value = Float(blue)
        
        transferSliderToValue(redColorSlider, greenColorSlider, blueColorSlider)
        
        changeColor()
    }
    
    //MARK: - IBActions
    @IBAction func doneButtonPressed() {
        delegate.receiveColor(view: colorWindowView.backgroundColor!)
        dismiss(animated: true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        changeColor()
        switch sender {
        case redColorSlider:
            transferSliderToValue(sender)
        case greenColorSlider:
            transferSliderToValue(sender)
        default:
            transferSliderToValue(sender)
        }
    }
    
    //MARK: - Private Methods
    private func transferSliderToValue(_ sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case redColorSlider:
                valueOfRed.text = makeStringFormat(slider)
                redColorTF.text = makeStringFormat(slider)
            case greenColorSlider:
                valueOfGreen.text = makeStringFormat(slider)
                greenColorTF.text = makeStringFormat(slider)
            default:
                valueOfBlue.text = makeStringFormat(slider)
                blueColorTF.text = makeStringFormat(slider)
            }
        }
    }
    
    private func makeStringFormat(_ slider: UISlider) -> String{
        String(format: "%.2f", slider.value)
    }
    
    private func changeColor() {
        colorWindowView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
}

//MARK: - Extensions
extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue)
        else { return showAlert(title: "Invalid values",
                                and: "Input the correct values") }
        
        if textField == redColorTF {
            redColorSlider.value = numberValue
            transferSliderToValue(redColorSlider)
            changeColor()
        } else if textField == greenColorTF {
            greenColorSlider.value = numberValue
            transferSliderToValue(greenColorSlider)
            changeColor()
        } else {
            blueColorSlider.value = numberValue
            transferSliderToValue(blueColorSlider)
            changeColor()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField)
        view.endEditing(true)
        return true
    }
}

//MARK: - Alert Controller
extension SettingsViewController {
    func showAlert(title: String, and message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
