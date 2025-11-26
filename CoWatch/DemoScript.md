# CoWatch – 3 Minute Demo Script

## 0:00–0:20 – Framing

“Imagine you’re watching a show with friends, but instead of everyone silently scrolling their phones, the TV invites you to play together. That’s what CoWatch does on Apple TV: it turns passive watching into a light, social game.”

## 0:20–0:50 – Welcome Screen

[On simulator, launch the app.]

“This is the CoWatch home screen. It has a dark neon look that plays nicely with tvOS focus. From here I can **Host Session** or **Join Session**. For this prototype we’re using **Simulation Mode**, which lets me spawn virtual peers instead of real networked devices. I can control how many peers I simulate and even adjust their network latency to stress the sync logic.”

Highlight the peer count stepper and latency slider.

## 0:50–1:20 – Content Browser

“Let’s host a session.”

[Tap **Host Session**.]

“Now we’re in the content browser. Each card is a piece of seeded content defined in `SeedContent.json` with a title, description, and video URL. Focus animations and glow help you see where the Siri Remote is pointing from across the room.”

[Select the first content card.]

## 1:20–1:45 – Lobby

“We’re now in the lobby. I’m the host on the left, and the colored circles are simulated peers. In a real product these would be your friends connecting from phones or other TVs.

From here I can start playback for everyone.”

[Tap **Start Playback**.]

## 1:45–2:20 – Playback & Quiz

“Playback is powered by `AVPlayer` in SwiftUI. The host controls play and pause; behind the scenes a `PlaybackSyncService` is tracking current time and emitting ticks.

At certain timestamps we trigger quizzes. These are defined in a quiz pack inside `SeedContent.json` with question text, multiple choices, a correct answer index, and how many points it’s worth.”

[Wait for a quiz overlay, then answer a question.]

“When a quiz appears, I can answer using the remote. The prototype awards points for correct answers and also lets simulated peers answer in the background so their scores change too.”

## 2:20–2:50 – Leaderboard

“Let’s end the session and look at the results.”

[Tap **End & Leaderboard**.]

“Here’s the leaderboard. The top three players show up on a podium with animated bars, and everyone else appears in a ranked list. Scores are also written into my local profile so I can track a personal high score over time.”

## 2:50–3:00 – Wrap-Up

“So that’s CoWatch: a small, focused tvOS prototype that combines synchronized playback, interactive quizzes, and a social leaderboard. Under the hood it’s all SwiftUI, MVVM, and a set of services that could be swapped from simulation to real networking for a production-ready co-watching experience.”
