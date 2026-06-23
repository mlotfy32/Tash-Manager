📱 Task Manager App (Flutter Assessment)

A cross-platform Task Manager mobile application built using Flutter as part of a technical assessment for Electro Pi (Flutter Developer – 1–2 years experience).

The app demonstrates clean architecture principles, REST API integration, state management, and scalable Flutter project structure.

🚀 Features
🔐 Authentication
User Login (Email & Password)
User Registration (Name, Email, Password)
Secure storage of authentication token
Auto-login if user is already authenticated
Logout functionality (clears saved session and redirects to login)
🏠 Home / Projects
Display list of tasks/projects from REST API
Each item contains:
Title
Body / Description
Status
Pull-to-refresh support
Empty state handling when no data exists
Loading & error states with proper UI feedback
📋 Project Details / Tasks
Display all tasks under selected project
Each task includes:
Title
Status (In Progress / Done)
Priority level
Mark tasks as completed
Add new task using bottom sheet
👤 Profile / Settings
Display user information (Name & Email)
Enable Dark/Light Mode
Logout button
🧠 Project Description

This application is a Task Manager system built to demonstrate real-world Flutter development practices.
It follows Clean Architecture principles to separate concerns into Data, Domain, and Presentation layers.

The app is designed to be scalable, maintainable, and production-ready, with proper handling of:

API integration
Authentication flow
State management using BLoC (Cubit)
Error handling & loading states
Responsive UI design
🛠️ Tech Stack
Framework: Flutter (latest stable)
Language: Dart
State Management: BLoC (Cubit)
Networking: Dio
Local Storage: SharedPreferences / Hive
Architecture: Clean Architecture (Data / Domain / Presentation)
Navigation: GoRouter
Theme: Light & Dark Mode support
📦 Dependencies

Main packages used in this project:

dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^2.12.2
  cached_network_image: ^3.4.1
  flutter_bloc: ^9.1.1
  flutter_dotenv: ^6.0.0
  flutter_screenutil: ^5.9.3
  get: ^4.7.3
  dio: ^5.4.0
  dartz: ^0.10.1
  shared_preferences: ^2.5.5
  shimmer: ^3.0.0
  pretty_dio_logger: ^1.4.0
  get_it: ^9.2.1
  flutter_svg: ^2.2.4
  fluttertoast: ^9.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  internet_connection_checker_plus: ^2.9.0
  go_router: ^14.0.0

  dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator: ^2.0.1
  build_runner: ^2.4.6


# App Screens

<img width="959" height="1280" alt="image" src="https://github.com/user-attachments/assets/48f8d9d6-4648-4e35-bc1b-00f22b404ea2" />

🔐 Login Screen
📝 Register Screen
🏠 Home Screen (Projects/List)
📋 Project Details Screen
👤 Profile Screen
🌙 Dark Mode (if implemented)

# App Video

https://github.com/user-attachments/assets/964ae59f-c314-42b0-8be1-1a13071be666

