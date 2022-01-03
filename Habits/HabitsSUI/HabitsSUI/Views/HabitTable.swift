//
//  HabitTable.swift
//  HabitsSUI
//
//  Created by iosdev on 27/10/2021.
//

import SwiftUI
struct HabitTable: View {
    @StateObject private var notificationManager = NotificationManager()
    @EnvironmentObject var listViewSetUp: ListViewSetUp
    @State private var isCreatePresented = false
    @State private var isEditPresented  = false
    @State private var index = -1
    var body: some View {
        VStack{
            NavigationView{
                VStack(){
                    List{
                        ForEach(listViewSetUp.habitArray){ item in
                            RowView(item: item)
                                .contextMenu {
                                    Button {
                                        index = listViewSetUp.editHabit(habit: item)
                                        isEditPresented = true
                                    } label: {
                                        Label("Edit Habit", systemImage: "text.cursor")
                                    }
                                }
                            
                                .onTapGesture(){
                                    withAnimation(.linear){
                                        listViewSetUp.updateHabitStatus(habit: item)
                                    }
                                }
                        }
                        .onDelete(perform: listViewSetUp.deleteHabit)
                        .onMove(perform: listViewSetUp.relocateHabit)
                        
                    }
                    .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                    .onChange(of: notificationManager.authorizationStatus){ authorizationStatus in
                        switch authorizationStatus{
                        case .notDetermined:
                            notificationManager.requestAuthorisation()
                            break
                        case .authorized:
                            notificationManager.reloadLocalNotifications()
                            break
                        default:
                            break
                        }
                    }
                }
            }
            HStack(){
                Button("Start", action:{listViewSetUp.startButtonPressed()})
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth:150)
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    .hoverEffect(.lift)
                
                Button("Stop", action: {listViewSetUp.stopButtonPressed()})
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth:150)
                    .background(Color.accentColor)
                    .cornerRadius(15)
                    .hoverEffect(.lift)
            }
        }
        .onAppear(){
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Habits")
        
        .sheet(isPresented: $isEditPresented){
            NavigationView{
                EditView(isPresented: $isEditPresented, habitIndex: $index) //sending to view
            }
        }
        
        .navigationBarItems(trailing: Button{
            isCreatePresented = true
        } label:{
            Image(systemName:  "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented){
            NavigationView{
                NewHabitForm(isPresented: $isCreatePresented) //sending to view
            }
        }
        .navigationBarItems(leading: EditButton())
    }
}
struct HabitTable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HabitTable()
        }
        .environmentObject(ListViewSetUp())
    }
}
