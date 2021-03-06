//
//  EpisodeItemTableCell.swift
//  Kanopy
//
//  Created by Boris Esanu on 2/21/17.
//
//

import UIKit
import SDWebImage

class EpisodeItemTableCell: GenericCell {

    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    
    
    // MARK: - 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        if highlighted == true {
            self.backgroundColor = UIColor.mainBackgroundDarkGreyColor()
            self.contentView.backgroundColor = UIColor.mainBackgroundDarkGreyColor()
        } else {
            self.backgroundColor = UIColor.clear
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    
    
    override func configure(cellModel: GenericCellModel) {
        super.configure(cellModel: cellModel)
        
        let cm: EpisodeItemCellModel = self.cellModel as! EpisodeItemCellModel
        
        self.titleLabel.text = cm.item.title
        self.itemLabel.text = cm.subtitle
        
        self.titleLabel.sizeToFit()
        self.itemLabel.sizeToFit()
        
        self.updateDescriptionLabel()
        
        if  cm.isShow == false {
            self.showMoreButton.setTitle("SHOW_LESS".localized, for: .normal)
        } else {
            self.showMoreButton.setTitle("SHOW_MORE".localized, for: .normal)
        }
        
        self.thumbImageView.sd_setImage(with: URL.init(string: (cm.item.images?.smallThumbURL())!)) { (image: UIImage?, error: Error?, type:SDImageCacheType, url: URL?) in
            self.thumbImageView.image = image
        }
    }
    
    
    private func updateDescriptionLabel() {
        
        let cm: EpisodeItemCellModel = self.cellModel as! EpisodeItemCellModel
        
        if cm.item.descriptionText.characters.count > 0 {
            
            self.showMoreButton.isHidden = false
            cm.itemLabelHeight = self.itemLabel.bounds.height
            cm.showMoreButtonHeight = self.showMoreButton.bounds.height
            cm.titleLabelHeight = self.titleLabel.bounds.height
            cm.thumbViewHeight = self.thumbImageView.bounds.height
            
            self.descriptionTextLabel.numberOfLines = cm.numberOfLines()
            self.descriptionTextLabel.lineBreakMode = cm.lineBreakMode()
            
            self.descriptionTextLabel.text = cm.descriptionText(width: self.descriptionTextLabel.bounds.width)
            
        } else {
            self.showMoreButton.isHidden = true
            self.descriptionTextLabel.text = ""
        }
    }
    
    
    // MARK: - Actions
    
    
    /** Override method is call when user tap to cell */
    override func didSelectCell() {
        
        let cm: EpisodeItemCellModel = self.cellModel as! EpisodeItemCellModel
        cm.didSelect()
    }
    
    
    @IBAction func showMoreButtonAction(_ sender: Any) {
        let cm: EpisodeItemCellModel = self.cellModel as! EpisodeItemCellModel
        cm.changeSize(cellWidth: self.descriptionTextLabel.bounds.width)
    }
}
