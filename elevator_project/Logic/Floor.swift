//
//  Floor.swift
//  elevator_project
//
//  Created by Serhii Striuk on 21.02.2023.
//

import Foundation

class Floor {
    weak var building: Building?
    
    let number: Int
//    let callButton: CallButton
    
    init(number: Int) {
        self.number = number
        
//        self.callButton = CallButton(floorNumber: number)
//        self.callButton.floor = self
    }
}

//class CallButton {
//    weak var floor: Floor?
//
//    let floorNumber: Int
//
//    init(floorNumber: Int) {
//        self.floorNumber = floorNumber
//    }
//
//    func callElevator(direction: Elevator.Direction) {
//        floor?.building?.dispatchElevator(to: floorNumber, direction: direction)
//        print("Elevator called to floor \(floorNumber) in direction \(direction)")
//    }
//}
