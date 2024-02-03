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
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryItem.date, ascending: true)],
        animation: .default)
    private var historyItems: FetchedResults<HistoryItem>

    var body: some View {
        List {
            ForEach(historyItems) { historyItem in
                HStack {
                    Image(systemName: "calendar") // Replace with the name of your image asset
                        .resizable()
                        .frame(width: 20, height: 20) // Adjust size as needed
                        .padding(.trailing, 8) // Add padding between image and text

                    VStack(alignment: .leading, spacing: 4) {
                        if let date = historyItem.date {
                            Text("\(formattedDate(date))")
                        }
                        Text("\(historyItem.stepCount) steps")
                        Text("\(historyItem.calorieCount) Kcl")
                    }
                }
            }
        }
        .navigationTitle("History List")
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
