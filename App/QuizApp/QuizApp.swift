//	
// Copyright © 2020 Essential Developer. All rights reserved.
//

import SwiftUI
import QuizEngine

class QuizAppStore {
	var quiz: Quiz?
}

@main
struct QuizApp: App {
	let appStore = QuizAppStore()
	@StateObject var navigationStore = QuizNavigationStore()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				QuizNavigationView(store: navigationStore)
			}
			.onAppear {
				startNewQuiz()
			}
		}
	}
	
	private func startNewQuiz() {
		let adapter = iOSSwiftUINavigationAdapter(
			navigation: navigationStore,
			options: demoQuiz.options,
			correctAnswers: demoQuiz.correctAnswers,
			playAgain: startNewQuiz)
		
		appStore.quiz = Quiz.start(questions: demoQuiz.questions, delegate: adapter)
	}
}
