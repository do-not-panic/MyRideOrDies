//
//  ContentView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 25.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingNewContact = false
    
    @FetchRequest(fetchRequest: Contact.all()) private var contacts
    
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
                                ContactRowView(contact: contact)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do {
                                                try delete(contact)
                                            } catch {
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            
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
                        isShowingNewContact.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isShowingNewContact) {
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider))
                }
            }
            .navigationTitle("Contacts")
        }
        
    }
}

private extension ContentView {
    
    func delete(_ contact: Contact) throws {
        let context = provider.viewContext
        let exisitingContact = try context.existingObject(with: contact.objectID)
        context.delete(exisitingContact)
        Task(priority: .background) {
            try await context.perform {
                try context.save()
            }
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
