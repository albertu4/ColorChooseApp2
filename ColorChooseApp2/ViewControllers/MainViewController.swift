//
//  MainViewController.swift
//  ColorChooseApp2
//
//  Created by Михаил Иванов on 08.02.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func receiveColor(view: UIColor)
}

class MainViewController: UIViewController {

    @IBOutlet var mainView: UIView!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController
        else { return }
        settingsVC.mainViewColor = mainView.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func receiveColor(view: UIColor) {
        mainView.backgroundColor = view
    }
}
