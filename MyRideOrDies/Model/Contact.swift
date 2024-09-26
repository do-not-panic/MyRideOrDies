//
//  Contact.swift
//  MyRideOrDies
//
//  Created by René Pfammatter on 26.09.2024.
//

import Foundation
import CoreData

final class Contact: NSManagedObject {
    @NSManaged var dob: Date
    @NSManaged var name: String
    @NSManaged var notes: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
    @NSManaged var isFavourite: Bool
   
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "dob")
        setPrimitiveValue(false, forKey: "isFavourite")
    }
    
    
    
    
    
}


