//
//  EditView.swift
//  HabitsSUI
//
//  Created by iosdev on 19/11/2021.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var listViewSetUp: ListViewSetUp
    @State var newName: String = ""
    @State var newTime: Int = 0
    @Binding var isPresented: Bool
    @Binding var habitIndex: Int
    var body: some View {
        
        List{
            VStack(spacing: 20){
                Text("Enter new Habit")
                TextField("Enter new Habit", text: $newName)
                    .padding(.horizontal)
                    .font(.system(size: 25))
                    .frame(height: 55)
                    .cornerRadius(15)
                    .background(Color(.white))
                
                
                Text("Enter Time interval between notification in Min")
                TextField("Enter Time interval between notification in Min", text: Binding(get: {String(newTime)}, set:{newTime = Int($0) ?? 0}))
                    .padding(.horizontal)
                    .font(.system(size: 25))
                    .frame(height: 55)
                    .cornerRadius(15)
                    .background(Color(.white))
                    .keyboardType(.numberPad)
                
            }
            Button(action: {
                var checkIfEmpty = newName
                if checkIfEmpty == "" || newTime <= 0 {
                    checkIfEmpty = ""
                    newTime = 0
                }else{
                    let oldID = listViewSetUp.habitArray[habitIndex].id
                    let oldStatus = !listViewSetUp.habitArray[habitIndex].completed
                    listViewSetUp.createRemakedHabit(oldID: oldID, newName: newName, newTime: newTime, completed: oldStatus, index: habitIndex)
                    DispatchQueue.main.async {
                        self.isPresented = false
                    }
                }
            }
                   , label: {
                Text("Edit".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    .hoverEffect(.lift)
            })
        }
        .navigationTitle("Edit Habits")
        .foregroundColor(.black)
        .navigationBarItems(trailing: Button{
            isPresented = false
        } label:{
            Image(systemName: "xmark")
                .imageScale(.large)
                .hoverEffect(.lift)
        })
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EditView(isPresented: .constant(false), habitIndex: .constant(-1))
        }
    }
}
