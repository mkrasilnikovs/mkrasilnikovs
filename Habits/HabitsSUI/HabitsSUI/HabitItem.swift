//
//  HabitItem.swift
//  HabitsSUI
//
//  Created by iosdev on 14/10/2021.
//

import Foundation
import CoreData

class HabitItem: NSManagedObject, Identifiable {
    @NSManaged var name :String?
    @NSManaged var creationTime: Date?
    @NSManaged var timerFromhabitStart : String?
}
extension HabitItem{
    static func getAllHabitItems()-> NSFetchRequest<HabitItem>{
        let request : NSFetchRequest<HabitItem> = HabitItem.fetchRequest() as! NSFetchRequest<HabitItem>
        
        let sort = NSSortDescriptor(key:"creationTime", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }
}
