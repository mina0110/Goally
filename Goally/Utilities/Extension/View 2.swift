//
//  View.swift
//  NanoChallenge2
//
//  Created by Minawati on 28/07/22.
//

import Foundation
import SwiftUI

extension View {

    public func popUpView<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        return self
            .overlay(
                if show.wrappedValue {
                    GeometryReader { geo in
                        let size = proxy.size
                        
                        
                    }
                }
            )
    }
}
