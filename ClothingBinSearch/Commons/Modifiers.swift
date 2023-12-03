//
//  Modifiers.swift
//  ClothingBinSearch
//
//  Created by Lyla on 2023/11/26.
//

import SwiftUI

struct YellowBottomBorder: ViewModifier {
    
    let showBorder: Bool
    
    func body(content: Content) -> some View {
        Group {
            if showBorder {
                content.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 2)
                        .foregroundColor(.mainColor)
                        .padding(.top, 10)
                    , alignment: .bottom
                )
            } else {
                content
            }
        }
    }
}
