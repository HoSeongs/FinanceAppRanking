//
//  AppTableCell.swift
//  AppStore
//
//  Created by SecurityIBK on 2018. 4. 10..
//  Copyright © 2018년 HoSeong Choi. All rights reserved.
//

import Foundation
import UIKit

class AppTableCell:UITableViewCell{
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var appRanking: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appImage.image = nil
        appName.text = nil
        appDescription.text = nil
        appRanking.text = nil
    }
}
