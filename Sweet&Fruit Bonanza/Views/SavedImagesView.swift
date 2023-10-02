//
//  SavedImagesView.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 21.09.2023.
//

import SwiftUI

struct SavedImagesView: View {
    
    @ObservedObject var vm: WheelViewModel
    var grid: [GridItem] = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        VStack {
            HStack {
                if #available(iOS 15.0, *) {
                    Text("My pictures")
                        .padding()
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow,lineWidth: 5)
                                }
                        )
                } else {
                    // Fallback on earlier versions
                }
                Button(action: {
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    if vm.soundEffect {
                        vm.makeClick()
                    }
                    vm.deleteSavedImages()
                }, label: {
                    if #available(iOS 15.0, *) {
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
                    } else {
                        // Fallback on earlier versions
                    }
                }).padding()
            }
            ScrollView {
                LazyVGrid(columns: grid) {
                    ForEach(vm.coloredImages) { image in
                        Image(image.name ?? "No name")
                            .resizable()
                            .padding()
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
            .onAppear {
                vm.getSavedImages()
            }
    }
}

/*
#Preview {
    SavedImagesView(vm: WheelViewModel())
}
*/
