//
//  LaunchViewController.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // delay is made to display animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.performSegue(withIdentifier: R.segue.launchViewController.numbers.identifier, sender: .none)
        }
    }
}
