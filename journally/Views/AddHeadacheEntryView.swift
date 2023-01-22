//
//  AddHeadacheEntryView.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import SwiftUI

struct AddHeadacheEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            EntryForm(submitButtonText: "Add")
        }.navigationTitle("Test").toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

struct AddHeadacheEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddHeadacheEntryView()
    }
}
