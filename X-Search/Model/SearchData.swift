//
//  SearchData.swift
//  X-Search
//
//  Created by Joshua Okoro on 1/26/19.
//  Copyright © 2019 Joshua Okoro. All rights reserved.
//

import Foundation

class SearchData {
    
    let additionalWord: String
    let additionalLanguage: String
    let additionalPartsOfSpeech: String 
    
    init(word: String, language: String, pos: String) {
        self.additionalWord = word
        self.additionalLanguage = language
        self.additionalPartsOfSpeech = pos
    }

}
