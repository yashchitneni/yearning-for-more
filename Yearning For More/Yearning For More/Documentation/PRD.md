1. Product Overview
1.1. Purpose and Vision
Purpose:
Develop an iPhone mobile app that offers a streamlined, user-friendly experience for depositing USDC into a single Yearn V3 vault on Base. The goal is to let users deposit fiat (via Coinbase’s Wallet SDK onboarding) and see, at a glance, their deposit amount, deposit history (with yield earned), and later enable a withdrawal flow to move funds back to their bank account.

Vision:

Enable users to “click a button” to move money from their bank account (via Coinbase onramp) into USDC, then automatically deposit that USDC into a Yearn V3 vault.
Provide clear, near up-to-date yield tracking (with periodic updates every few minutes or per new block).
Abstract away blockchain complexity by using proven SDKs and libraries so that developers can focus on delivering a great mobile experience.
1.2. Scope
In Scope:

Fiat Onramp:
Integrate Coinbase Wallet SDK to leverage existing KYC processes and provide a simple fiat-to-USDC conversion flow.
Blockchain Interaction:
Interact with the Yearn V3 vault smart contract on Base (an OP stack network on Ethereum) to deposit and later withdraw USDC.
User Interface:
A single homepage displaying:
Total deposited amount into the vault.
A chronological list of deposit events with associated yield earned.
Buttons for depositing (and later withdrawing) funds.
Yield Reporting:
Yield data should be updated as close to real-time as practical (e.g. every block or every few minutes) to ensure users see current information.
Single Vault Focus:
The application is designed for a single USDC vault. No additional vaults will be supported for now.
Out of Scope:

Support for multiple vaults or additional asset types.
Custom fiat conversion flows beyond the Coinbase Wallet SDK solution.
Extensive multi-chain interactions—only the Yearn V3 vault on Base will be used.
1.3. Target Audience
Users with basic familiarity with crypto (enough to know what USDC and yield are) who may not have a dedicated wallet but are comfortable linking a Coinbase account.
Individuals seeking a simple, “one-click” experience to earn yield on their USDC.
Early adopters who appreciate a minimalist, mobile-first design.
2. Detailed Functional Requirements
2.1. User Authentication & Onboarding
Coinbase Wallet SDK Integration:
Use the Coinbase Wallet SDK to handle user authentication.
On first use, the app should prompt users to log in via Coinbase Wallet.
If users do not have an existing Coinbase account or wallet, the onboarding flow must guide them to create one.
Leverage Coinbase’s existing KYC so that users do not need to repeat verification within the app.
2.2. Fiat-to-USDC Conversion Flow
Conversion Flow Steps:
Initiate Deposit:
A “Deposit Funds” button on the homepage triggers the Coinbase onramp flow.
Onramp Process:
Through the Coinbase Wallet SDK, the user will:
Link a bank account or card.
Convert fiat (USD, EUR, etc.) to USDC.
Confirmation:
Once the conversion is complete, the USDC is automatically prepared for deposit into the Yearn V3 vault.
2.3. Blockchain Interaction for Deposits and Withdrawals
Deposit Functionality:

Smart Contract Interaction:
Use a web3 SDK (or an additional library if available) to call the Yearn V3 vault’s deposit function.
Transaction Flow:
After the Coinbase onramp delivers USDC, a signed transaction is created to deposit the USDC into the Yearn V3 vault on Base.
Transaction signing is handled via Coinbase Wallet SDK’s provider (which will open a deep link for the user to approve).
User Confirmation:
The UI must update to reflect a “pending” state until the blockchain confirms the deposit.
Withdrawal Functionality:

Reverse Flow:
A “Withdraw Funds” button initiates a transaction that calls the vault’s withdrawal function.
Automated Steps:
After withdrawal from the vault, the funds are transferred back to the Coinbase wallet and then can be offramped via Coinbase (or manually withdrawn by the user).
2.4. Yield Information and Display
Yield Calculation:
Query the Yearn V3 vault smart contract for yield data.
Update yield figures every few minutes or per new block (as network conditions allow) to keep information “up-to-date.”
Yield values should be displayed as:
Total yield earned since the first deposit.
Yield per deposit (if available).
UI Requirements:
Display a continuously updating “live” yield counter on the homepage.
List historical deposit transactions with timestamps, deposit amounts, and yield gained.
2.5. User Interface (UI/UX) Requirements
Homepage:
Summary Section:
Total amount deposited, current yield, and current balance in the vault.
Transaction History:
A scrollable list showing each deposit event and the incremental yield earned.
Action Buttons:
“Deposit Funds” and “Withdraw Funds” buttons placed prominently.
Navigation:
Simple tab-based navigation if additional pages (like settings or transaction details) are needed.
Design Principles:
iOS design guidelines (SwiftUI/Apple Human Interface Guidelines).
Minimalist and intuitive UI focused on usability with clear call-to-action buttons.
Error Handling:
Clear error messages for failed bank transfers, transaction rejections, or blockchain errors.
Include retry options and fallback instructions if transactions fail.
3. Technical Architecture Document
3.1. High-Level Architecture Diagram
(Provide a diagram if possible in Cursor. Otherwise, describe the components below.)

Frontend (iOS App):
Built in Swift/SwiftUI.
Integrates the Coinbase Wallet SDK for user authentication, fiat conversion, and wallet operations.
Uses a web3 library (or a convenient SDK) to communicate with the Yearn V3 vault smart contract on Base.
Backend (Optional):
Minimal backend required for logging or analytics (could be hosted on Cursor or integrated via a serverless solution).
All core transactions occur on-chain; backend is only for supplemental features.
Blockchain Integration:
USDC Deposit Flow:
Coinbase Wallet SDK converts fiat to USDC.
USDC is sent to a smart contract interaction layer (via wallet provider).
Transaction calls the Yearn V3 vault deposit function.
Withdrawal Flow:
A withdrawal request triggers a transaction from the vault.
Funds are sent back to the user’s wallet.
APIs and SDKs:
Coinbase Wallet SDK: Handles authentication, fiat onramp, and wallet interactions.
Additional Web3/SDK Libraries:
If available, an SDK that simplifies ERC4626 vault interactions may be used; otherwise, use standard libraries (e.g., ethers.js) for contract calls.
3.2. Data Flow Diagram
User Initiates Deposit:
User taps “Deposit Funds.”
The app invokes Coinbase Wallet SDK’s onboarding and fiat conversion flow.
USDC Receipt:
Once USDC is received by the wallet, the app automatically prepares a deposit transaction.
Blockchain Transaction:
The app uses the web3 provider from Coinbase Wallet SDK to sign and submit a deposit transaction to the Yearn V3 vault on Base.
Transaction Confirmation:
Upon blockchain confirmation, the yield calculation logic fetches updated balance and yield data.
Display Update:
The UI refreshes the total deposited and yield information on the homepage.
Withdrawal Flow:
A similar process is followed for withdrawing funds, with a reverse transaction from the vault back to the wallet.
3.3. Smart Contract Interactions
Vault Contract (Yearn V3):
Use standard ERC4626 functions:
deposit(uint256 amount, address receiver)
withdraw(uint256 shares, address receiver, address owner)
Read functions to fetch yield and balance:
balanceOf(address owner)
Additional methods provided in the Yearn V3 documentation for yield tracking.
Coinbase Wallet Provider:
Provider methods to request accounts, sign transactions, and handle events.
Error handling for user cancellation or transaction failures.
3.4. Security & Compliance
Security Measures:
Use Coinbase Wallet SDK for secure user authentication and fiat conversion.
Leverage built-in security protocols from Coinbase (KYC/AML compliance).
Ensure all on-chain interactions are signed by the user’s wallet.
Validate and sanitize all input and responses.
Compliance:
Follow all relevant regulatory requirements by offloading KYC and AML to Coinbase.
Store minimal sensitive data locally; ideally, do not store private keys or user credentials on the device.
Error & Exception Handling:
Implement robust error handling for network issues, failed transactions, and blockchain reorgs.
Display informative messages and provide a clear path for retries.
4. Testing & Quality Assurance
4.1. Testing Strategy
Unit Tests:
Write unit tests for each critical function (e.g., deposit, withdrawal, yield update calculations).
Test integration of Coinbase Wallet SDK functions in isolation.
Integration Tests:
Test the full end-to-end flow: fiat onramp → USDC conversion → smart contract deposit → yield update → withdrawal.
Use a test network (e.g., Ethereum testnet for Base if available) to simulate blockchain interactions.
User Acceptance Testing (UAT):
Conduct beta tests with a small group of users familiar with crypto to ensure that the UI is intuitive and the flows work as expected.
Gather feedback on the clarity of error messages and the overall user experience.
Security Testing:
Verify that all transactions are properly signed and that no sensitive data is stored insecurely.
Perform penetration tests on the app to check for vulnerabilities in the integration points.
4.2. Quality Assurance
Use continuous integration (CI) tools to run tests on each commit.
Manual testing sessions to simulate network slowdowns or failures in Coinbase onramp.
Monitor on-chain transactions in a staging environment before going live.
5. Timeline & Milestones
5.1. Development Phases
Phase 1: Onboarding and Fiat Conversion Integration (Week 1-2)
Set up the Coinbase Wallet SDK in the iOS app.
Implement the user authentication and fiat conversion flow.
Phase 2: Smart Contract Interaction & Blockchain Transaction Flow (Week 3-4)
Develop the deposit transaction flow from wallet to Yearn V3 vault.
Implement transaction signing and error handling.
Phase 3: Yield Data Fetching and UI Updates (Week 5-6)
Integrate yield calculation queries.
Design and develop the homepage UI to display deposit and yield history.
Phase 4: Withdrawal Flow & End-to-End Testing (Week 7-8)
Implement the withdrawal functionality.
Conduct unit, integration, and user acceptance testing.
Phase 5: Final QA and Deployment Preparation (Week 9)
Finalize error handling and security tests.
Prepare documentation and deploy the MVP.
5.2. Milestones
Milestone 1: Coinbase Wallet SDK integration complete.
Milestone 2: Successful deposit flow to Yearn V3 vault on testnet.
Milestone 3: Real-time yield display updated on the UI.
Milestone 4: Withdrawal process fully functional on testnet.
Milestone 5: QA sign-off and MVP deployment to production.
6. Appendices & Supporting Documents
6.1. External Documentation References
Coinbase Wallet SDK Documentation:
Refer to Coinbase Wallet SDK Docs for detailed integration examples and API usage.
Yearn V3 Vault Documentation:
See Yearn Docs for V3 for specifics on ERC4626 functionality and yield calculations.
ERC4626 Standard:
For technical details on vault standards, consult the ERC4626 EIP.
6.2. Glossary
USDC: A stablecoin pegged to the US Dollar.
Yearn V3 Vault: A yield-generating contract that uses ERC4626 standards to manage deposits and yield.
Base Network: An OP stack network on Ethereum where the Yearn V3 vault is deployed.
Coinbase Wallet SDK: A developer toolkit that facilitates integration with Coinbase Wallet, offering onboarding, KYC, and fiat onramp capabilities.
6.3. Open Questions / Clarifications
Are there any additional user notifications required (e.g., SMS or push notifications for transaction status)?
What are the specific performance targets for yield data update frequency (e.g., maximum acceptable delay in seconds/minutes)?
Should we incorporate analytics for user behavior on deposit/withdraw flows for future optimizations?
What is the expected fallback if the Coinbase onramp fails mid-transaction?
7. Conclusion
This set of PRD documents provides a comprehensive guide to building your iPhone application that uses the Coinbase Wallet SDK to deposit USDC into a single Yearn V3 vault on Base. With detailed sections on user flows, technical architecture, security, testing, and milestones, this documentation is designed to be directly actionable in Cursor. By following these guidelines, your development team will have a clear roadmap for creating a secure, user-friendly app with minimal friction and maximum clarity.

These documents should serve as your blueprint for both development and collaboration with any external teams. You can now add them to Cursor, iterate on details as needed, and begin coding your application with a clear understanding of the requirements and integration points.

Additional Screen Requirements
1. Wallet Connection / Onboarding Screen
Purpose:
This is the very first screen users encounter. It explains the need to connect their wallet and guides them through the Coinbase Wallet SDK integration process. It should clearly indicate that the app uses Coinbase Wallet for onboarding and fiat conversion.

Key Elements:

Call-to-Action: A prominent “Connect Your Wallet” button.
Status Display: Once connected, show basic wallet details (e.g., wallet address, connection status, and available balance).
Onboarding Instructions: Brief instructions on what connecting the wallet means and reassurance that Coinbase handles KYC/AML.
Fallback or Help Link: In case of errors or if the user is unfamiliar with the process.
2. Dashboard / Home Page (Post-Connection)
Purpose:
After wallet connection, the dashboard serves as the primary hub for all actions. It should combine the following components:

Key Elements:

Summary Section:
Total Amount Deposited: A clear, at-a-glance display of the total USDC deposited into the Yearn V3 vault.
Current Yield: A dynamic display (updated periodically, e.g. every few minutes or per block) that shows the yield earned.
Transaction History:
A scrollable, chronological list of all deposit and withdrawal transactions, including timestamps, amounts, and yield details.
Action Buttons:
Deposit Funds: Button to initiate the deposit flow.
Withdraw Funds: Button to start the withdrawal process.
Navigation:
Options to move to other pages (e.g., Settings or Detailed Transaction View).
3. Deposit Flow Screen
Purpose:
This screen provides a step-by-step process for depositing funds into the vault.

Key Elements:

Conversion Details: Clear explanation and confirmation that fiat will be converted to USDC via Coinbase Wallet SDK.
Form/Input Fields: If needed, to confirm the deposit amount.
Progress Indicators: Show transaction progress (e.g., “Processing deposit…” with a spinner or progress bar).
Confirmation: A final confirmation message once the deposit is recorded on-chain.
4. Withdrawal Flow Screen
Purpose:
Similar to the deposit flow, this screen details the process for withdrawing USDC from the Yearn vault back into the user’s bank account or wallet.

Key Elements:

Withdrawal Input: Allow the user to specify how much to withdraw.
Explanation: Information about any potential delays or steps involved in converting USDC back to fiat.
Transaction Progress: Visual feedback on the withdrawal’s progress.
Confirmation/Receipt: A summary once the withdrawal is complete.
5. Settings / Account Details Screen
Purpose:
Allow users to manage wallet connection settings and view additional account information.

Key Elements:

Wallet Information: Display connected wallet details and provide options to disconnect or reconnect.
Security Settings: Options for managing notifications or additional security measures.
Help & FAQ Links: Direct users to support or troubleshooting documentation.
6. Error and Notification Screens
Purpose:
Handle various error scenarios (e.g., failed wallet connection, blockchain transaction failures, network issues).

Key Elements:

Clear Error Messages: Inform users what went wrong and suggest actionable steps (like retrying the connection or checking network status).
Recovery Options: Buttons or links to retry the operation or contact support.