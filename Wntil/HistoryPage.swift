//
//  HistoryPage.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 17/07/1445 AH.

import SwiftUI
import CoreData

struct HistoryPage: View {
    @FetchRequest(
        entity: HistoryItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryItem.date, ascending: false)],
        animation: .default)
    private var historyItems: FetchedResults<HistoryItem>

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("History List")
                        .font(.title)
                        .bold()
                        .padding(.top,30)
                    
                } .padding(.trailing, 200)

                List {
                    ForEach(historyItems) { historyItem in
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                if let date = historyItem.date {
                                    Text("\(formattedDate(date))")}
                                Text("\(historyItem.stepCount) steps")
                                Text("\(historyItem.calorieCount) Kcl")
                            }
                        }
                    }
                }
            }}
    }

    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }
}


struct HistoryListPage_Previews: PreviewProvider {
    static var previews: some View {
        HistoryPage()
    }
}
