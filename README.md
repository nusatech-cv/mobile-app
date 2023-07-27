# Platform User

## Project Structure

The project follows a typical Flutter project structure. It is organized into multiple directories and it is crucial to understand the responsibility of each directory.

Let's go through some of the directories:

- `android`: This directory contains Android specific configuration files. This is where you set permissions, adjust build settings and include Google Services among other configurations.
- `ios`: Contains specific files and code for iOS application.
- `lib`: This is where all Dart code lives. It includes the application code (UI, business logic, models, etc.).
  - `config`: Contains application configuration files such as theme, network configuration etc.
  - `data`: Includes data classes and functions for managing the application state.
  - `domain`: This consist of business logic in the application.
  - `view`: This includes UI related code.
- `assets`: All images, fonts, and other assets are stored here.
- `test`: The directory includes unit tests.
- `.env`: This file contains environment-specific configurations.

## Application Workflow

Upon launching the application, after the initial splash screen, the user is directed towards the Onboarding screen. After the completion of the Onboarding process, the user is navigated to the Sign-In screen. Depending on the user's role, they are redirected to appropriate dashboards.

The application contains several features such as Booking, History, Profile, Wallet for User and Therapist roles. Details of bookings made, upcoming Bookings and History of bookings can be viewed in the respective sections.

The profile section allows a user to view and manage their profile. Other features include Notification for updates and alerts.

## App Usage

1. After successfully building and launching the app, you can start with the sign up process.
2. Once the registration is complete, you can begin exploring the features of the app such as Booking, History, Profile, Wallet etc.

## Build Instructions

1. Ensure you have Flutter installed and set up on your local machine.
2. Clone the repository onto your local machine.
3. Navigate into the project directory using the terminal.
4. Create a `.env` file in the root of the project directory and input all the necessary environment variables based on `.env.example`.
5. To fetch the project dependencies, execute: `flutter pub get`
6. Depending on the platform you'd like to build for:
   - Android: `flutter run`

## Testing
This project includes unit tests for various features. It's located in `test` directory. 

To run the unit tests:

```bash
$ flutter test test/widget_test.dart
```

To run the integration test:

```bash
$ flutter test integration_test/app.dart
```

## Further Help

For further queries regarding the application, you can refer to Flutter's official documentation or open an issue on the project's GitHub repository.