import SwiftUI

struct QuizOverlay: View {
    let quiz: QuizItem
    let onAnswer: (Int) -> Void

    @FocusState private var focusedIndex: Int?

    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Quiz Time")
                    .font(CoWatchTypography.titleL)
                    .foregroundColor(CoWatchColors.amberHighlight)

                Text(quiz.question)
                    .font(CoWatchTypography.bodyL)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                VStack(spacing: 20) {
                    ForEach(quiz.choices.indices, id: \.self) { index in
                        let choice = quiz.choices[index]
                        Button(action: {
                            onAnswer(index)
                        }) {
                            HStack {
                                Text(choice.text)
                                    .font(CoWatchTypography.bodyM)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(CoWatchColors.deepGreen.opacity(0.8))
                            .cornerRadius(24)
                        }
                        .buttonStyle(.plain)
                        .focused($focusedIndex, equals: index)
                    }
                }
                .frame(width: 800)
            }
            .padding(40)
            .background(CoWatchColors.darkGraphite)
            .cornerRadius(40)
            .shadow(color: CoWatchColors.cyanGlow.opacity(0.8), radius: 40)
            .frame(maxWidth: 1000)
        }
        .onAppear {
            focusedIndex = 0
        }
    }
}
