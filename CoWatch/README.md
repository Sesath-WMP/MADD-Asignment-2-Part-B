# CoWatch (tvOS SwiftUI Prototype)

CoWatch is a tvOS SwiftUI prototype for synchronous co-watching with interactive quizzes, a live leaderboard, and simulated multi-user sessions.

## Features

- Host / Join session flows (using simulated peers, no real networking)
- Synchronized video playback using `AVPlayer`
- Timed quiz overlays with scoring
- Live leaderboard with animated podium
- Profile & settings with `UserDefaults` persistence
- Dark neon visual theme tuned for tvOS focus

## Architecture

- **Language / UI**: Swift 5, SwiftUI, tvOS
- **Pattern**: MVVM + service layer
- **Services**:
  - `ContentService` – loads `SeedContent.json` for content and quizzes
  - `SimulationService` – spawns simulated peers and updates their scores
  - `PlaybackSyncService` – wraps `AVPlayer` timing and lightweight sync hooks
  - `PersistenceService` – stores profile + high score in `UserDefaults`
- **Dependency injection**: `ServiceContainer` injected via `EnvironmentObject`

## Screens

- **WelcomeView** – entry screen with Host / Join, simulation toggle, peer count, latency slider, and profile link
- **ContentBrowserView** – horizontal grid of seeded content
- **HostLobbyView** – shows host + simulated peers and controls to start playback or end session
- **PlaybackView** – AVPlayer video playback, quiz triggering, and navigation to leaderboard
- **QuizOverlay** – multiple-choice quiz with neon overlay
- **LeaderboardView** – podium animation and ranked list
- **ProfileView** – username, avatar color hex, and high score

## Simulation Mode

Simulation mode is enabled by default via `WelcomeView`. It:

- Spawns 1–3 simulated peers via `SimulationService`
- Applies an adjustable base latency so you can demo time-sync correction semantics
- Randomly decides whether each peer answers a quiz correctly and adjusts their scores

No real networking is used; everything is driven by local timers and services.

## Running the App

1. Open `CoWatch.xcodeproj` in Xcode.
2. Select the **CoWatch** tvOS app target.
3. Choose a tvOS Simulator (e.g. Apple TV 4K) as the run destination.
4. Build and run.

Flow to demo:

1. On **Welcome**, leave Simulation Mode on and choose **Host Session**.
2. In **Content Browser**, select any content card.
3. In **Lobby**, observe simulated participants and press **Start Playback**.
4. In **Playback**, use Play/Pause and wait for quiz overlays to appear.
5. Answer a quiz; then choose **End & Leaderboard** to view rankings.

## Running Tests

- Unit tests live under `CoWatchTests`.
- UI tests live under `CoWatchUITests`.

To run all tests:

1. In Xcode, select **Product → Test** (or press `Cmd+U`).
2. Ensure the **CoWatch** scheme is selected.

Included tests:

- `QuizScoringTests` – validates score calculation
- `SimulationServiceTests` – validates peer configuration & quiz side-effects
- `PlaybackSyncServiceTests` – smoke test for sync application
- `CoWatchUITests.testFullHostSessionFlow` – full host session → playback → leaderboard

## AI Assistance Log

This prototype was generated with the assistance of an AI coding partner (Cascade). The AI:

- Scaffolded the MVVM + services architecture
- Implemented models, services, and SwiftUI screens
- Created the test suite and documentation

You can now iterate directly in Xcode to extend networking, real-time sync, or richer game mechanics.
