//
//  ContactDetailView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 07.10.2024.
//

import SwiftUI

struct ContactDetailView: View {
    var body: some View {
        List {
            Section("Generel") {
                LabeledContent {
                    Text("Email Here")
                } label:{
                    Text("Email")
                }
                LabeledContent {
                    Text("Phone Number Here")
                } label:{
                    Text("Phone Number")
                }
                LabeledContent {
                    Text(.now, style: .date)
                } label:{
                    Text("Birthday")
                }
            }
            Section("Notes") {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tempus iaculis risus id fermentum. Nulla aliquam sit amet urna eu consectetur. Aenean leo augue, semper sit amet blandit et, cursus ac sapien. Donec hendrerit bibendum purus, eu condimentum dui luctus in. Quisque facilisis lacus nisi, a luctus dui sodales et. Nullam ut posuere urna. Nam molestie gravida lectus.")
            }
            
        }
        .navigationTitle("Name here")
    }
}

#Preview {
    NavigationStack {
        ContactDetailView()
    }
}
