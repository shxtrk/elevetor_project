//
//  FloorTableViewCell.swift
//  elevator_project
//
//  Created by Serhii Striuk on 21.02.2023.
//

import UIKit

final class FloorTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: FloorTableViewCell.self)
    static let height = CGFloat(44)
    
    private var floor: Int = 0
    private var buttonCallback: ((Int) -> Void)?
    
    @IBOutlet private weak var floorLabel: UILabel!
    
    func configure(floor: Int, buttonCallback: @escaping (Int) -> Void) {
        self.floor = floor
        self.floorLabel.text = "Floor: \(floor)"
        self.buttonCallback = buttonCallback
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        self.buttonCallback?(floor)
    }
}
