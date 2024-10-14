//
//  ContentView.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 25.09.2024.
//

import SwiftUI

struct SearchConfig: Equatable {
    
    enum Filter {
        case all, fave
    }

    var query: String = ""
    var filter: Filter = .all
    
}

enum Sort {
    case asc, desc
}

struct ContentView: View {
    
    @FetchRequest(fetchRequest: Contact.all()) private var contacts

    @State private var contactToEdit: Contact?
    @State private var searchConfig: SearchConfig = .init()
    @State private var sort: Sort = .asc
    
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
                                ContactRowView(contact: contact, provider: provider)
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            do {
                                                try provider.delete(contact, in: provider.newContext)
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
            .searchable(text: $searchConfig.query)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        contactToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Section {
                            Text("Filter")
                            Picker(selection: $searchConfig.filter) {
                                Text("All").tag(SearchConfig.Filter.all)
                                Text("Favourites").tag(SearchConfig.Filter.fave)
                            } label: {
                                Text("Filter faves")
                            }
                        }
                        Section {
                            Text("Sort")
                            Picker(selection: $sort) {
                                Label("Asc", systemImage: "arrow.up").tag(Sort.asc)
                                Label("Desc", systemImage: "arrow.down").tag(Sort.desc)
                            } label: {
                                Text("Sort by")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
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
            .onChange(of: searchConfig) {
                contacts.nsPredicate = Contact.filter(with: searchConfig)
            }
            
            .onChange(of: sort) {
                contacts.nsSortDescriptors = Contact.sort(order: sort)
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
