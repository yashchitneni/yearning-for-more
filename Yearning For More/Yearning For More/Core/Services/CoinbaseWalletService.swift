import Foundation
import Combine
import CoinbaseWalletSDK

final class CoinbaseWalletService: WalletService {
    // MARK: - Properties
    
    let connectionState = CurrentValueSubject<WalletConnectionState, Never>(.disconnected)
    let balance = CurrentValueSubject<Double?, Never>(nil)
    
    private let clientId = "YOUR_CLIENT_ID" // TODO: Move to configuration
    private let callbackURL = URL(string: "yfm://")! // TODO: Move to configuration
    private var activeAccount: String?
    
    var isConnected: Bool {
        activeAccount != nil
    }
    
    // MARK: - Initialization
    
    init() {}
    
    // MARK: - WalletService Implementation
    
    func initialize() async throws {
        // Initialize Coinbase Wallet SDK
        CoinbaseWalletSDK.configure(
            clientId: clientId,
            initialActions: [.requestAccounts],
            callbackURLScheme: callbackURL.scheme ?? "yfm"
        )
    }
    
    func connect() async throws {
        connectionState.send(.connecting)
        
        do {
            // Request wallet connection
            let accounts = try await withCheckedThrowingContinuation { continuation in
                Task {
                    do {
                        let response = try await CoinbaseWalletSDK.shared.initiateHandshake(
                            initialActions: [.requestAccounts]
                        )
                        
                        switch response.result {
                        case .success(let accounts):
                            continuation.resume(returning: accounts)
                        case .failure(let error):
                            continuation.resume(throwing: WalletError.connectionFailed)
                        }
                    } catch {
                        continuation.resume(throwing: WalletError.unknown(error))
                    }
                }
            }
            
            guard let account = accounts.first else {
                throw WalletError.connectionFailed
            }
            
            activeAccount = account
            connectionState.send(.connected(address: account))
            
            // Fetch initial balance
            try await fetchBalance()
            
        } catch {
            connectionState.send(.error(error))
            throw error
        }
    }
    
    func disconnect() async {
        activeAccount = nil
        balance.send(nil)
        connectionState.send(.disconnected)
    }
    
    func fetchBalance() async throws -> Double {
        guard let account = activeAccount else {
            throw WalletError.notInitialized
        }
        
        // TODO: Implement USDC balance check using Web3 calls
        // For now, return mock balance
        let mockBalance = 100.0
        balance.send(mockBalance)
        return mockBalance
    }
}

// MARK: - Helper Extensions

private extension CoinbaseWalletSDK.Result {
    var accounts: [String]? {
        switch self {
        case .success(let response):
            return response.values?["accounts"] as? [String]
        case .failure:
            return nil
        }
    }
} 