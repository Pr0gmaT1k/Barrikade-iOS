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
    // MARK:- IBOutlet
    @IBOutlet private weak var countainerView: UIView!
    @IBOutlet private weak var titleEvent: UILabel!
    @IBOutlet private weak var subtitleEvent: UILabel!
    
    // MARK:- Func
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countainerView.layer.shadowOpacity = 0.2
    }
    
    public func fill(event: Event) {
        self.titleEvent.text = event.title
        self.subtitleEvent.text = event.descriptionn
    }
}
