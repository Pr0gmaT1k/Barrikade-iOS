//
//  EventTableViewCell.swift
//  Barrikade-iOS
//
//  Created by azerty on 09/03/2018.
//  Copyright © 2018 Pr0gmaT1k. All rights reserved.
//

import UIKit
import Reusable

final class EventTableViewCell: UITableViewCell, NibReusable {
    // MARK:- IBOutlets
    @IBOutlet private weak var countainerView: UIView!
    @IBOutlet private weak var titleEvent: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    
    // MARK:- Func
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countainerView.layer.shadowOpacity = 0.2
    }
    
    public func fill(event: Event) {
        let calendar = Calendar.current
        
        self.titleEvent.text = event.title
        self.dayLabel.text = event.startDayName?.uppercased()
        self.dateLabel.text = calendar.component(.day, from: event.dateObject).description
        self.hourLabel.text = event.startTime
        self.locationLabel.text = event.location
        self.adressLabel.text = event.address?.removeHTMLParagraph
    }
}
