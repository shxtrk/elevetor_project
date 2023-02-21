//
//  Elevator.swift
//  elevator_project
//
//  Created by Serhii Striuk on 21.02.2023.
//

import Foundation

class Elevator {
    
    let id: Int
    let maxFloor: Int
    
    var currentFloor: Int = 0 {
        didSet {
            DispatchQueue.main.async { self.currentFloorDidChange?(self.currentFloor) }
        }
    }
    
    var targetFloor: Int?
    
    var state: State = .idle {
        didSet {
            DispatchQueue.main.async { self.stateDidChange?(self.state) }
        }
    }
    var direction: Direction = .up {
        didSet {
            DispatchQueue.main.async {  self.directionDidChange?(self.direction) }
        }
    }
    
    var stateDidChange: ((State) -> Void)?
    var directionDidChange: ((Direction) -> Void)?
    var currentFloorDidChange: ((Int) -> Void)?
    
    enum State: String {
        case idle = "Idle"
        case moving = "Moving"
        case stopped = "Stopped"
    }
    
    enum Direction: String {
        case up = "Up"
        case down = "Down"
    }
    
    private let queue = OperationQueue()
    
    private let lock = NSLock()
    
    init(id: Int, maxFloor: Int) {
        self.id = id
        self.maxFloor = maxFloor
    }
    
    func distance(to floor: Int) -> Int {
        abs(floor - currentFloor)
    }
    
    func go(to floor: Int, direction: Direction) {
        guard state == .idle else { return }
        
        targetFloor = floor
        self.direction = direction
        state = .moving
        
        var moveOperation = BlockOperation()
        
        moveOperation.addExecutionBlock { [unowned moveOperation] in
            self.lock.lock()
            
            if let targetFloor = self.targetFloor {
                while self.currentFloor != targetFloor {
                    if moveOperation.isCancelled {
                        break
                    }
                    if self.direction == .up {
                        self.currentFloor += 1
                    } else {
                        self.currentFloor -= 1
                    }

                    if self.currentFloor == self.maxFloor {
                        self.direction = .down
                        break
                    } else if self.currentFloor == 0 {
                        self.direction = .up
                        break
                    }
                    
                    sleep(1)
                }
                
                if !moveOperation.isCancelled {
                    self.targetFloor = nil
                }
                self.state = .idle
            }
            
            self.lock.unlock()
        }
        
        queue.addOperation(moveOperation)
    }
    
    func stop() {
        queue.cancelAllOperations()
        lock.lock()
        state = .stopped
        lock.unlock()
    }
    
    func resume() {
        lock.lock()
        state = .idle
        lock.unlock()
    }
}
