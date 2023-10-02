//
//  CoreDataManager.swift
//  Sweet&Fruit Bonanza
//
//  Created by Roman Samborskyi on 30.09.2023.
//

import Foundation
import CoreData



class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    let containerName: String = "ImageContainer"
    let imageEntityName: String = "ImageEntity"
    let scoreEntityName: String = "ScoreEntity"
    
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Error of load CoreData: \(String(describing: error))")
            } else {
                print("CoreData loaded")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error of saving to CoreData: \(error)")
        }
    }
}
