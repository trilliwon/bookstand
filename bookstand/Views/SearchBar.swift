//
//  SearchBar.swift
//  bookstand
//
//  Created by won on 2020/08/03.
//  Copyright © 2020 Won. All rights reserved.
//

import SwiftUI

struct SearchBar: View {

    var cancelTitle: String = "Cancel"

    @Binding var text: String

    var body: some View {

        HStack(alignment: .center, spacing: 5) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.template)
                    .foregroundColor(Color(.systemGray))
                    .font(.system(size: 16, weight: .medium))
                    .padding(.horizontal, 5)

                TextField("Search ...", text: $text)
                    .font(.subheadline)
                    .onTapGesture {
                        withAnimation {
                            self.isEditing.toggle()
                        }
                    }

                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.template)
                        .opacity(text.isEmpty ? 0 : 1)
                        .foregroundColor(Color(.systemGray2))
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .padding(5)
            .background(Color(.systemGray5))
            .cornerRadius(8)

            if isEditing {
                Button(action: {
                    UIApplication.shared.endEditing(true)
                    withAnimation {
                        self.isEditing.toggle()
                    }
                    self.text = ""
                }) {
                    Text(cancelTitle)
                        .font(.system(size: 16, weight: .medium))
                }
                .transition(.moveOrFade(edge: .trailing))
                .animation(.easeInOut)
            }
        }
    }

    @State private var isEditing = false
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}

extension AnyTransition {
    static func moveOrFade(edge: Edge) -> AnyTransition {
        AnyTransition.move(edge: edge).combined(with: .opacity)
    }
}
