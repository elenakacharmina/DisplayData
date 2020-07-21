//
//  ImageTableViewCell.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCell(text: String?, imageURL: String?) {
        backgroundColor = BACKGROUND_COLOR
        
        label.textColor = TEXT_LABEL_COLOR
        
        if let text = text {
            label.text = text
        }
        
        if let imageURL = imageURL {
            pictImageView.image = UIImage()
            let url = URL(string: imageURL)
            pictImageView.kf.setImage(with: url)
        }
    }
    
}
