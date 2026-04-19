<div align="center">
  <h1> WalletWise</h1>
  <p>A premium, glassmorphic personal finance and expense tracking application built with Flutter.</p>

  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter Badge" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart Badge" />
  <img src="https://img.shields.io/badge/UI-Glassmorphism-blueviolet?style=for-the-badge" alt="Glassmorphism UI" />
  <img src="https://img.shields.io/badge/Backend-Local_Persistence-success?style=for-the-badge" alt="Local Persistence" />
</div>

<br />

WalletWise is a beautifully engineered mobile application that helps you track your daily income, manage your expenses, and view your financial health at a glance. It features a completely custom, state-of-the-art **Glassmorphism UI** that delivers a highly aesthetic and premium user experience, alongside a fully functioning local device backend for data privacy and zero cloud dependencies.

---

##  Features

- **High-End Glassmorphism UI**: Stunning visual depth featuring dynamic gradients and frosted glass elements natively built in Flutter.
- **Complete Authentication Flow**: Welcoming entry points, simulated secure login, and user registration.
- **Local Data Persistence**: Powered by `shared_preferences`, all your user sessions and transaction data are physically saved to the device—no internet connectivity required.
- **Dynamic Financial Dashboard**: Real-time calculations of your total balance, overall income, and accrued expenses.
- **Fast Transaction Logging**: A streamlined approach to add new earnings or track impulse purchases within seconds.

---

##  Tech Stack

- **Framework**: `Flutter` SDK (^3.0.0)
- **Language**: `Dart`
- **Architecture**: Singleton Provider Pattern (`ChangeNotifier`)
- **Storage/Backend**: `shared_preferences`, `uuid` 
- **Styling**: Vanilla Flutter canvas graphics (`BackdropFilter`, custom BoxDecoration)

---

##  Getting Started

Follow these steps to run the application locally on your machine.

### Prerequisites
Make sure you have Flutter installed on your machine. You can find the installation guide [here](https://docs.flutter.dev/get-started/install).

### 1. Clone the repository
```bash
git clone https://github.com/your-username/wallet_wise.git
cd wallet_wise
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
Connect a physical device via USB or start a virtual emulator, and run:
```bash
flutter run
```

---

## 📂 Project Structure

```text
lib/
├── main.dart                   # Application entry point & Routing
├── models/                     # Data models
│   └── transaction.dart        # Transaction definitions and JSON serialization
├── screens/                    # UI Pages
│   ├── welcome_screen.dart     # Brand introduction
│   ├── login_screen.dart       # User authentication
│   ├── home_screen.dart        # Main dashboard/analytics
│   └── add_transaction_screen.dart # Logging logic
├── services/                   # Application Core logic
│   └── finance_service.dart    # Manages local storage, state, and user sessions
├── theme/                      # Visual identity
│   └── app_theme.dart          # Colors, text themes, backgrounds
└── widgets/                    # Reusable components
    └── glass_container.dart    # Custom blurred widget
```

---

##  UI Showcase

*(Replace these placeholders with actual screenshots from your app before making the repository public)*

| Welcome | Dashboard | Add Transaction |
| :---: | :---: | :---: |
| <img src="https://via.placeholder.com/250x500.png?text=Welcome+Screen" width="250"> | <img src="https://via.placeholder.com/250x500.png?text=Dashboard" width="250"> | <img src="https://via.placeholder.com/250x500.png?text=Add+Transaction" width="250"> |

---

##  Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check out the [issues page](https://github.com/your-username/wallet_wise/issues). 

##  License

This project is licensed under the MIT License - see the LICENSE file for details.
