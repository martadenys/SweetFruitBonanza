//
//  SlotsGrid.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 30.09.2023.
//

import SwiftUI

struct SlotsGrid: View {
    
    let proxy: GeometryProxy
    @StateObject var vm: WheelViewModel
    var rows: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        LazyVGrid(columns: rows) {
            ForEach(vm.slotsArray, id: \.self) { image in
                Image(image.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width / 7, height: proxy.size.height / 11)
                   
            }
        }.padding()
        .frame(width: proxy.size.width / 2, height: proxy.size.height / 11)
        .cornerRadius(15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.white.opacity(0.5))
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.yellow,lineWidth: 5)
            }
        )
    }
}
