//
//  WordsTableViewCell.swift
//  X-Search
//
//  Created by Joshua Okoro on 1/26/19.
//  Copyright © 2019 Joshua Okoro. All rights reserved.
//

import UIKit

class WordsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var additionalWord: UILabel!
    
    @IBOutlet weak var additionalLanguage: UILabel!
    
    @IBOutlet weak var additionalPartsOfSpeech: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
