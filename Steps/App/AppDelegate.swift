//
//  AppDelegate.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//

import UIKit

enum AppDelegateFactory {
    static func makeDefault() -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [StartupConfigurator(), ThirdPartiesConfigurator()])
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let appDelegateFactory = AppDelegateFactory.makeDefault()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = appDelegateFactory.application?(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}

