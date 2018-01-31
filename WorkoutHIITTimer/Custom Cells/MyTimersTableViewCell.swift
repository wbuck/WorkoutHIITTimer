//
//  MyTimersTableViewCell.swift
//  WorkoutHIITTimer
//
//  Created by Warren Buckley on 2018-01-26.
//  Copyright © 2018 Warren Buckley. All rights reserved.
//

import UIKit
import SwipeCellKit

class MyTimersTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var timerToDisplay: TimerBase? {
        didSet {
            setupCell()
        }
    }
    
    private func setupCell(){
        guard let timer = timerToDisplay else { return }
        selectionStyle = .none
        nameLabel.text = timer.timerName
        descriptionLabel.text = timer.timerDescription
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formatter.string(from: timer.dateCreated)
    }
    
    func setCellBackgroundColor(for indexPath: IndexPath){
        cellContentView.backgroundColor = indexPath.row % 2 == 0 ?
            UIColor(named: "TimerGrey") : UIColor(named: "TimerLightGrey")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
