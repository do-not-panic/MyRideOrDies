//
//  ContentView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 25.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(fetchRequest: Contact.all()) private var contacts

    @State private var contactToEdit: Contact?
    
    var provider = ContactsProvider.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if contacts.isEmpty {
                    NoContactsView()
                } else {
                    List {
                        ForEach(contacts) { contact in
                            ZStack(alignment: .leading) {
                                NavigationLink(
                                    destination: ContactDetailView(contact: contact)
                                ) {
                                    EmptyView()
                                }
                                .opacity(0)
                                ContactRowView(provider: provider, contact: contact)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do {
                                                try provider.delete(contact, in: provider.viewContext)
                                            } catch {
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            contactToEdit = contact
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        .tint(.orange)
                                    }
                            }
                        }
                    }
                }
                
                
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        contactToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            .sheet(item: $contactToEdit, onDismiss: {
                contactToEdit = nil
            }, content: { contact in
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider, contact: contact))
                }
            })
            .navigationTitle("Contacts")
        }
        
    }
}


#Preview("Contacts with Data") {
    let preview = ContactsProvider.shared
    ContentView(provider: preview)
        .environment(\.managedObjectContext, preview.viewContext)
        .onAppear { Contact.makePreview(count: 10, in: preview.viewContext)
            
        }
}

#Preview("Contacts with no Data") {
    let preview = ContactsProvider.shared
    ContentView(provider: preview)
        .environment(\.managedObjectContext, preview.viewContext)
}
