//
//  Building.swift
//  elevator_project
//
//  Created by Serhii Striuk on 21.02.2023.
//

import Foundation

class Building {
    let floors: [Floor]
    let elevator: Elevator
    
    init(floorCount: Int) {
        self.floors = (0..<floorCount).map {
            Floor(number: $0)
        }
        
        self.elevator = Elevator(id: 0, maxFloor: floorCount - 1)
        
        self.floors.forEach {
            $0.building = self
        }
    }
    
    func dispatchElevator(to floor: Int) {
        if floor < elevator.currentFloor {
            elevator.go(to: floor, direction: .down)
        } else if floor > elevator.currentFloor{
            elevator.go(to: floor, direction: .up)
        }
    }
}
