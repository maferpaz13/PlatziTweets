//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by christians bonilla on 5/30/22.
//  Copyright © 2022 Maria Paz. All rights reserved.
//

import UIKit
import SDWebImage

class TweetTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknamaLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var TweetImageView: UIImageView!
    @IBOutlet weak var VideoButton: UIButton!
    @IBOutlet weak var DateLabel: UILabel!
    
    //NOTA IMPORTANTE
    // las celdas NUNCA deben invocar ViewControllers
    
    //MARK: - IBActions
    @IBAction func openVideoAction() {
        
    }
    
    //MARK: - Properties
    private var videoUrl: URL?
    var needsToShowVideo: ((_ url: URL) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(Informacion: ObtenerTweetsModel.DataTweet!) {
        nameLabel.text = Informacion.author?.names
        nicknamaLabel.text = Informacion.author?.nickname
        messageLabel.text = Informacion.text
        
        if Informacion.hasImage! {
            
            TweetImageView.sd_setImage(with: URL(string: Informacion.imageUrl!))
            TweetImageView.isHidden = false
            
        }else{
            
            TweetImageView.isHidden = true
            
        }
        
            VideoButton.isHidden = !Informacion.hasVideo!
            
        videoUrl = URL(string: Informacion.videoUrl ?? "")
    }
    
    
}
