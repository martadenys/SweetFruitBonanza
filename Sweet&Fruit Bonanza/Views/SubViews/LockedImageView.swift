//
//  LockedImageView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 30.09.2023.
//

import SwiftUI

struct LockedImageView: View {
    
    @ObservedObject var vm: WheelViewModel
    let image: ImageModel
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green,lineWidth: 10)
                .frame(width: 120)
            Circle()
                .trim(from: image.trim, to: 1.0)
                .stroke(Color.gray,lineWidth: 10)
                .frame(width: 120)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: 0.2)
            Image(image.name)
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .saturation(image.saturation)
        }.padding()
           
    }
}
