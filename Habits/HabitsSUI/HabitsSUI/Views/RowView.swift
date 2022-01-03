//
//  RowView.swift
//  HabitsSUI
//
//  Created by iosdev on 01/11/2021.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject var listViewSetUp: ListViewSetUp
    let item: HabitModel
    
    var body: some View{
        HStack{
            Image(systemName: item.completed ? "checkmark.square": "square")
                .foregroundColor((item.completed ? .green : .gray)) // if bool = true checkmark will be green
            Text("\(item.name) will be reminded each \(item.time) minutes" )
                .frame(alignment: .topTrailing)
        }
        .font(.title2)
        .padding(.vertical , 8)
        
    }
}

struct RowView_Previews: PreviewProvider {
    
    static var item1 = HabitModel(name: "first", time: 2, completed: true)
    static var item2 = HabitModel(name: "second", time: 3, completed: false)
    static var previews: some View {
        Group{
            RowView(item: item1)
            RowView(item: item2)  //making prewiew
        }
        .previewLayout(.sizeThatFits)
        
    }
}
