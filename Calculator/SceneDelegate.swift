//
//  SceneDelegate.swift
//  Calculator
//
//  Created by Marvin Wagner on 19/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Create the SwiftUI view that provides the window contents.
        let contentView = CalculatorView().environmentObject(GlobalEnvironment())

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

