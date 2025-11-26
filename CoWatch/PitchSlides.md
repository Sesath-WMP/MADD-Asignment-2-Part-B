# Slide 1 – Title

**CoWatch – Playful Co-Watching for tvOS**

Interactive quizzes, live leaderboards, and simulated friends layered on top of streaming content.

---

# Slide 2 – Problem

- Streaming on the TV is mostly passive and solitary.
- Group watch experiences are fragmented across devices and hard to coordinate.
- There is no built-in way to turn a casual watch into a lightweight party game on tvOS.

---

# Slide 3 – Solution / Demo

- **CoWatch** turns any viewing session into a shared, gamified experience.
- Host drives playback from the TV while friends (simulated in this prototype) answer timed quizzes.
- Live leaderboard and neon visuals keep everyone engaged without overwhelming the living room.

Demo flow:

1. Host starts a session on Apple TV.
2. Picks a piece of content from the catalog.
3. Everyone watches together while periodic quiz overlays appear.
4. Scores and rankings update in real time.

---

# Slide 4 – Technical Approach

- **Stack**: Swift 5, SwiftUI, tvOS, AVKit.
- **Architecture**: MVVM + service layer (`ContentService`, `SimulationService`, `PlaybackSyncService`, `PersistenceService`).
- **Simulation**: Local service spawns peers with latency and behavior strategies; responds to host events and quiz prompts.
- **Sync**: `AVPlayer` wrapped with a lightweight sync service emitting time ticks and applying drift correction.
- **Data**: `SeedContent.json` for catalog + quiz pack, `UserDefaults` for profile and high scores.

---

# Slide 5 – Market & Monetization

- **Target users**: Families, roommates, and friend groups who already gather around Apple TV.
- **Use cases**: Watch parties, trivia nights, classroom watch-alongs, brand activations.
- **Monetization ideas**:
  - Premium quiz packs and branded content tie-ins.
  - Seasonal events (e.g., sports, award shows) with sponsored leaderboards.
  - White-label SDK for streaming platforms wanting built-in co-watch games.

---

# Slide 6 – Next Steps

- Replace simulation with real networking (MultipeerConnectivity or backend service).
- Add cross-device play (iPhone / iPad as controllers, TV as shared canvas).
- Integrate content provider APIs for deep linking into specific shows or events.
- Expand game mechanics: power-ups, streaks, team modes.
- Conduct user testing on real living room setups and iterate on interaction patterns.
