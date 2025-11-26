CoWatch
tvOS Multi-User Watch & Quiz Prototype – SE4041 Assignment 2 (Part B)

CoWatch is an innovative tvOS prototype app that enables groups to watch synchronized content together with interactive quizzes. It includes a simulation mode that creates virtual peers for a smooth, reliable demo without requiring multiple Apple TVs.

A dark neon Netflix-style UI enhances the cinematic feel and showcases advanced tvOS capabilities.

🎬 Features
Session System

Host Session / Join Session

Local Simulation Mode (1–3 peers)

Adjustable latency for testing sync

Real-time peer join/leave simulation

Playback & Sync

AVPlayer-based video playback

Host-authoritative time synchronization

Smooth drift correction

Supports session-based content selection

Interactive Quizzes

Timed quiz triggers during playback

Multiple-choice overlay

Real-time peer answers

Live leaderboard + animated results

Content Browser

Netflix-style hero carousel

Trending and category rows

Poster-card UI with glow + focus animations

🧱 Architecture

Pattern: MVVM + Services

Models: User, ContentItem, QuizItem, Session

ViewModels: Welcome, Browser, HostLobby, Playback, Leaderboard

Services:

ContentService

PlaybackSyncService

SimulationService

PersistenceService

🎨 UI / UX

Dark neon theme using:

Deep Green (#0A5C50)

Neon Lime (#D7FF5E)

Cyan Glow (#66FFCC)

Dark Graphite (#1F2424)

Amber (#FF9A1A)

Smooth focus animations and glow rings

Blurred, parallax background from focused poster

Large TV typography

Remote-friendly navigation (Focus Engine optimized)

Profile & settings for simulation controls

🧪 Testing
Unit Tests

Playback sync logic

Quiz scoring

Simulated peer behaviour

UI Tests

Host Session → Playback → Quiz → Leaderboard flow

📦 Installation & Running

Clone the repository

Open CoWatch.xcodeproj

Run on Apple TV 4K simulator (tvOS 17+)

Open Profile/Settings to enable Simulation Mode

📁 Project Structure
CoWatch/
 ├── CoWatch.xcodeproj
 ├── Scenes/
 ├── Models/
 ├── Services/
 ├── Components/
 ├── Resources/SeedContent.json
 ├── Assets.xcassets
 ├── Tests/
 ├── PitchSlides.md
 ├── DemoScript.md
 └── README.md

📝 AI Assistance

AI tools (ChatGPT & Windsurf) were used to assist with UI generation, simulation logic scaffolding, and documentation. All final logic, debugging, and optimization were done manually.
