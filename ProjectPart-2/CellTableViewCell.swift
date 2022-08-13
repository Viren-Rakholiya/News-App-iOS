//
//  CellTableViewCell.swift
//  ProjectPart-2
//


import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var lbldesc: UILabel!
    
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
