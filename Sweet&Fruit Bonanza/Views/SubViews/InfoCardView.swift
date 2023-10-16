//
//  InfoCardView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 30.09.2023.
//

import SwiftUI

struct InfoCardView: View {
    
    @Binding var showInfo: Bool
    @ObservedObject var vm: WheelViewModel
    @AppStorage("userOnboarded") var userOnboarded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(Animation.spring()) {
                        if vm.soundEffect {
                            vm.makeClick()
                        }
                        showInfo = false
                        userOnboarded = true
                    }
                }, label: {
                    if #available(iOS 15.0, *) {
                        Image(systemName: "xmark")
                            .padding()
                            .foregroundStyle(Color.yellow)
                            .font(.custom("ChalkboardSE-Regular", size: 25))
                            .background(
                                Circle()
                                    .foregroundColor(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(Color.yellow,lineWidth: 5)
                                    }
                            )
                    } else {
                        // Fallback on earlier versions
                    }
                }).padding(5)
                Text("Rules of the game:")
                    .font(.custom("ChalkboardSE-Regular", size: 25))
                    .foregroundColor(Color.white)
            }.padding(10)
            .font(.system(size: 25,weight: .bold))
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
            ScrollView(showsIndicators: false) {
                Text("1. Rub the image until it becomes colored. You get 200 points for each colored picture. You can find colored images in the saved tab.").padding(.vertical,5)
                Text("2. Each time you spin the wheel, the image from the wheel is added to the slots above the wheel. If you get the same image three times, you get a bonus of 200 points. If only two images match on the wheel, you will receive only 100 bonus points.").padding(.vertical,5)
                Text(" 3. In the achievements tab, there are additional scrolls that you can open by accumulating points. Each image has a progress ring, once the ring is filled the image will unlock and replace a random image on the wheel. This way you can open new images for the game and your collection of saved images.We wish you a pleasant and exciting game!").padding(.vertical,5)
            }.padding()
            .foregroundColor(Color.white)
            .font(.custom("ChalkboardSE-Regular", size: 25))
                .background(Color.black.opacity(0.7))
                .cornerRadius(15)
          
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: 670)
    }
}

//#Preview {
//    InfoCardView(showInfo: <#Binding<Bool>#>, vm: WheelViewModel())
//}
