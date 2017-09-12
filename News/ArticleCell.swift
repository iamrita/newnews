//
//  ArticleCell.swift
//  News
//
//  Created by Amrita V on 8/15/17.
//  Copyright © 2017 Amrita Venkatraman. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
