//
//  ContactDetailView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 07.10.2024.
//

import SwiftUI

struct ContactDetailView: View {
    
    let contact: Contact
    
    var body: some View {
        List {
            Section("Generel") {
                LabeledContent {
                    Text(contact.email)
                } label:{
                    Text("Email")
                }
                LabeledContent {
                    Text(contact.phoneNumber)
                } label:{
                    Text("Phone Number")
                }
                LabeledContent {
                    Text(contact.dob, style: .date)
                } label:{
                    Text("Birthday")
                }
            }
            Section("Notes") {
                Text(contact.notes)
            }
            
        }
        .navigationTitle(contact.formattedName)
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(contact: .preview())
    }
}
