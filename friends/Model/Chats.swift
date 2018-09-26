//
//  Chats.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 16/09/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import Foundation


class Chats {
    
    var partecipants: [Users]
    var messages: [Message]?
    
    
    
    init(partecipants: [Users]){
        self.partecipants = partecipants
    }
    
    
    
}
