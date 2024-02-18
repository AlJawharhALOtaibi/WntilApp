import SwiftUI
import CoreData

struct HistoryPage: View {
    @FetchRequest(
        entity: HistoryItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \HistoryItem.date, ascending: false)],
        animation: .default)
    private var historyItems: FetchedResults<HistoryItem>
    @Environment(\.managedObjectContext) private var viewContext
    
    var onSelect: ((HistoryItem) -> Void)? // Closure to return selected history item
    
    var body: some View {
        NavigationView {
            VStack {
//                HStack {
//                    Text("جولاتك السابقة")
//                        .font(.title)
//                        .bold()
//                        .padding(.top, 30)
//                }
//                .padding(.trailing, 200)
//                
                List {
                    ForEach(historyItems) { historyItem in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                if let date = historyItem.date {
                                    Text("\(formattedDate(date))")
                                }
                                Text("\(historyItem.stepCount) خطوة")
                                Text("\(historyItem.calorieCount) سعرة حرارية")
                            }
                        }
                        .onTapGesture {
                            if let onSelect = onSelect {
                                onSelect(historyItem) // Call the closure with selected history item
                            }
                        }
                    }
                    .onDelete { indexSet in
                        deleteHistoryItems(at: indexSet)
                    }
                }
            }
        }
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
