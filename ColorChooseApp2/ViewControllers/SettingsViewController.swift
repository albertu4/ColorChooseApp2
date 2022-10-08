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
    
    //MARK: - Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        colorWindowView.layer.cornerRadius = 10
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self
        
        setColor()
        transferSliderToValue(redColorSlider, greenColorSlider, blueColorSlider)
        changeColor()
    }
    
    //MARK: - IBActions
    @IBAction func doneButtonPressed() {
        delegate.receiveColor(colorWindowView.backgroundColor ?? .white)
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
    private func setColor() {
        let ciColor = CIColor(color: mainViewColor)
        
        redColorSlider.value = Float(ciColor.red)
        greenColorSlider.value = Float(ciColor.green)
        blueColorSlider.value = Float(ciColor.blue)
    }
    
    private func string(_ slider: UISlider) -> String{
        String(format: "%.2f", slider.value)
    }
    
    private func transferSliderToValue(_ sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case redColorSlider:
                valueOfRed.text = string(slider)
                redColorTF.text = string(slider)
            case greenColorSlider:
                valueOfGreen.text = string(slider)
                greenColorTF.text = string(slider)
            default:
                valueOfBlue.text = string(slider)
                blueColorTF.text = string(slider)
            }
        }
    }
    
    private func changeColor() {
        colorWindowView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

//MARK: - TextField
extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let currentValue = Float(value)
        else { return showAlert(title: "Invalid values",
                                and: "Input the correct values") }
        
        if textField == redColorTF {
            redColorSlider.setValue(currentValue, animated: true)
            transferSliderToValue(redColorSlider)
        } else if textField == greenColorTF {
            greenColorSlider.setValue(currentValue, animated: true)
            transferSliderToValue(greenColorSlider)
        } else {
            blueColorSlider.setValue(currentValue, animated: true)
            transferSliderToValue(blueColorSlider)
        }
        
        changeColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexibleButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolBar.items = [flexibleButton, doneButton]
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
