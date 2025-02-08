import Foundation
import Combine

/// Represents the current state of the wallet connection
enum WalletConnectionState {
    case disconnected
    case connecting
    case connected(address: String)
    case error(Error)
}

/// Errors that can occur during wallet operations
enum WalletError: LocalizedError {
    case notInitialized
    case connectionFailed
    case userRejected
    case networkError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .notInitialized:
            return "Wallet SDK not properly initialized"
        case .connectionFailed:
            return "Failed to connect to wallet"
        case .userRejected:
            return "User rejected the connection request"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

/// Protocol defining wallet interaction capabilities
protocol WalletService: AnyObject {
    /// The current state of the wallet connection
    var connectionState: CurrentValueSubject<WalletConnectionState, Never> { get }
    
    /// The current wallet balance in USDC
    var balance: CurrentValueSubject<Double?, Never> { get }
    
    /// Initialize the wallet service
    func initialize() async throws
    
    /// Connect to the wallet
    func connect() async throws
    
    /// Disconnect from the wallet
    func disconnect() async
    
    /// Get the current USDC balance
    func fetchBalance() async throws -> Double
    
    /// Check if the wallet is currently connected
    var isConnected: Bool { get }
} 