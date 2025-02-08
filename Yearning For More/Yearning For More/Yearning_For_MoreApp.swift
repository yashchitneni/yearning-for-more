//
//  Yearning_For_MoreApp.swift
//  Yearning For More
//
//  Created by Yash Chitneni on 2/7/25.
//

import SwiftUI
import CoinbaseWalletSDK

@main
struct Yearning_For_MoreApp: App {
    @State private var walletModel: WalletConnectionViewModel
    
    init() {
        let walletService = CoinbaseWalletService()
        self._walletModel = State(initialValue: WalletConnectionViewModel(walletService: walletService))
    }
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(model: walletModel)
                .onOpenURL { url in
                    // Handle Coinbase Wallet SDK deep links
                    CoinbaseWalletSDK.shared.handleResponse(url)
                }
        }
    }
}
