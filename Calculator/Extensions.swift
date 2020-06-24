//
//  Extensions.swift
//  Calculator
//
//  Created by Marvin Wagner on 21/06/20.
//  Copyright © 2020 Marvin Wagner. All rights reserved.
//

import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
}
