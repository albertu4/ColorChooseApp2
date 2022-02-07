//
//  ViewController.swift
//  ColorChooseApp2
//
//  Created by Михаил Иванов on 07.02.2022.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var colorWindowView: UIView!
    
    @IBOutlet var valueOfRed: UILabel!
    @IBOutlet var valueOfGreen: UILabel!
    @IBOutlet var valueOfBlue: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    //MARK: Override method
    override func viewDidLoad() {
        super.viewDidLoad()
        colorWindowView.layer.cornerRadius = 10
        
        transferSliderToValue(redColorSlider)
        transferSliderToValue(greenColorSlider)
        transferSliderToValue(blueColorSlider)
        
        changeColor()
    }
    
    //MARK: IBActions
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
    
    //MARK: Private Methods
    private func transferSliderToValue(_ slider: UISlider) {
        switch slider {
        case redColorSlider:
            valueOfRed.text = String(format: "%.2f", redColorSlider.value)
        case greenColorSlider:
            valueOfGreen.text = String(format: "%.2f", greenColorSlider.value)
        default:
            valueOfBlue.text = String(format: "%.2f", blueColorSlider.value)
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
