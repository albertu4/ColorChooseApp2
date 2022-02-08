//
//  MainViewController.swift
//  ColorChooseApp2
//
//  Created by Михаил Иванов on 08.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.mainViewColor = mainView.backgroundColor
    }
}
