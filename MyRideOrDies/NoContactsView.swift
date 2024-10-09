//
//  NoContactView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 09.10.2024.
//

import SwiftUI

struct NoContactsView: View {
    var body: some View {
        VStack {
            Text("👀 No Contacts")
                .font(.largeTitle.bold())
            Text("It's seems like you don't have any contacts yet.")
                .font(.callout)
        }
    }
}

#Preview {
    NoContactsView()
}
