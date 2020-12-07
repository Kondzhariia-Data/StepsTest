//
//  CompositeAppDelegate.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright © 2020 Steps. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {

    private let appDelegates: [AppDelegateType]

    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
}

// MARK: - Startup Configurator AppDelegate
class StartupConfigurator: AppDelegateType {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set navigation bar apperance
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = R.color.royalBlue()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: R.color.royalBlue()!]

        return true
    }
}

// MARK: - Third Parties Configurator AppDelegate
class ThirdPartiesConfigurator: AppDelegateType {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = R.color.royalBlue()

        return true
    }
}
