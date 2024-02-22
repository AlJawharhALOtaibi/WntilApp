import SwiftUI
import CoreData

struct HistoryPage: View {
    @FetchRequest(
        entity: HistoryItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryItem.date, ascending: false)],
        animation: .default)
    private var historyItems: FetchedResults<HistoryItem>
    @Environment(\.managedObjectContext) private var viewContext
    
    var onSelect: ((HistoryItem) -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.customPurple
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                ScrollView {
                        ForEach(historyItems) { historyItem in
                            HStack {
                                VStack(alignment: .leading, spacing: 20) {
                                    if let date = historyItem.date {
                                        Text("\(formattedDate(date))")
                                            .foregroundStyle(.white)
                                    }
                                    Text("\(historyItem.stepCount) خطوة")
                                        .foregroundStyle(.white)
                                    Text("\(historyItem.calorieCount) سعرة حرارية")
                                        .foregroundStyle(.white)
                                }
                                .frame(width:250, height:100)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                                .background(Color.gray.opacity(0.2))
                                .padding(.horizontal)
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal,100)

                            .onTapGesture {
                                if let onSelect = onSelect {
                                    onSelect(historyItem)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            deleteHistoryItems(at: indexSet)
                        }
                    } 

                }
            }}
    }
    
    private func deleteHistoryItems(at offsets: IndexSet) {
        for index in offsets {
            let historyItem = historyItems[index]
            viewContext.delete(historyItem)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: date)
    }
}
