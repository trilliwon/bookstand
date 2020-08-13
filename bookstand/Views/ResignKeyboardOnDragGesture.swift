//
//  ResignKeyboardOnDragGesture.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

extension UIApplication {
	func endEditing(_ force: Bool) {
		windows
			.filter{$0.isKeyWindow}
			.first?
			.endEditing(force)
	}
}

struct ResignKeyboardOnDragGesture: ViewModifier {
	var gesture = DragGesture()
		.onChanged { _ in
			UIApplication.shared.endEditing(true)
	}

	func body(content: Content) -> some View {
		content.gesture(gesture)
	}
}

extension View {
	func resignKeyboardOnDragGesture() -> some View {
		modifier(ResignKeyboardOnDragGesture())
	}
}
