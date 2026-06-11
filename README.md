# Real-Time Hybrid Discovery Chat Application

A high-performance, full-stack, real-time chat application built to mimic modern, production-grade messaging ecosystems like WhatsApp and Telegram. This project bypasses managed backend suites (like Firebase) to implement a self-managed architecture focusing on raw network protocols, concurrency management, custom relational data mapping, and local networking synchronization.

## 🚀 Architecture Overview

The system uses a hybrid dual-protocol networking model designed for decoupled scalability:
* **Transactional State (HTTP REST APIs):** Core user workflows such as secure authentication (handled via `bcryptjs` and stateless JSON Web Tokens) and historical message pagination run over standard HTTP requests.
* **Persistent Real-Time Engine (WebSockets):** Live interactions including instantaneous text delivery, user presence tracking (online/offline states), and typing notifications utilize low-latency, bi-directional WebSocket pipes via `socket.io`.
* **Smart Notification Pipeline:** The backend monitors connection states via Redis. If a recipient's active socket is disconnected (app backgrounded/closed by the OS), the server drops the socket delivery and automatically routes the payload to Firebase Cloud Messaging (FCM) to trigger background device push notifications.

---

## 🛠️ Tech Stack

### Frontend (Mobile App)
* **Framework:** Flutter (Dart)
* **State Management:** BLoC / Riverpod (Enterprise Clean Architecture)
* **Networking:** Dio (HTTP Client) & Socket.io Client (WebSockets)
* **Local Caching:** Isar / SQLite (Offline support capabilities)
* **Hardware Integrations:** `flutter_contacts` for native address book access

### Backend (Local Machine Server)
* **Runtime & Framework:** Node.js + Express.js (JavaScript)
* **Database (Persistent):** PostgreSQL (Relational schema with optimized array indexes)
* **In-Memory Cache:** Redis (Active connection mapping and presence tracking)
* **Push Services:** Firebase Admin SDK (FCM background delivery engine)

---

## 📁 Monorepo Folder Structure

The repository uses a Monorepo layout containing both isolated codebases to ensure clean version tracking and modular extensions.

```text
chat_app_workspace/               # Root Monorepo Folder
│
├── backend/                       # Node.js + Express Backend Service
│   ├── config/                    # Global app configurations (Database, Redis, Firebase)
│   ├── src/                       # Main application source code
│   │   ├── api/                   # Routing layers and Request Middlewares
│   │   ├── components/            # Isolated business logic partitioned by feature
│   │   │   ├── auth/              # Signup, login, and token generation
│   │   │   ├── chat/              # Message tracking and room allocations
│   │   │   └── contacts/          # Phone address book sync and search algorithms
│   │   ├── db/                    # Raw SQL schema generation tracking and static queries
│   │   └── sockets/               # WebSocket connections and presence handlers
│   ├── index.js                   # Application bootstrap entrypoint
│   └── package.json
│
├── frontend/                      # Flutter Mobile Application
│   ├── assets/                    # Static media and design assets
│   ├── lib/                       # Primary Dart application logic
│   │   ├── config/                # Environment configurations (Laptop Local IP routes)
│   │   ├── core/                  # Universal network wrappers and global helpers
│   │   ├── features/              # Feature-First Architecture Modules (MVVM)
│   │   │   ├── auth/              # Data, Domain, and Presentation layers for Auth
│   │   │   ├── chat_dashboard/    # Data, Domain, and Presentation layers for Chat
│   │   │   └── contact_discovery/ # Contact Syncing + Username Search modules
│   │   ├── injection.dart         # Service Locator (Dependency Injection via Get_It)
│   │   └── main.dart              # Framework initialization entrypoint
│   └── pubspec.yaml
└── README.md