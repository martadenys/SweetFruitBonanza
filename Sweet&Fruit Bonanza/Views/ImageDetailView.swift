//
//  ImageDetailView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import SwiftUI

struct ImageDetailView: View {
    
    @State private var saturation: Double = 0
    @State private var finishGame: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.presentationMode) var presentation
    @Binding var image: String
    @ObservedObject var vm: WheelViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                        if vm.soundEffect {
                            vm.makeClick()
                        }
                    }, label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "arrowshape.left")
                                .padding()
                                .foregroundColor(Color.yellow)
                                .font(.system(size: 25).weight(.bold))
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
                    })
                    Spacer()
                
                }.padding()
                .offset(y: geo.size.height * -0.40)
                if verticalSizeClass == .regular {
                   RegularImageView(geo: geo, image: $image, saturation: $saturation, finishGame: $finishGame, vm: vm)
                        .blur(radius: finishGame ? 5.0 : 0.0)
                } else if verticalSizeClass == .compact {
                   CompactImageView(geo: geo, image: $image, saturation: $saturation, finishGame: $finishGame, vm: vm)
                        .blur(radius: finishGame ? 5.0 : 0.0)
                }
                if finishGame {
                    Image("win")
                        .resizable()
                        .frame(width: geo.size.width / 1, height: geo.size.height / 2)
                        .onAppear {
                            if vm.soundEffect {
                                vm.winSound()
                            }
                        }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundView())
                
        }
    }
}

/*
#Preview {
    ImageDetailView(image: .constant("1"))
}
*/


struct RegularImageView: View {
    
   var geo: GeometryProxy
   @Binding var image: String
   @Binding var saturation: Double
   @Binding var finishGame: Bool
    @ObservedObject var vm: WheelViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 25)
                    .padding()
                    .frame(width: geo.size.width / 1, height: geo.size.height / 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(0.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 7)
                            .padding()
                    }
            } else {
                // Fallback on earlier versions
            }
            Image(image)
                .resizable()
                .frame(width: geo.size.width / 1.4, height: geo.size.height / 3)
                .colorScheme(.dark)
                .saturation(saturation)
                .gesture(DragGesture()
                    .onChanged({ _ in
                        self.saturation += 0.008
                        if saturation >= 0.6 && !finishGame {
                            vm.saveColoredImage(for: image)
                            self.finishGame = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.presentation.wrappedValue.dismiss()
                                self.finishGame = false
                            }
                        }
                    })
                )
        }
    }
}

struct CompactImageView: View {
    
    var geo: GeometryProxy
    @Binding var image: String
    @Binding var saturation: Double
    @Binding var finishGame: Bool
     @ObservedObject var vm: WheelViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 25)
                    .padding()
                    .frame(width: geo.size.width / 2, height: geo.size.height / 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .opacity(0.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 7)
                            .padding()
                    }
            } else {
                // Fallback on earlier versions
            }
            Image(image)
                .resizable()
                .frame(width: geo.size.width / 3, height: geo.size.height / 2)
                .colorScheme(.dark)
                .saturation(saturation)
                .gesture(DragGesture()
                    .onChanged({ _ in
                        self.saturation += 0.008
                        if saturation >= 0.6 && !finishGame {
                            vm.saveColoredImage(for: image)
                            self.finishGame = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                self.presentation.wrappedValue.dismiss()
                                self.finishGame = false
                            }
                        }
                    })
                )
        }
    }
}
