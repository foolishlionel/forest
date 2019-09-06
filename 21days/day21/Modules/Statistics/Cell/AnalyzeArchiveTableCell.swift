//
//  AnalyzeArchiveTableCell.swift
//  day21
//
//  Created by flionel on 2019/1/30.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class AnalyzeArchiveTableCell: UITableViewCell {

    @IBOutlet weak var archiveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
    }
    
}

extension AnalyzeArchiveTableCell: ConfigurableCell {
    func configure(with vm: Any?) {
        
    }
}
