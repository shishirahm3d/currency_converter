# Realtime Currency Converter

**App Name:** Currency Converter  
**Platforms:** Android, iOS, Web, macOS, Windows  
**Framework:** Dart & Flutter  
**Backend:** Firebase  
**API Integration:** OpenExchangeRates API  

---

## Overview
The *Realtime Currency Converter* is a cross-platform application designed to provide users with accurate and real-time currency conversion. The app features a sleek UI, user authentication, and powerful functionality to deliver a seamless experience.

---

## Features

### 1. Authentication
- **Login/Signup** with Firebase authentication.
- Anonymous login support.
- Email verification required before login.
- Forgot password functionality.

### 2. Currency Conversion
- Convert between any currencies using the OpenExchangeRates API.
- Real-time exchange rates for accurate conversions.

### 3. Conversion History
- View a detailed history of currency conversions.
- Timestamps for each transaction.
- Option to reset or remove history entries.

### 4. Realtime Currency Rates
- View real-time rates for all supported currencies.

### 5. User Profile
- Update profile information such as name, email, and profile picture.
- Developer and app details under the About section.
- Logout functionality.

---

## Screenshots

<div align="center">
  <!-- First Row -->
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Login_Page.png" alt="Login Page" width="200">
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/SignUp_Page.png" alt="SignUp Page" width="200">
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Home_Currency_Selection.png" alt="Home Currency Selection" width="200">
  
  <!-- Second Row -->
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Home_Page.png" alt="Home Page" width="200">
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Conversion_History_Page.png" alt="Conversion History Page" width="200">
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Currency_Rates_Page.png" alt="Currency Rates Page" width="200">
  <img src="https://github.com/shishirahm3d/currency_converter/blob/Version2.0/assets/ui_ss/Profile_Page.png" alt="Profile Page" width="200">
  
</div>

---

## Installation

### Prerequisites
- Flutter SDK installed on your system.
- Dart language support enabled.
- Firebase account with authentication and database setup.
- API Key from [OpenExchangeRates](https://openexchangerates.org/).

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/realtime-currency-converter.git
   ```
2. Navigate to the project directory:
   ```bash
   cd realtime-currency-converter
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Replace the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files with your Firebase configuration files.
5. Add your OpenExchangeRates API key in the relevant file.
6. Run the app:
   ```bash
   flutter run
   ```

---

## Technologies Used
- **Dart & Flutter** for app development.
- **Firebase** for user authentication and profile management.
- **OpenExchangeRates API** for real-time currency data.

---

## Future Enhancements
- Add multi-language support.
- Introduce push notifications for significant currency rate updates.
- Offline mode for basic functionality.

---

## Contributing
Contributions are welcome! Please fork the repository and create a pull request with detailed information about the changes made.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments
- [OpenExchangeRates](https://openexchangerates.org/) for providing the API.
- Flutter community for extensive documentation and support.

---
