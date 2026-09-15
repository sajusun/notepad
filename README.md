<div align="center">

# 📝 NotePad & Notebook App

### A Fast, Privacy-Focused Offline Note-Taking Application Built with Flutter & SQLite

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Database](https://img.shields.io/badge/SQLite-sqflite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://pub.dev/packages/sqflite)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-4CAF50?style=for-the-badge&logo=android&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](#license)
[![Author](https://img.shields.io/badge/Author-Sakhawat%20Hossain%20%28%40sajusun%29-indigo?style=for-the-badge&logo=github)](https://github.com/sajusun)

<p align="center">
  <a href="#overview">Overview</a> •
  <a href="#key-features">Key Features</a> •
  <a href="#architecture--tech-stack">Tech Stack</a> •
  <a href="#project-structure">Project Structure</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#how-it-works">How It Works</a> •
  <a href="#author--connect">Author</a> •
  <a href="#license">License</a>
</p>

---

</div>

## 📌 Overview

**NotePad** (Notebook) is a lightweight, high-performance, and offline-first mobile note-taking application engineered by **[Sakhawat Hossain (@sajusun)](https://sajusun.github.io/)**. Built using **Flutter** and powered by local **SQLite** (`sqflite`), the app is designed for users who value privacy, speed, and ownership over their notes.

Unlike cloud-dependent note apps that require accounts or send private thoughts over the internet, NotePad keeps 100% of data stored locally on your device with zero telemetry. It features seamless live search, detailed note metadata tracking, and a powerful dual import/export engine that writes notes to human-readable plain text (`.txt`) files on your local storage for effortless backup and cross-platform portability.

---

## ✨ Key Features

- ⚡ **Offline-First & Privacy-Focused**: No login required, no tracking, and zero internet connection needed. All data resides securely on the device.
- 🗄️ **Robust SQLite Local Storage**: Uses relational database tables for instant write, read, update, and delete (CRUD) operations with atomic reliability.
- 🔍 **Real-Time Live Search**: Instantaneous search filtering across note titles and descriptions with zero lag.
- 📤 **Human-Readable Export**: Export all notes to external device storage (`/storage/emulated/0/com.Notebook.notes`) as readable `.txt` files with creation & modification timestamps.
- 📥 **Batch Text File Import**: Effortlessly restore or batch-import notes from plain text files with automatic schema parsing into SQLite.
- 🕒 **Metadata & Timestamp Tracking**: View exact creation date, time, and last modified date for every note through an informative modal.
- 🎨 **Modern Material 3 UI**: Clean cards, smooth navigation, intuitive FAB actions, and confirmation safety dialogs before deletion.

---

## 🛠️ Architecture & Tech Stack

| Technology | Purpose | Documentation / Package |
|:---|:---|:---|
| **Flutter 3.x** | Cross-platform UI toolkit | [flutter.dev](https://flutter.dev) |
| **Dart 3.x** | Client-optimized OOP language | [dart.dev](https://dart.dev) |
| **sqflite** | SQLite database plugin for Flutter | [pub.dev/packages/sqflite](https://pub.dev/packages/sqflite) |
| **path & path_provider** | System path locator & file directory access | [pub.dev/packages/path_provider](https://pub.dev/packages/path_provider) |
| **permission_handler** | Granular Android runtime storage permissions | [pub.dev/packages/permission_handler](https://pub.dev/packages/permission_handler) |
| **intl** | Date/Time formatting & localized strings | [pub.dev/packages/intl](https://pub.dev/packages/intl) |
| **shared_preferences** | Key-value persistent state storage | [pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences) |

---

## 📂 Project Structure

```bash
notepad/
├── android/                   # Android native platform files & build config
├── ios/                       # iOS native platform files
├── lib/
│   ├── helper/
│   │   ├── date_time.dart     # Timestamp generator & formatting helper
│   │   ├── file_handler.dart  # File IO: Directory creation, TXT import & export engine
│   │   └── local_db.dart      # SQLite Database helper (CRUD queries, table setup)
│   ├── model/
│   │   └── note_model.dart    # Note entity data model
│   ├── view/
│   │   └── add_note.dart      # Note editor screen (Create / Update mode)
│   ├── widget/
│   │   └── alert_dialog.dart  # Reusable UI dialogs (Delete confirmation, Info modal)
│   └── main.dart              # App entry point, home feed, live search & action menu
├── pubspec.yaml               # Project dependencies and environment specs
└── README.md                  # Project documentation & author profile
```

---

## 🚀 Getting Started

Follow these steps to clone, build, and run the project locally on your machine or physical Android/iOS device.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.1.5 < 4.0.0`)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter extensions
- Android Device or Emulator (API 21+)

### Installation & Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sajusun/notepad.git
   cd notepad
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Check Flutter Environment**:
   ```bash
   flutter doctor
   ```

4. **Run the Application**:
   ```bash
   # Run on connected emulator or physical device
   flutter run
   ```

5. **Build Release APK (Android)**:
   ```bash
   flutter build apk --release
   ```
   The generated APK will be available in `build/app/outputs/flutter-apk/app-release.apk`.

---

## 💡 How It Works

### 1. Database Schema
Notes are stored inside a localized SQLite database with the following table schema:

```sql
CREATE TABLE Notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  creationTime TEXT,
  modifiedTime TEXT
);
```

### 2. Export & Import Mechanism
- **Exporting**: When clicking **Export** from the top-right menu, the app fetches all rows from SQLite and writes individual `.txt` files into `/storage/emulated/0/com.Notebook.notes/notes/` in the format:
  ```text
  [creationTime]
  [modifiedTime]
  [title]
  [description]
  ```
- **Importing**: When clicking **Import**, the app scans the target directory, reads each text file, parses the header and body lines, and imports the records straight into the SQLite database.

---

## 👨‍💻 Author & Connect

This project is built and maintained by **Sakhawat Hossain** (`sajusun`), a Senior Backend & Software Engineer specializing in scalable application architectures, cloud systems, and mobile/web development.

<div align="center">

[![Portfolio](https://img.shields.io/badge/Website-sajusun.github.io-6366F1?style=for-the-badge&logo=google-chrome&logoColor=white)](https://sajusun.github.io/)
[![Resume](https://img.shields.io/badge/Resume%2FCV-View%20Resume-4F46E5?style=for-the-badge&logo=adobeacrobatreader&logoColor=white)](https://sajusun.github.io/resume.html)
[![Projects](https://img.shields.io/badge/Portfolio-Projects%20%26%20Case%20Studies-0ea5e9?style=for-the-badge&logo=githubpages&logoColor=white)](https://sajusun.github.io/projects.html)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-in%2Fsajusun-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/sajusun)
[![GitHub](https://img.shields.io/badge/GitHub-sajusun-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/sajusun)
[![Email](https://img.shields.io/badge/Email-backend.sakhawat%40gmail.com-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:backend.sakhawat@gmail.com)
[![WhatsApp](https://img.shields.io/badge/WhatsApp-Chat%20Now-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://wa.me/8801580349431)

</div>

### Professional Profiles & Portfolio
- 🌐 **Personal Website**: [https://sajusun.github.io/](https://sajusun.github.io/)
- 📄 **Curriculum Vitae / Resume**: [https://sajusun.github.io/resume.html](https://sajusun.github.io/resume.html)
- 🚀 **Projects & Case Studies**: [https://sajusun.github.io/projects.html](https://sajusun.github.io/projects.html)
- 📬 **Contact**: [https://sajusun.github.io/contact.html](https://sajusun.github.io/contact.html)
- 💼 **LinkedIn**: [linkedin.com/in/sajusun](https://linkedin.com/in/sajusun)
- 🐙 **GitHub**: [@sajusun](https://github.com/sajusun)

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute this software for educational and personal purposes.

---

<div align="center">
  <sub>Engineered with ❤️ by <a href="https://sajusun.github.io/">Sakhawat Hossain (@sajusun)</a>. If you found this project helpful, please consider giving it a ⭐ on <a href="https://github.com/sajusun/notepad">GitHub</a>!</sub>
</div>
