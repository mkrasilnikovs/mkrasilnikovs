//
//  ContentView.swift
//  HabitsSUI
//
//  Created by iosdev on 12/10/2021.
//
import UserNotifications
import SwiftUI

struct NewHabitForm: View {
    @EnvironmentObject var listViewSetUp: ListViewSetUp
    @State var habit: String = ""
    @State var timeInMin: Int = 0
    @Binding var isPresented: Bool
    var body: some View {
        List{
            VStack(spacing: 20){
                Text("Enter New Habit")
                TextField("Enter new Habit", text: $habit)
                    .padding(.horizontal)
                    .font(.system(size: 25))
                    .frame(height: 55)
                    .cornerRadius(15)
                    .background(Color(.white))
                
                Text("Enter Time interval between notification in Min")
                TextField("Enter Time interval between notification in Min", text: Binding(get: {String(timeInMin)}, set:{timeInMin = Int($0) ?? 0}))
                    .padding(.horizontal)
                    .font(.system(size: 25))
                    .frame(height: 55)
                    .cornerRadius(15)
                    .background(Color(.white))
                    .keyboardType(.numberPad)
                
            }
            Button(action: {
                var checkIfEmpty = habit
                if checkIfEmpty == "" || timeInMin <= 0 {
                    checkIfEmpty = ""
                    timeInMin = 0
                }else{
                    listViewSetUp.saveHabit(name: habit, time: timeInMin)
                    DispatchQueue.main.async {
                        self.isPresented = false
                    }
                }
            }, label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    .hoverEffect(.lift)
            })
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Habit")
        .padding(14)
        .navigationTitle("Habits")
        .navigationBarItems(trailing: Button{
            isPresented = false
        } label:{
            Image(systemName: "xmark")
                .imageScale(.large)
                .hoverEffect(.lift)
        })
        .foregroundColor(.black)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NewHabitForm(isPresented: .constant(false))}
    }
}
