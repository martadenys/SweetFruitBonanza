//
//  BackgroundView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image("background").resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        }
    }
}

/*

#Preview {
    BackgroundView()
}
*/
