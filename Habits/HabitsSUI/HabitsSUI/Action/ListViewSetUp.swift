//
//  ListViewSetUp.swift
//  HabitsSUI
//
//  Created by iosdev on 03/11/2021.
//

import Foundation
import UserNotifications
import SwiftUI

class ListViewSetUp: ObservableObject {
    @Published private var notificationManager = NotificationManager()
    @Published var habitArray:[HabitModel] = []{
        didSet{
            saveHabitUD()
        }
    }
    let habitKey: String = "habit_list"
    
    init() {
        getHabit()
    }
    func getHabit() {
        guard let data = UserDefaults.standard.data(forKey: habitKey) else{return}
        guard let saveHab = try? JSONDecoder().decode([HabitModel].self, from: data)else{return}
        self.habitArray = saveHab
    }
    func deleteHabit(as offsets: IndexSet){
        let index = offsets[offsets.startIndex]
        print(index)
        notificationManager.removeSingleNotification(id: habitArray[index].id)
        habitArray.remove(atOffsets: offsets)
    }
    func relocateHabit(from: IndexSet, to : Int){
        habitArray.move(fromOffsets: from, toOffset: to)
    }
    func editHabit(habit: HabitModel)-> Int{
        if let index = habitArray.firstIndex(where: {$0.id == habit.id}){
            habitArray[index] = habit.updateHabitStatus()
            return index
        }
        return -1
    }
    
    func saveHabit(name: String, time: Int)  {
        let id = UUID().uuidString
        let newHabit = HabitModel(id: id, name: name, time:time, completed: false)
        habitArray.append(newHabit)
        notificationManager.scheduleNotificanion(name: name, time: time ,completed: false, id: id) // single notification for added item
        
    }
    
    func updateHabitStatus(habit: HabitModel) {
        if let index = habitArray.firstIndex(where: {$0.id == habit.id}){
            habitArray[index] = habit.updateHabitStatus()
            if habitArray[index].completed == false{
                notificationManager.removeSingleNotification(id: habitArray[index].id)
            }else{
                notificationManager.scheduleNotificanion(name: habitArray[index].name, time: habitArray[index].time, completed: habitArray[index].completed, id: habitArray[index].id)
            }
        }
    }
    func saveHabitUD() {
        if let encodeData = try? JSONEncoder().encode(habitArray){
            UserDefaults.standard.set(encodeData,forKey: habitKey)
        }
    }
    func createNotification() {
        habitArray.forEach {item in
            notificationManager.scheduleNotificanion(name: item.name, time: item.time ,completed: item.completed, id: item.id)
        }
    }
    func startButtonPressed(){
        NotificationManager.notificationManager.cancelNotifications()
        createNotification()
    }
    func stopButtonPressed(){
        NotificationManager.notificationManager.cancelNotifications()
        
    }
    func createRemakedHabit(oldID: String, newName: String, newTime: Int, completed : Bool,index: Int){
        let newHabit = HabitModel(id: oldID, name: newName, time: newTime, completed: false)
        habitArray[index] = newHabit
        notificationManager.scheduleNotificanion(name: newName, time: newTime, completed: completed, id: oldID)
    }
}
