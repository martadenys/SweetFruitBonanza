//
//  ImageModel.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 29.09.2023.
//

import Foundation



struct ImageModel: Identifiable, Hashable {
    
    let id = UUID().uuidString
    var name: String
    var trim: CGFloat 
    var saturation: Double = 0
    let scoreToUnlock: Int
    
}
