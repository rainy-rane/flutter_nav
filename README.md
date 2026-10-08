# Flutter Navigation
> A comprehensive Flutter application demonstrating essential mobile navigation paradigms, route transitions, multi-tab bottom navigation, drawer navigation, and user profiles.

---

## 📌 About the App

**Flutter Navigation** is a mobile application built with **Flutter** and **Dart** designed for mobile programming students and developers. It serves as an interactive demonstration of modern Flutter navigation patterns, including:

- **Imperative Stack Navigation**: Pushing and popping screens (`Navigator.push`, `Navigator.pop`).
- **Two-way Route Data Passing**: Passing input data from the Registration screen back to the Login screen upon completion.
- **Dedicated Post-Login Dashboard**: Direct landing route on login showcasing quick-action navigation cards and metric summaries.
- **Bottom Navigation Hub**: 4-tab switching (Dashboard, Notifications, Contacts, Profile) with state preservation via `IndexedStack`.
- **Side Navigation Drawer**: Slide-out drawer menu with custom header and direct route navigation.
- **User Profile Management**: Complete user profile section with edit modals, preferences toggles, and account status.
- **Modal Dialogs & Bottom Sheets**: Interactive popups (`showDialog`, `showModalBottomSheet`) with callback-driven action handling.
- **Contextual Feedback**: Interactive SnackBars with custom action buttons (e.g., Undo delete).

---

## ✨ Features

- **Authentication & Validation Flow**:
  - Pre-configured demo credentials (`admin` / `1234`) with a quick 1-tap autofill button.
  - Password visibility toggle (show/hide password).
  - Input field validations for empty fields, email formatting, and matching confirmation passwords.
- **Two-Way Navigation Flow**:
  - Route push to Register screen.
  - Returns registered username and password back to Login screen using `Navigator.pop(context, data)` for automatic form fill.
- **Post-Login Dashboard (Default Landing)**:
  - Users route straight to the central **Dashboard** immediately upon login (not directly to notifications).
  - Gradient banner with user avatar, welcome greeting, and session status.
  - Interactive **Quick Navigation Hub** cards linking to Notifications, Contacts, Profile, and Architecture Overview.
- **4-Tab Bottom Navigation Bar**:
  - Smooth tab switching between **Dashboard**, **Notifications**, **Contacts**, and **Profile**.
  - `IndexedStack` keeps tab state and scroll positions alive during switching.
- **Side Navigation Drawer**:
  - Slide-out drawer with `UserAccountsDrawerHeader` displaying user avatar, name, and email.
  - Direct navigation to any tab or quick logout trigger.
- **User Profile & Account Settings**:
  - User details (Username, Display Name, Email, Phone, Role Badge).
  - "Edit Profile" modal dialog allowing live updates to name, email, and phone.
  - Interactive preferences (Push Notifications toggle, password change simulation).
  - Activity statistics counter.
- **Interactive Notifications Feed**:
  - List of real-time announcements and class alerts with custom icons.
  - Tap any card to open a full details popup dialog (`showDialog`).
  - Delete notification with instant SnackBar feedback offering an **UNDO** action.
  - Floating Action Button to dynamically add sample notifications.
- **Searchable Contacts Directory**:
  - Interactive contact list with avatar initials and contact details.
  - Real-time search filter for names, roles, emails, and phone numbers.
  - Tap contact to trigger a smooth **Modal Bottom Sheet** (`showModalBottomSheet`) with direct action simulation for Phone and Email.
- **Session & Logout Control**:
  - Header profile badge in the AppBar.
  - Logout confirmation dialog with stack cleanup.

---

## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **Dart (v3.12+)** | Core programming language with 100% sound null safety |
| **Flutter SDK (v3.44+)** | UI framework for cross-platform app development |
| **Material 3 (M3)** | Modern UI design system with dynamic theming |
| **Cupertino Icons** | iOS & cross-platform iconography |
| **Flutter Test** | Automated unit and widget smoke test suite |

---

## 📂 Project Structure

```text
flutter_nav/
├── android/                   # Android native platform integration
├── ios/                       # iOS native platform integration
├── web/                       # Web platform support
├── windows/                   # Windows desktop support
├── linux/                     # Linux desktop support
├── macos/                     # macOS desktop support
├── lib/
│   ├── assets/
│   │   ├── 2026-10-08 15-06-46.mp4 # Video demonstration recording
│   │   └── videoref.png            # UI video demonstration reference
│   ├── main.dart              # Application entry point & ThemeData configuration
│   ├── Mainpage.dart          # Login screen & authentication routing
│   ├── Registerpage.dart      # Registration screen & pop result callback
│   ├── Loginpage.dart         # Main Hub screen with BottomNavigationBar & Drawer
│   ├── Dashboard.dart         # Post-login landing screen with quick navigation cards
│   ├── Viewnotification.dart  # Notifications tab with dialogs & undo actions
│   ├── Contact.dart           # Contacts tab with search & modal bottom sheet
│   └── Profile.dart           # User profile screen with edit dialogs & preferences
├── test/
│   └── widget_test.dart       # Automated end-to-end navigation widget tests
├── pubspec.yaml               # Dependencies, SDK constraints & metadata
├── analysis_options.yaml      # Static analysis & linter configurations
└── README.md                  # Project documentation
```

---

## 📱 Screen Descriptions

### 1. Login Screen (`Mainpage.dart`)
- **Purpose**: Serves as the initial entry route into the application.
- **Navigation Type**: Stack Push (`Navigator.push`), Pop Receiver (`await Navigator.push`).
- **Key Elements**:
  - Username and password fields with visibility toggle.
  - Quick Autofill demo button (`admin` / `1234`).
  - "Register New Account" button pushing to `Registerpage`.
  - Input validation with error SnackBars.
  - Successful authentication routes directly to `Loginpage` (Dashboard).

### 2. Registration Screen (`Registerpage.dart`)
- **Purpose**: Allows new users to input personal details and credentials.
- **Navigation Type**: Stack Pop (`Navigator.pop(context, credentials)`), AppBar Back Arrow.
- **Key Elements**:
  - Fields: Full Name, Email, Mobile Phone, Username, Password, and Confirm Password.
  - Password match verification.
  - Successful registration returns user data back to `Mainpage` to prefill fields.

### 3. Dashboard Screen (`Dashboard.dart`)
- **Purpose**: The primary landing screen post-login providing a central hub of features and stats.
- **Navigation Type**: Callback tab routing (`onNavigateTab`), Dialog Navigation (`showDialog`).
- **Key Elements**:
  - Gradient header banner with user avatar, name, and active session badge.
  - Quick Navigation Hub cards (direct shortcuts to Notifications, Contacts, and Profile).
  - Flutter Navigation Features summary overview card.
  - App Overview dialog showcasing navigation architecture.

### 4. Navigation Hub & Drawer (`Loginpage.dart`)
- **Purpose**: Post-login navigation coordinator housing the Bottom Navigation Bar and Side Drawer.
- **Navigation Type**: Tab Navigation (`BottomNavigationBar`), Drawer Navigation (`Drawer`), Modal Dialog (`showDialog`).
- **Key Elements**:
  - Dynamic AppBar title displaying active tab name.
  - AppBar profile chip jumping to the Profile tab.
  - Side Navigation Drawer with `UserAccountsDrawerHeader`.
  - Bottom navigation bar with 4 tabs: **Dashboard**, **Notifications**, **Contacts**, and **Profile**.
  - Logout action triggering an `AlertDialog` confirmation.

### 5. Notifications Screen (`Viewnotification.dart`)
- **Purpose**: Displays system alerts and announcements.
- **Navigation Type**: Dialog Navigation (`showDialog`), Action SnackBar (`SnackBarAction`).
- **Key Elements**:
  - Notification cards with status icons and dates.
  - Tap card to view full announcement dialog.
  - Delete button with **Undo** action via SnackBar.
  - Floating Action Button to dynamically append new notifications.
  - Empty state view when all alerts are cleared.

### 6. Contacts Directory (`Contact.dart`)
- **Purpose**: Displays a searchable team and contact directory.
- **Navigation Type**: Modal Bottom Sheet (`showModalBottomSheet`).
- **Key Elements**:
  - Live search bar filtering contacts by name or role.
  - Contact cards displaying initials, phone numbers, and emails.
  - Tap card opens a bottom modal sheet with quick action triggers (Call & Email).

### 7. User Profile Screen (`Profile.dart`)
- **Purpose**: Personal user details, account management, and app preferences.
- **Navigation Type**: Dialog Navigation (`showDialog` for Edit Profile), Logout Callback.
- **Key Elements**:
  - Large user avatar with editable badge.
  - Role badge (e.g. System Administrator / Student).
  - Activity counter row (Alerts, Contacts, UI Mode).
  - Personal info list tiles (Email, Phone Number, Account Type).
  - Push notifications switch toggle with SnackBar feedback.
  - Change password option and Log Out button.

---

## Demo App with Video

### Video Demonstration

<video src="lib/assets/2026-10-08%2015-06-46.mp4" controls="controls" width="100%"></video>

> 🎥 **Video File:** [`lib/assets/2026-10-08 15-06-46.mp4`](lib/assets/2026-10-08%2015-06-46.mp4)

---

## Running the App Locally

To preview and record the application on an emulator or physical device:

### 1. Install dependencies:
```bash
flutter pub get
```

### 2. Run the application:
- **Run in Google Chrome (Web)**:
  ```bash
  flutter run -d chrome
  ```
- **Run on Windows Desktop**:
  ```bash
  flutter run -d windows
  ```
- **Run on Connected Mobile Device / Emulator**:
  ```bash
  flutter run
  ```

### 3. Run automated tests:
Verify that all navigation flows and widget tests pass:
```bash
flutter test
```

### 🔑 Demo Credentials:
- **Username**: `admin`
- **Password**: `1234`
*(Or click the "Autofill demo (admin / 1234)" button directly on the login screen).*

---

## 👥 Contributors / Author

- **Rane** ([@rainy-rane](https://github.com/rainy-rane))
  - Sole Project Maintainer & Developer
  - Mobile Programming Project
