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
    var exits: [Direction: Exit]
    var availableDirections: [Direction] {
        return Array(exits.keys)
    }
    
    enum Contents {
        case monster
        case treasure
        case key
        case lockedDoor
        case empty
    }

    init(description: String, contents: Contents, exits: [String: Room]) {
        self.description = description
        self.contents = contents
        self.exits = [:]
    }
}

struct Exit {
    weak var room: Room?
}

enum Direction: String {
    case north, south, east, west
}

class Player {
    var currentRoom: Room
    var inventory: [String]
    var hasKey: Bool
    var gameWon: Bool
    var gameLost: Bool
    
    init(startingRoom: Room) {
        self.currentRoom = startingRoom
        self.hasKey = false
        self.inventory = []
        self.gameWon = false
        self.gameLost = false
    }
}

enum GameError: Error {
    case invalidDirection
    case monsterInTheRoom
    case lockedDoor
}

func setupGameWorld() -> [Room] {
    let room1 = Room(description: "You are in a cold and damp room.", contents: .empty, exits: [:])
    let room2 = Room(description: "You are in a room filled with cobwebs.", contents: .monster, exits: [:])
    let room3 = Room(description: "You are in a room with a flickering torch on the wall.", contents: .empty, exits: [:])
    let room4 = Room(description: "You see a glimmering chest in the middle of the room.", contents: .treasure, exits: [:])
    
    room1.exits[.east] = Exit(room: room2)
    room1.exits[.south] = Exit(room: room3)
    
    room2.exits[.west] = Exit(room: room1)
    room2.exits[.south] = Exit(room: room4)
    
    room3.exits[.north] = Exit(room: room1)
    room3.exits[.east] = Exit(room: room4)
    
    room4.exits[.north] = Exit(room: room2)
    room4.exits[.west] = Exit(room: room3)
    
    return [room1, room2, room3, room4]
}

func createPlayer(startingRoom: Room) -> Player {
    return Player(startingRoom: startingRoom)
}

func runGameLoop(for player: Player) throws {
    gameLoop: while true {
        print(player.currentRoom.description)
        
        if player.gameWon {
            print("Congratulations! You've won the game!")
            break gameLoop
        }
        
        if player.gameLost {
            print("You've lost the game. Better luck next time!")
            break gameLoop
        }
        
        switch player.currentRoom.contents {
            case .monster:
                print("There's a monster here! Do you want to fight (yes/no)?")
                let input = readLine(strippingNewline: true)
                switch input {
                    case "yes":
                        print("You bravely fight the monster and win! The monster leaves the room.")
                        player.currentRoom.contents = .empty
                    case "no":
                        print("You choose not to fight the monster.")
                        player.gameLost = true
                    default:
                        print("Invalid command.")
                }
            case .treasure:
                print("You found some treasure! Do you want to pick it up (yes/no)?")
                let input = readLine(strippingNewline: true)
                switch input {
                    case "yes":
                        print("You picked up the treasure! The room is now empty.")
                        player.currentRoom.contents = .empty
                        player.gameWon = true
                        break gameLoop
                    case "no":
                        print("You choose not to pick up the treasure.")
                    default:
                        print("Invalid command.")
                }
            case .key:
                print("You found a key!")
                player.hasKey = true
                player.currentRoom.contents = .empty
            case .lockedDoor:
                if player.hasKey {
                    print("You can unlock the door with your key.")
                    player.currentRoom.contents = .empty
                } else {
                    print("The door is locked. You need a key to open it.")
                }
            case .empty:
                print("The room is empty.")
        }
        
        let validCommands = ["north", "south", "east", "west", "status", "inventory", "quit"]

        print("Enter a command \(validCommands):")
        let input = readLine(strippingNewline: true)
        
        if !validCommands.contains(input!) {
            print("Invalid command. Valid commands are: \(validCommands.joined(separator: ", "))")
        } else {
            switch input {
                case "status":
                    print("You are in a room. You \(player.hasKey ? "have" : "do not have") a key.")
                case "inventory":
                    if player.inventory.isEmpty {
                        print("You are not carrying anything.")
                    } else {
                        print("You are carry: \(player.inventory.joined(separator: ", "))")
                    }
                case "north", "south", "west", "east":
                    guard let inputWrapped = input,
                          let direction = Direction(rawValue: inputWrapped) else {
                            throw GameError.invalidDirection
                    }
                    
                    if let nextRoom = player.currentRoom.exits[direction]?.room {
                        player.currentRoom = nextRoom
                    } else {
                        let availableDirections = player.currentRoom.availableDirections
                        print("Invalid direction. You can go: \(availableDirections.map { $0.rawValue }.joined(separator: ", "))")
                    }
                case "quit":
                    print("Thank you for playing!")
                    break gameLoop
                default:
                    print("Invalid command.")
            }
        }
    }
}

func printIntroduction() {
    print("""
    Welcome to the Dungeon Game!
    In this game, you will navigate through a dark and dangerous dungeon.
    Your goal is to find the treasure and avoid the monsters.
    You can move north, south, east, or west. Good luck!
    """)
}

func setupGame() {
    printIntroduction()
    let rooms = setupGameWorld()
    let player = createPlayer(startingRoom: rooms[0])
    
    do {
        try runGameLoop(for: player)
    } catch GameError.invalidDirection {
        print("There is no exit in that direction.")
    } catch GameError.monsterInTheRoom {
        print("You can't do that while there's a monster in the room!")
    } catch GameError.lockedDoor {
        print("The door is locked. You need a key to open it.")
    } catch {
        print("An unexpected error occured: \(error).")
    }
}

setupGame()

