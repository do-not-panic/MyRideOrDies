//
//  CreateContactView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 07.10.2024.
//

import SwiftUI

struct CreateContactView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            
            Section("General") {
                TextField("Name", text: .constant(""))
                    .keyboardType(.namePhonePad)
                TextField("Email", text: .constant(""))
                    .keyboardType(.emailAddress)
                TextField("Phone Number", text: .constant(""))
                    .keyboardType(.phonePad)
                DatePicker("Birthday", selection: .constant(.now), displayedComponents: [.date])
                Toggle("Favourite", isOn: .constant(true))
                
            }
            
            Section("Notes") {
                TextField("", text: .constant("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tempus iaculis risus id fermentum. Nulla aliquam sit amet urna eu consectetur. Aenean leo augue, semper sit amet blandit et, cursus ac sapien. Donec hendrerit bibendum purus, eu condimentum dui luctus in. Quisque facilisis lacus nisi, a luctus dui sodales et. Nullam ut posuere urna. Nam molestie gravida lectus."), axis: .vertical)
            }
        }
        .navigationTitle("Name Here")
        
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done"){
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        CreateContactView()
    }
}
