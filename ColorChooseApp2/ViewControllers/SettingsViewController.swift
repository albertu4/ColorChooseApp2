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
    
    var mainViewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
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
        
        mainViewColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        //default color
        redColorSlider.value = Float(red)
        greenColorSlider.value = Float(green)
        blueColorSlider.value = Float(blue)
        
        transferSliderToValue(redColorSlider)
        transferSliderToValue(greenColorSlider)
        transferSliderToValue(blueColorSlider)
        
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
            transferSliderToValue(redColorSlider)
        case greenColorSlider:
            transferSliderToValue(greenColorSlider)
        default:
            transferSliderToValue(blueColorSlider)
        }
    }
    
    //MARK: - Private Methods
    private func transferSliderToValue(_ slider: UISlider) {
        switch slider {
        case redColorSlider:
            valueOfRed.text = String(format: "%.2f", redColorSlider.value)
            redColorTF.text = String(format: "%.2f", redColorSlider.value)
        case greenColorSlider:
            valueOfGreen.text = String(format: "%.2f", greenColorSlider.value)
            greenColorTF.text = String(format: "%.2f", greenColorSlider.value)
        default:
            valueOfBlue.text = String(format: "%.2f", blueColorSlider.value)
            blueColorTF.text = String(format: "%.2f", blueColorSlider.value)
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
        else { return showAlert(title: "Invalid values", and: "Input the correct values") }
        
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
        return true
    }
}

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
