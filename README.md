#Pixalive

Flutter and Dart Documentation
A few resources to get you started if this is your first Flutter project:

Lab: Write your first Flutter app
Cookbook: Useful Flutter samples
Flutter documentation
Dart language documentation
Effective Dart: Style
Setting up your local dev environment
User Flutter version 3.3.4 (stable)
Prerequisites before working in VSCode:

Install Java
Install Android Studio
Using SDK Manager in Android Studio, install the Android Emulator and at least one emulator image
Get a sample app working in the emulator in Android Studio
After you have verified that your Android environment is working, you can move on to working with Flutter.

Install the latest stable release of Flutter: https://flutter.dev/docs/development/tools/sdk/releases
Follow the instructions for installing Flutter on your OS here: https://flutter.dev/docs/get-started/install
Next, Open VSCode and install the following extensions:

Flutter
Flutter Intl
Dart
Open this project in VSCode. Open a terminal and run flutter doctor, then fix any issues that are found. You may need to upgrade Flutter and/or Dart to the latest versions. You may need to update your environment variables if Java or Android Studio are installed in non-standard locations. You may need to accept Android SDK licenses via the command line.

When flutter doctor returns no issues, you are ready to run the app.

Localization
Flutter does localization by parsing json files saved with .arb extensions in the l10n folder. This does not happen automatically. You need to run flutter gen-l10n to generate the localization files. This must be done before running the app for the first time, or it will not compile.

Running the app
Basic usage: flutter run

Using DevTools:

Flutter DevTools is part of the VSCode Flutter extension. It includes a layout explorer, CPU profiler, debugger, and many other useful tools. Read more about it here: https://flutter.dev/docs/development/tools/devtools/overview

For DevTools to connect to the app you must specify a port: flutter run --observatory-port=9200 You will get a URL in the terminal, e.g. http://127.0.0.1:9200/WdqWMny1Lfc=/. Enter that URL into the "Connect to a Running App" box in Flutter DevTools.

IOS
To troubleshoot iOS cocoapods issues on windows, you can still install cocoapods.

Follow the instructions in at https://airtdave.medium.com/using-cocoapods-on-windows-dec471735f51, but note the following

you MAY not need to install curl with the latest windows powershell, etc. ("Your mileage may vary")
(!)Important: do not use version 1.11, it's broken on windows. But gem install cocoapods -v 1.10.1 works.
You can then use pod install from the ios directory and see stuff.
