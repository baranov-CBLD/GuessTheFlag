//
//  ImageView.swift
//  GuessTheFlag
//
//  Created by Kirill Baranov on 29/11/23.
//

import SwiftUI

struct FlagImageView: View {
    var counrtyName: String
    
    @Binding var tapped: Bool
    
    var body: some View {
        Image(counrtyName.lowercased())
            .clipShape(Capsule())
            .shadow(radius: 5)
            .opacity(tapped ? 0.25 : 1)
            .scaleEffect(tapped ? 0.5 : 1)
    }
}
