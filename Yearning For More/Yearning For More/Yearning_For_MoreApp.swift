//
//  Yearning_For_MoreApp.swift
//  Yearning For More
//
//  Created by Yash Chitneni on 2/7/25.
//

import SwiftUI

@main
struct Yearning_For_MoreApp: App {
    @State private var walletModel = WalletConnectionViewModel()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(model: walletModel)
        }
    }
}
