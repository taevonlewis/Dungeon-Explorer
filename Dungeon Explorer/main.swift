//
//  main.swift
//  Dungeon Explorer
//
//  Created by TaeVon Lewis on 7/31/23.
//

import Foundation

class Room {
    var description: String
    var contents: Contents
    var exits: [String : Exit]
    
    weak var north: Room?
    weak var south: Room?
    weak var east: Room?
    weak var west: Room?
    
    enum Contents {
        case monster
        case treasure
        case empty
    }
    
    init(description: String, contents: Contents, exits: [String : Room]) {
        self.description = description
        self.contents = contents
        self.exits = [:]
    }
}

struct Exit {
    weak var room: Room?
}

func setupGame() {
    let room1 = Room(description: "You are in a cold and damp room.", contents: .empty, exits: [:])
    let room2 = Room(description: "You are in a room filled with cobwebs.", contents: .monster, exits: [:])
    let room3 = Room(description: "You are in a room with a flickering torch on the wall.", contents: .empty, exits: [:])
    let room4 = Room(description: "You see a glimmering chest in the middle of the room.", contents: .treasure, exits: [:])
    
    room1.exits["east"] = Exit(room: room2)
    room1.exits["south"] = Exit(room: room3)
    
    room2.exits["west"] = Exit(room: room1)
    room2.exits["south"] = Exit(room: room4)
    
    room3.exits["north"] = Exit(room: room1)
    room3.exits["east"] = Exit(room: room4)
    
    room4.exits["north"] = Exit(room: room2)
    room4.exits["west"] = Exit(room: room3)
    
    var currentRoom = room1
    while true {
        print(currentRoom.description)
        if let nextRoom = currentRoom.exits["east"]?.room {
            currentRoom = nextRoom
        } else {
            break
        }
    }
}

setupGame()

