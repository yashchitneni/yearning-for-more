# Yearning For More

A SwiftUI-based iOS application that enables users to deposit USDC into a Yearn V3 vault on Base network, providing a streamlined experience for earning yield on their deposits.

## Features

- 🔐 Secure wallet connection via Coinbase Wallet SDK
- 💱 Seamless fiat-to-USDC conversion
- 📈 Real-time yield tracking
- 💸 Easy deposits and withdrawals
- 🎨 Modern, intuitive SwiftUI interface

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- macOS Ventura 13.0+ (for development)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yashchitneni/yearning-for-more.git
```

2. Open the project in Xcode:
```bash
cd yearning-for-more
xed .
```

3. Install dependencies (if any) and build the project.

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern and is organized as follows:

```
Yearning For More/
├── Features/         # Feature-specific components
├── Models/          # Data models
├── ViewModels/      # View models
├── Views/           # SwiftUI views
├── Core/
│   ├── Extensions/  # Swift extensions
│   └── Services/    # Core services
└── Utils/           # Utility functions
```

## Development

- The project uses SwiftUI for the UI layer
- Implements Coinbase Wallet SDK for wallet management
- Uses hot reloading via the Inject framework for rapid development
- Follows Apple's Human Interface Guidelines

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Coinbase Wallet SDK](https://docs.cloud.coinbase.com/wallet-sdk/docs)
- [Yearn V3 Documentation](https://docs.yearn.finance/)
- [Base Network](https://base.org) 