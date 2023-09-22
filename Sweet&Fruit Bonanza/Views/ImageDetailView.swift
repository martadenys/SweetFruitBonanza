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
    @State private var showInfo: Bool = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss
    @Binding var image: String
    @ObservedObject var vm: WheelViewModel = WheelViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Button(action: {
                        dismiss()
                        if vm.soundEffect {
                            vm.makeClick()
                        }
                    }, label: {
                        Image(systemName: "arrowshape.left")
                            .padding()
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 25).weight(.bold))
                            .background(
                                Circle()
                                    .foregroundStyle(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(Color.yellow,lineWidth: 5)
                                    }
                            )
                    })
                    Spacer()
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            self.showInfo.toggle()
                            if vm.soundEffect {
                                vm.makeClick()
                            }
                        }
                    }, label: {
                        Image(systemName: showInfo ? "xmark" : "info.circle")
                            .padding()
                            .foregroundStyle(Color.yellow)
                            .font(.system(size: 25).weight(.bold))
                            .background(
                                Circle()
                                    .foregroundStyle(Color.white)
                                    .overlay {
                                        Circle()
                                            .stroke(Color.yellow,lineWidth: 5)
                                    }
                            )
                    })
                }.padding()
                .offset(y: geo.size.height * -0.40)
                if verticalSizeClass == .regular {
                   RegularImageView(geo: geo, image: $image, saturation: $saturation, finishGame: $finishGame, vm: vm)
                } else if verticalSizeClass == .compact {
                   CompactImageView(geo: geo, image: $image, saturation: $saturation, finishGame: $finishGame, vm: vm)
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
                } else if showInfo {
                    InfoView()
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

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Rules:")
                .padding()
            Text("Rub the image until it becomes colored, after which it will be saved to your album")
            
        }
        .frame(width: 350, height: 350)
        .padding()
        .font(.system(size: 30, weight: .semibold))
        .foregroundStyle(.yellow)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow,lineWidth: 5)
                }
        )
    }
}


struct RegularImageView: View {
    
   var geo: GeometryProxy
   @Binding var image: String
   @Binding var saturation: Double
   @Binding var finishGame: Bool
    @ObservedObject var vm: WheelViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .padding()
                .frame(width: geo.size.width / 1, height: geo.size.height / 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.5)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 7)
                        .padding()
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
                                dismiss()
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
     @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .padding()
                .frame(width: geo.size.width / 2, height: geo.size.height / 1.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .opacity(0.5)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 7)
                        .padding()
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
                                dismiss()
                                self.finishGame = false
                            }
                        }
                    })
                )
        }
    }
}
