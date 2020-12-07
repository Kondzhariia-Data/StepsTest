//
//  UIViewController+Additionals.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright © 2020 Steps. All rights reserved.
//

import UIKit

extension UIViewController {

    public func prepareRoute(for segue: UIStoryboardSegue, router: NSObjectProtocol?) {
        guard let identifier = segue.identifier else {
            return
        }

        let selector = NSSelectorFromString("routeTo\(identifier)WithSegue:")

        guard let router = router, router.responds(to: selector) else {
            return
        }

        router.perform(selector, with: segue)
    }
}
