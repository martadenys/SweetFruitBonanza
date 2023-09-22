//
//  SavedImagesView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 21.09.2023.
//

import SwiftUI

struct SavedImagesView: View {
    
    @ObservedObject var vm: WheelViewModel = WheelViewModel()
    var grid: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    @Binding var closeSaved: Bool
    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    closeSaved = false
                    if vm.soundEffect {
                        vm.makeClick()
                    }
                }, label: {
                    Image(systemName: "xmark")
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
                }).padding()
                Text("My pictures")
                    .padding()
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.yellow)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.white)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.yellow,lineWidth: 5)
                            }
                    )
                Button(action: {
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    if vm.soundEffect {
                        vm.makeClick()
                    }
                }, label: {
                    Image(systemName: "trash")
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
                }).padding()
            }
            ScrollView {
                LazyVGrid(columns: grid, content: {
                    ForEach(vm.coloredImages, id:\.self) { image in
                        Image(image)
                            .resizable()
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                })
            }
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
            .onAppear {
                vm.getFromUserDefaults()
            }
    }
}

/*
#Preview {
    SavedImagesView(closeSaved: .constant(false))
}
*/
