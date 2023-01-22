//
//  EditHeadacheEntryView.swift
//  headjour
//
//  Created by Theis on 22/01/2023.
//

import SwiftUI

struct EditHeadacheEntryView: View {
    var entry: FetchedResults<HeadacheEntity>.Element
    
    var body: some View {
        EntryForm(submitButtonText: "Update", entry: entry)
    }
}
