//
//  ContentView.swift
//  HabitsSUI
//
//  Created by iosdev on 12/10/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var text: String = ""
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("New Habit")){
                    HStack{
                        VStack{
                        TextField("Enter new Habit", text: $text)
                            TextField("Enter Time in min",text: $text)}
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Save")
                        })
                    }
                }
                Section{
                    Text("hhhh")
                }
            }
            .navigationTitle("Habits")
            .foregroundColor(.blue)
        }
        
                }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
