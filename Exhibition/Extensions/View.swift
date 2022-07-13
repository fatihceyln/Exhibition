//
//  View.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import SwiftUI

extension View {
    func customProfileLableStlye(titleFont: Font) -> some View {
        self
            .labelStyle(CustomProfileLabelStyle(titleFont: titleFont))
    }
}
