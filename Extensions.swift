//
//  View+Extensions.swift
//  Ciphers
//
//  Created by Arjun B on 03/04/23.
//

import SwiftUI

import Foundation
import SwiftUI

extension View {
    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
      self.modifier(MeasureSizeModifier())
        .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
        Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
    })
  }
}
