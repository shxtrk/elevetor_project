//
//  ViewController.swift
//  elevator_project
//
//  Created by Serhii Striuk on 21.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let building = Building(floorCount: 9)
    
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var emergencySwitch: UISwitch!
    
    @IBOutlet weak var cabinTableView: UITableView!
    @IBOutlet weak var floorsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        building.elevator.stateDidChange = { [weak self] state in
            self?.stateLabel.text = state.rawValue
        }
        building.elevator.directionDidChange = { [weak self] direction in
            self?.directionLabel.text = "Direction: \(direction.rawValue)"
        }
        building.elevator.currentFloorDidChange = { [weak self] floor in
            self?.floorLabel.text = "Floor: \(floor)"
        }
    }
    
    @IBAction func emergencySwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            building.elevator.resume()
        } else {
            building.elevator.stop()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return building.floors.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView == cabinTableView ? "Cabin Panel" : "Floors buttons"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cabinTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CabinTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? CabinTableViewCell else {
                assertionFailure("Cannot dequeue reusable cell \(CabinTableViewCell.self) with reuseIdentifier: \(CabinTableViewCell.reuseIdentifier)")
                return UITableViewCell()
            }
            
            cell.configure(floor: indexPath.row) { [weak self] floor in
                self?.building.dispatchElevator(to: floor)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FloorTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? FloorTableViewCell else {
                assertionFailure("Cannot dequeue reusable cell \(FloorTableViewCell.self) with reuseIdentifier: \(FloorTableViewCell.reuseIdentifier)")
                return UITableViewCell()
            }
            
            cell.configure(floor: indexPath.row) { [weak self] floor in
                self?.building.dispatchElevator(to: floor)
            }
            
            return cell
        }
    }
    
    
}
