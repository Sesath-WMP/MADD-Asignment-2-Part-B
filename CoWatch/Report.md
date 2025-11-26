# CoWatch Prototype Report

## 1. Concept Overview

CoWatch is a tvOS prototype that explores lean-back yet social co-watching. One viewer acts as the host, curating content and pacing, while friends participate remotely (simulated in this prototype) through quizzes and lightweight competition.

Key ideas:

- Turn passive watching into a shared game loop (watch → quiz → react → compare)
- Use tvOS focus and large-screen UI for comfortable couch interactions
- Demonstrate multi-user behavior using a deterministic simulation instead of real networking

## 2. UX Decisions

- **Dark neon theme** – The color palette (deep green, neon lime, cyan glow, dark graphite, amber highlight) emphasizes contrast and glow, working well with tvOS focus rings and parallax.
- **Simple linear flow** – Welcome → Content → Lobby → Playback → Leaderboard → (optional return). Easy to narrate in a 3-minute demo.
- **Big, focusable cards** – All primary actions are large, spaced buttons and tiles with scale + glow animations on focus.
- **Quiz overlays** – Appear as full-screen dim overlays with a centered neon card. All choices are comfortably selectable with the Siri Remote.
- **Leaderboard podium** – Top three players are highlighted with a podium motif; the rest are in a scrollable list for clarity.
- **Profile screen** – Minimal but demoable: name, avatar color, and high score are persisted.

## 3. Architecture

- **Pattern**: MVVM + service layer
- **Dependency injection**: `ServiceContainer` provided as an `EnvironmentObject` from `CoWatchApp`.

### Core Models

- `User` – id, name, avatar color hex, total score
- `Session` – id, host, participants, selected `ContentItem`, state (lobby / playing / finished)
- `ContentItem` – id, title, description, thumbnail, video URL, duration
- `QuizItem`, `QuizChoice`, `QuizPack` – quiz content with trigger time and score value

### Services

- `ContentService`
  - Loads `SeedContent.json` from the main bundle
  - Deserializes both content items and quiz pack
- `SimulationService`
  - Spawns simulated peers with names, avatar colors, individual latency, and scores
  - Reacts to host events such as play/pause, time sync (conceptually), and quiz prompts
  - Updates scores probabilistically on quiz prompts
- `PlaybackSyncService`
  - Wraps an `AVPlayer` instance
  - Provides `currentTime`, `isPlaying`, and a low-frequency tick via `CADisplayLink`
  - Hosts control play, pause, and seek; a simple sync method corrects drift based on host time and latency
- `PersistenceService`
  - Stores `User` and high score in `UserDefaults` using `Codable`

### View Models

- `WelcomeViewModel` – controls simulation mode, peer count, latency; configures `SimulationService`
- `ContentBrowserViewModel` – loads catalog content
- `HostLobbyViewModel` – owns `Session` and listens for simulated peer updates
- `PlaybackViewModel` – owns `AVPlayer`, quiz scheduling, score computation, and leaderboard assembly
- `LeaderboardViewModel` – sorts and exposes ranked users
- `ProfileViewModel` – loads/saves profile + high score through `PersistenceService`

## 4. Testing

### Unit Tests

- **`QuizScoringTests`**
  - Ensures that answering a quiz correctly increases the user’s score by the quiz’s point value.
- **`SimulationServiceTests`**
  - Verifies configuration of the requested number of peers.
  - Verifies that quiz prompts update peer scores without crashing.
- **`PlaybackSyncServiceTests`**
  - Smoke tests that applying sync without an attached player is safe.

### UI Test

- **`CoWatchUITests.testFullHostSessionFlow`**
  - Launches the app.
  - Navigates from Welcome → Host Session → Content Browser → Lobby → Playback → Leaderboard.
  - Taps Host Session, selects a content card, starts playback, and ends to the leaderboard.

The tests aim to validate core behaviors while staying robust in the simulator.

## 5. Reflections and Future Work

- **Networking** – The biggest missing piece is real networking (e.g., MultipeerConnectivity, WebSockets, or a backend). The simulation service is intentionally API-shaped so that its internals can be swapped with actual network events.
- **Richer sync** – Playback sync is a simplified drift corrector. A production system would use heartbeat messages, drift smoothing, and more precise clock models.
- **Accessibility** – tvOS provides good focus and VoiceOver hooks; labels and contrast could be further refined.
- **Analytics & retention loops** – For a commercial product, we would add streaks, achievements, and social re-engagement loops around co-watch events.
- **Design polish** – Asset work (thumbnails, video snippets) and micro-animations would further sell the experience.

Overall, CoWatch demonstrates that a small, well-structured SwiftUI + service-based tvOS app can prototype an engaging social viewing experience without deploying backend infrastructure.
