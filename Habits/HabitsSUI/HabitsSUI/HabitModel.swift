//
//  HabitModel.swift
//  HabitsSUI
//
//  Created by iosdev on 01/11/2021.
//

import Foundation

struct HabitModel: Identifiable, Codable {
    let id: String  //creating  random id for model
    let name: String
    let time: Int
    let completed: Bool
    
    init(id: String = UUID().uuidString, name: String, time: Int, completed: Bool) {
        self.id = id
        self.name = name
        self.time = time
        self.completed = completed 
    }
    
    func updateHabitStatus() -> HabitModel {
        return HabitModel(id: id, name: name, time: time, completed: !completed)
    }
}
