//
//  Events.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 01/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Event: NSObject {
    
    let defaultEventImage = UIImage(named: "eventBowling")
    var eventImage: UIImage?
    var eventName: String
    var eventDate: Date
    let creationDate = Date()
    var eventDescription: String
    var participants: [Users]
    var createdBy: Users
    var type: InterestsEnum? 
    let eventLocal: CLLocation
    
    
    
    init(eventImage: UIImage? ,eventName: String ,eventDate: Date , eventDescription: String ,participants: [Users], createdBy: Users, eventLocal: CLLocation) {
        self.eventImage = eventImage == nil ? defaultEventImage:eventImage
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventDescription = eventDescription
        self.participants = participants
        self.createdBy = createdBy
        self.eventLocal = eventLocal
        
    }
    

}
