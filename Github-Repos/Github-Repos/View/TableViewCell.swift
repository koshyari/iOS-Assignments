//
//  TableViewCell.swift
//  Github-Repos
//
//  Created by Anshul Singh Koshyari on 26/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeImageCircular()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func makeImageCircular() {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.bounds.width / 2
    }
    
    
    
    func configure(with model: Items) {
        self.userName.text = model.owner?.login
        self.repoName.text = model.name
        
        let url = model.owner?.avatar_url
        if let data = try? Data(contentsOf: URL(string: url!)!) {
            self.userImage.image = UIImage(data: data)
        }
    }
}
