import SwiftUI
import Inject

struct OnboardingView: View {
    @ObserveInjection var inject
    let model: WalletConnectionViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            VStack(spacing: 16) {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.tint)
                
                Text("Welcome to Yearning")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Connect your Coinbase Wallet to start earning yield on your USDC deposits.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 60)
            
            Spacer()
            
            // Wallet Status
            if model.isWalletConnected {
                connectedWalletView
            }
            
            Spacer()
            
            // Action Button
            actionButton
            
            // Help Link
            Button("Need help?") {
                // TODO: Implement help action
            }
            .font(.footnote)
            .padding(.bottom, 16)
        }
        .padding()
        .background(Color(.systemBackground))
        .enableInjection()
    }
    
    private var connectedWalletView: some View {
        VStack(spacing: 16) {
            Text("Wallet Connected")
                .font(.headline)
                .foregroundStyle(.green)
            
            Text(model.walletAddress)
                .font(.subheadline)
                .monospaced()
            
            if model.availableBalance > 0 {
                Text("Available Balance: $\(model.availableBalance, specifier: "%.2f")")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color(.secondarySystemBackground)))
    }
    
    private var actionButton: some View {
        Button(action: {
            if model.isWalletConnected {
                model.disconnectWallet()
            } else {
                Task {
                    await model.connectWallet()
                }
            }
        }) {
            HStack {
                if model.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: model.isWalletConnected ? "link.badge.minus" : "link.badge.plus")
                }
                
                Text(model.isWalletConnected ? "Disconnect Wallet" : "Connect Wallet")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(model.isWalletConnected ? Color.red : Color.accentColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .disabled(model.isLoading)
    }
} 