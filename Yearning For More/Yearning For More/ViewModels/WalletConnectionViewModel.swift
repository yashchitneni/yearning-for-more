import SwiftUI
import Combine

@Observable final class WalletConnectionViewModel {
    // MARK: - Properties
    
    private let walletService: WalletService
    private var cancellables = Set<AnyCancellable>()
    
    var isWalletConnected: Bool = false
    var walletAddress: String = ""
    var availableBalance: Double = 0.0
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Initialization
    
    init(walletService: WalletService = CoinbaseWalletService()) {
        self.walletService = walletService
        setupSubscriptions()
    }
    
    // MARK: - Private Methods
    
    private func setupSubscriptions() {
        // Subscribe to wallet connection state changes
        walletService.connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleConnectionState(state)
            }
            .store(in: &cancellables)
        
        // Subscribe to balance updates
        walletService.balance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] balance in
                if let balance = balance {
                    self?.availableBalance = balance
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleConnectionState(_ state: WalletConnectionState) {
        switch state {
        case .disconnected:
            isWalletConnected = false
            walletAddress = ""
            errorMessage = nil
            isLoading = false
            
        case .connecting:
            isLoading = true
            errorMessage = nil
            
        case .connected(let address):
            isWalletConnected = true
            walletAddress = address
            errorMessage = nil
            isLoading = false
            
        case .error(let error):
            isWalletConnected = false
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    // MARK: - Public Methods
    
    func connectWallet() async {
        do {
            // Initialize if needed
            try await walletService.initialize()
            
            // Connect wallet
            try await walletService.connect()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func disconnectWallet() {
        Task {
            await walletService.disconnect()
        }
    }
} 