//
//  ContentView.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var entry: FetchedResults<HeadacheEntity>
    
    @State private var showAddNewView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                    
                if entry.isEmpty {
                    Text("Add new entry by clicking the button in the top right").padding([.horizontal], 25).padding([.vertical], 20)
                }
                
                List {
                    ForEach(entry) { entry in
                        NavigationLink(destination: EditHeadacheEntryView(entry: entry)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(entry.date!.getFormattedDate(format: "EEEE, MMM d, yyyy"))").bold()
                                }
                                Spacer()
                                
                            }
                        }
                    }.onDelete(perform: deleteEntry)
                }.listStyle(.plain).padding([.vertical], 10)
            }
            .navigationTitle("Journally")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddNewView.toggle()
                    } label: {
                        Label("Add Entry", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showAddNewView) {
                AddHeadacheEntryView()
            }
        }
    }
    
    private func formatDate(date: Date) {
        
    }
    
    private func deleteEntry(offsets: IndexSet) {
        withAnimation {
            offsets.map { entry[$0] }.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
