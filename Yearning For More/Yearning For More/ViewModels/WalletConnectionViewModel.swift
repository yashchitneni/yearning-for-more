import SwiftUI

@Observable final class WalletConnectionViewModel {
    // MARK: - Properties
    var isWalletConnected: Bool = false
    var walletAddress: String = ""
    var availableBalance: Double = 0.0
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Methods
    func connectWallet() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // TODO: Implement Coinbase Wallet SDK connection
            // For now, simulate connection
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
            isWalletConnected = true
            walletAddress = "0x..." // Will be replaced with actual wallet address
            availableBalance = 0.0
        } catch {
            errorMessage = "Failed to connect wallet: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func disconnectWallet() {
        isWalletConnected = false
        walletAddress = ""
        availableBalance = 0.0
        errorMessage = nil
    }
} 