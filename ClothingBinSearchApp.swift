//
//  ClothingBinSearchApp.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/09/24.
//

import SwiftUI
//import FirebaseCore
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct ClothingBinSearchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var selectedBinData = SelectedBinData()

    var body: some Scene {
        WindowGroup {
            MapView()
            //environmentObject를 MapView에 넣어줌
                .environmentObject(selectedBinData)
        }
    }
}
