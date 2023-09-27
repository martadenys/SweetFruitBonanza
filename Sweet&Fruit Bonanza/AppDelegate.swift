//
//  AppDelegate.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 21.09.2023.
//

import UIKit
import BAKFramework


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          
          BAKService.shared.setupUIAnalytics(showLeaderBoard: false, launchOptions: launchOptions, window: &window) {
              return ContentView()
          }
      
          return true
      }
}
