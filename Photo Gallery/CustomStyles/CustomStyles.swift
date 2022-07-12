//
//  CustomStyles.swift
//  Photo Gallery
//
//  Created by Fatih Kilit on 12.07.2022.
//

import SwiftUI

struct CustomProfileLabelStyle: LabelStyle {
    let titleFont: Font
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            configuration.icon
            
            configuration.title
                .font(titleFont)
        }
    }
}
