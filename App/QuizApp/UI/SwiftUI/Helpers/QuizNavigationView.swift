//	
// Copyright © 2020 Essential Developer. All rights reserved.
//

import SwiftUI

class QuizNavigationStore: ObservableObject {
	enum CurrentView {
		case single(SingleAnswerQuestion)
		case multiple(MultipleAnswerQuestion)
		case result(ResultView)
	}
	
	var currentView: CurrentView?
	
	@Published var navigate: Bool = false
	
	@Published var rootView: CurrentView?
	
	var destinationView: AnyView {
		switch currentView {
		case let .single(view): return AnyView(view)
		case let .multiple(view): return AnyView(view)
		case let .result(view): return AnyView(view)
		case .none: return AnyView(EmptyView())
		}
	}
	
	var view: AnyView {
		switch rootView {
		case let .single(view): return AnyView(view)
		case let .multiple(view): return AnyView(view)
		case let .result(view): return AnyView(view)
		case .none: return AnyView(EmptyView())
		}
	}
	
	func navigateToView(currentView: CurrentView) {
		self.currentView = currentView
		self.navigate = true
	}
	
	func setRootView(rootView: CurrentView) {
		self.rootView = rootView
		self.navigate = false
	}
}

struct QuizNavigationView: View {
	
	@ObservedObject var store: QuizNavigationStore
	
	var body: some View {
		ZStack {
			NavigationLink("", isActive: self.$store.navigate) {
				store.destinationView
			}
			store.view
		}
	}
}

struct QuizNavigationView_Previews: PreviewProvider {
	static var previews: some View {
		QuizNavigationView(store: QuizNavigationStore())
	}
}
