# Text-Based Adventure Game

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Technical Implementation](#technical-implementation)
4. [Key Learnings](#key-learnings)
5. [Getting Started](#getting-started)
6. [Acknowledgements](#acknowledgements)

## Overview

The Text-Based Adventure Game is an interactive command-line game developed in Swift. Players navigate through a world, interact with contents, and make decisions that drive the progression of the game.

The project serves as a showcase of Swift's advanced topics, effectively demonstrating the usage of enums, error handling, classes, protocols, and more.

## Features

- Interactive Gameplay: The game allows players to navigate through rooms, interact with contents, and make decisions that affect the game's outcome.

- Complex Game World: The game world consists of interconnected rooms with various contents. Players can encounter monsters, treasures, keys, and locked doors.

- Command System: Players interact with the game through a command system. They can move in different directions, view their inventory, and perform actions based on the room's content.

- Game Outcome: The game's outcome can vary based on the player's actions.

## Technical Implementation

- The game uses **classes** and **structs** to model the game world. This includes rooms, exits, player, and game contents.

- **Enums** are used extensively to represent game contents, directions, and game errors. This approach leads to safer and more readable code.

- The game uses **error handling** to manage invalid commands and actions that can't be performed due to game rules.

- The **Observer Design Pattern** is employed to notify the game state changes.

- The **Singleton Design Pattern** is used to manage the game state, ensuring that only a single instance of the game exists throughout the app's lifecycle.

## Key Learnings

- Understanding and implementing advanced Swift concepts such as classes, structs, enums, and error handling.

- Developing an interactive command-line application in Swift.

- Efficient use of design patterns like Singleton and Observer.

- Understanding how to design and implement a text-based adventure game.

## Getting Started

Clone the repository and open the project in a Swift-supported IDE (like Xcode) to get started.

```bash
git clone https://github.com/yourgithubusername/TextBasedAdventureGame.git
open TextBasedAdventureGame.xcodeproj
```

## Acknowledgements
The Text-Based Adventure Game was developed to practice and solidify advanced Swift concepts, and to provide a strong reference for these concepts and their implementation in a real-world project.
