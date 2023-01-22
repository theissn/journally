//
//  Form.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import SwiftUI

struct EntryForm: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var date = Date()
    @State private var pain = 0.0
    @State private var weather = 0.0
    @State private var stress = 0.0
    @State private var sleep = 0.0
    @State private var notes = ""
    @State private var medication = ""
    @State private var triggers = ""
    
    var submitButtonText: String
    
    var entry: FetchedResults<HeadacheEntity>.Element?

    var body: some View {
        Form {
            Section {
                DatePicker("Date", selection: $date, displayedComponents: .date).padding([.vertical], 10)
                    .onAppear {
                        if entry == nil {
                            return
                        }
                        
                        date = entry?.date ?? Date()
                        pain = entry?.pain ?? 0.0
                        weather = entry?.weather ?? 0.0
                        stress = entry?.stress ?? 0.0
                        sleep = entry?.sleep ?? 0.0
                        notes = entry?.notes ?? ""
                        medication = entry?.medication ?? ""
                        triggers = entry?.triggers ?? ""
                    }
                
                VStack (alignment: .leading) {
                    Text("Pain: \(Int(pain))")
                    Slider(value: $pain, in: 0...10, step: 1)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Stress: \(Int(stress))")
                    Slider(value: $stress, in: 0...10, step: 1)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Sleep: \(Int(sleep))")
                    Slider(value: $sleep, in: 0...10, step: 1)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Weather: \(Int(weather))")
                    Slider(value: $weather, in: 0...10, step: 1)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Notes")
                    TextEditor(text: $notes)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Medication")
                    TextEditor(text: $medication)
                }
                .padding([.vertical], 10)
                
                VStack (alignment: .leading) {
                    Text("Triggers")
                    TextEditor(text: $triggers)
                }
                .padding([.vertical], 10)
                
                HStack {
                    Spacer()
                    Button(submitButtonText) {
                        if entry == nil {
                            DataController().add(date: date, pain: pain, weather: weather, stress: stress, sleep: sleep, notes: notes, medication: medication, triggers: triggers, context: managedObjectContext)
                        } else {
                            DataController().edit(headacheEntity: entry!, date: date, pain: pain, weather: weather, stress: stress, sleep: sleep, notes: notes, medication: medication, triggers: triggers, context: managedObjectContext)
                        }
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

struct Form_Previews: PreviewProvider {
    static var previews: some View {
        EntryForm(submitButtonText: "Update")
    }
}
