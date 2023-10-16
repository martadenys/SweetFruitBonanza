//
//  WheelViewModel.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 20.09.2023.
//

import Foundation
import AVFoundation
import SwiftUI
import CoreData


@MainActor
class WheelViewModel: ObservableObject {
    
    
    @Published var images: [ImageModel] = []
    @Published var lockedImages: [ImageModel] = []
    @Published var slotsArray: [ImageModel] = []
    @Published var coloredImages: [ImageEntity] = []
    @Published var scoresArray: [ScoreEntity] = []
    @Published var soundEffect: Bool = true
    @Published var score: Int = 100
    @Published var isBonus: Bool = false
    
    private var coreData = CoreDataManager.instance
    
    
    init() {
        getScores()
        getLockedImages()
        getSavedImages()
        getimages()
        updateImage()
    }
    
    
    
    func getimages() {
        let images = [
            ImageModel(name: "1", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "9", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "3", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "4", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "5", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "6", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "7", trim: 0, scoreToUnlock: 0),
            ImageModel(name: "8", trim: 0, scoreToUnlock: 0)
        ]
        self.images = images
    }
    
    func getLockedImages() {
        let images = [
            ImageModel(name: "u.1", trim: 0, scoreToUnlock: 2500),
            ImageModel(name: "u.2", trim: 0, scoreToUnlock: 3500),
            ImageModel(name: "u.3", trim: 0, scoreToUnlock: 4500),
            ImageModel(name: "u.4", trim: 0, scoreToUnlock: 5500),
            ImageModel(name: "u.5", trim: 0, scoreToUnlock: 6500),
            ImageModel(name: "u.6", trim: 0, scoreToUnlock: 7500)
        ]
        self.lockedImages = images
    }
    //Fetching saved images from core data
    func getSavedImages() {
        let request = NSFetchRequest<ImageEntity>(entityName: coreData.imageEntityName)
        
        do {
            coloredImages = try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching: \(error)")
        }
    }
    //Fetching scores from core data
    func getScores() {
        let request = NSFetchRequest<ScoreEntity>(entityName: coreData.scoreEntityName)
        
        do {
            scoresArray = try coreData.context.fetch(request)
        } catch let error {
            print("Error of fetching scores: \(error)")
        }
    }
    //Delete all saved images
    func deleteSavedImages() {
        let request: NSFetchRequest<NSFetchRequestResult> = ImageEntity.fetchRequest()
        let bachRequest = NSBatchDeleteRequest(fetchRequest: request)
        try! coreData.context.execute(bachRequest)
        save()
    }
    //Return sum of scores witch stored in core data
    func returnTotalScores() -> Int {
        var array: [Int64] = []
        for score in scoresArray {
            array.append(score.amount)
        }
        return Int(array.reduce(Int64(0), +))
    }
    
    func calculateSegment(at angle: CGFloat, images: [ImageModel]) -> ImageModel {
        let segmentCount = images.count
        let anglePerSegment = (2 * .pi) / CGFloat(segmentCount)
        let normalizedAngle = (angle + .pi * 2).truncatingRemainder(dividingBy: .pi * 2)
        let segmentIndex = Int((normalizedAngle + anglePerSegment / 2) / anglePerSegment)
        let clampedSegmentIndex = segmentIndex < 0 ? segmentCount - 1 : segmentIndex % segmentCount
        return images[clampedSegmentIndex]
    }
    //Saving colored images to core data
    func saveColoredImage(for name: String) {
        let newImage = ImageEntity(context: coreData.context)
        newImage.name = name
        newImage.saturation = 0
        newImage.trim = 0
        getSavedImages()
        addScores(for: 200)
        save()
    }
    
    func addScores(for score: Int64) {
        let newScore = ScoreEntity(context: coreData.context)
        newScore.amount = score
        getScores()
        save()
    }
    
    func save() {
        coreData.save()
    }
    
    func makeClick() {
        let systemSoundId: SystemSoundID = 1104
        AudioServicesPlaySystemSound(systemSoundId)
    }
    
    func winSound() {
        let systemSoundId: SystemSoundID = 1322
        AudioServicesPlaySystemSound(systemSoundId)
    }
    //Add image fro wheel to display in slots view
    func addToSlotsArray(for name: String) {
        if slotsArray.count < 3 {
            slotsArray.append(ImageModel(name: name, trim: 0, scoreToUnlock: 0))
        } else {
            slotsArray.removeAll()
        }
    }
    //Check the slots array
    func checkSlotsCapacity() {
        if slotsArray.count == 3 {
            if slotsArray[0].name == slotsArray[1].name && slotsArray[1].name == slotsArray[2].name {
                addScores(for: 200)
                self.isBonus = true
            } else if slotsArray[0].name == slotsArray[1].name {
                addScores(for: 100)
                self.isBonus = true
            } else if slotsArray[0].name == slotsArray[2].name {
                addScores(for: 100)
                self.isBonus = true
            } else if slotsArray[1].name == slotsArray[2].name {
                addScores(for: 100)
                self.isBonus = true
            }
        }
    }
    //Trim calculation for each image, which depend of total scores
    func trimCalculate(for image: ImageModel, scores score: Int) {
        guard let index = lockedImages.firstIndex(where: {$0.id == image.id}) else { return }
            let scorePercent = CGFloat(score) / CGFloat(lockedImages[index].scoreToUnlock) * CGFloat(100)
            let currentTrim: CGFloat = CGFloat(scorePercent) / CGFloat(1.0) / CGFloat(100)
            lockedImages[index].trim = currentTrim
        if score >= lockedImages[index].scoreToUnlock {
            lockedImages[index].saturation = 1.0
        }
    }
    //Updating image on the wheel after reaching some amount of the scores
    func updateImage() {
        for index in 0...5 {
            if returnTotalScores() >= lockedImages[index].scoreToUnlock {
                images[index] = lockedImages[index]
            }
        }
    }
}


