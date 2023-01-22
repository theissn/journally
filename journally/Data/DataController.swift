//
//  DataController.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "HeadacheEntity")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Saved")
        } catch {
            print("Failed to save")
        }
    }
    
    func add(date: Date, pain: Double, weather: Double, stress: Double, sleep: Double, notes: String, medication: String, triggers: String, context: NSManagedObjectContext) {
        let headacheEntity = HeadacheEntity(context: context)
        
        headacheEntity.id = UUID()
        headacheEntity.date = date
        headacheEntity.pain = pain
        headacheEntity.weather = weather
        headacheEntity.stress = stress
        headacheEntity.sleep = sleep
        headacheEntity.notes = notes
        headacheEntity.medication = medication
        headacheEntity.triggers = triggers
        headacheEntity.createdAt = Date()
        
        save(context: context)
    }
    
    func edit(headacheEntity: HeadacheEntity, date: Date, pain: Double, weather: Double, stress: Double, sleep: Double, notes: String, medication: String, triggers: String, context: NSManagedObjectContext) {
        headacheEntity.date = date
        headacheEntity.pain = pain
        headacheEntity.weather = weather
        headacheEntity.stress = stress
        headacheEntity.sleep = sleep
        headacheEntity.notes = notes
        headacheEntity.medication = medication
        headacheEntity.triggers = triggers
        headacheEntity.updatedAt = Date()
        
        save(context: context)
    }
}
