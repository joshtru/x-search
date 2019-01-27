//
//  ViewController.swift
//  X-Search
//
//  Created by Joshua Okoro on 1/22/19.
//  Copyright © 2019 Joshua Okoro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var word: UILabel!
    
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var partsOfSpeech: UILabel!
    
    @IBOutlet weak var wordsTableView: UITableView!
    
    @IBOutlet weak var wordsCount: UILabel!
    
    @IBOutlet weak var foundLabel: UILabel!
    
    @IBOutlet weak var cardView: CardView!
    
    let apiKey = "815ee631-fc2f-4ca2-8de6-8badf1e9fcae"
    let URL = "https://api.wordassociations.net/associations/v1.0/json/search?apikey="
    let wordQuery = "&text="
    let languageQuery = "&lang=en"
    var finalURL = ""
    
    var words = [SearchData]()
    var names = ["jack", "james", "jaksl", "shalsf", "make", "car"]
    var lang = ["en", "fr", "germ", "en", "fr", "germ"]
    var pos = ["noun", "pron", "verb", "adverb", "adj"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide the additional language and parts of speech
        cardView.isHidden = true
        foundLabel.isHidden = true
        wordsCount.isHidden = true
        
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        
        wordsTableView.rowHeight = 131
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return the number of items from the JSON result
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "WordCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WordsTableViewCell else {
            fatalError("Could not customize table view as WordsTableViewCell")
        }
        
        let word = words[indexPath.row]

        cell.additionalWord.text = word.additionalWord
        cell.additionalLanguage.text = word.additionalLanguage
        cell.additionalPartsOfSpeech.text = word.additionalPartsOfSpeech

        return cell
    }
    
    
    // MARK: - Networking
    /*
    Fetch the results using the api
    And pass it to the updateWordData function in JSON format
    */
    func request(_ query: String) {
        finalURL = URL + apiKey + wordQuery + query + languageQuery
        Alamofire.request(finalURL).responseJSON { (response) in
            if response.result.isSuccess {
                let wordJSON: JSON = JSON(response.result.value!)
                self.updateWordData(json: wordJSON)
//                DispatchQueue.main.async {
//                    self.wordsTableView.reloadData()
//                }
            } else {
                print("Error \(String(describing: response.result.error))")
                self.word.text = "Not Found"
            }
        }
    }
    
    // MARK: - Update with data
    
    // Upwrap and Update the View with information found
    func updateWordData(json: JSON) {
        if json["code"].int == 200 {
            
            //Show the additional language and parts of speech
            cardView.isHidden = false
            
            word.text = json["request"]["text"][0].string!.capitalized
            let lang = json["request"]["lang"].string!.capitalized
            language.text = lang
            partsOfSpeech.text = json["request"]["pos"].string?.capitalized
            
            let list = json["response"][0]["items"]
            words.removeAll()
            for (index, _) in list.enumerated() {
                let word = list[index]["item"].string!.capitalized
                let part = list[index]["pos"].string!.capitalized
                words.append(SearchData(word: word, language: lang, pos: part))
            }
            wordsCount.isHidden = false
            foundLabel.isHidden = false
            wordsCount.text = String(words.count)
            DispatchQueue.main.async {
                self.wordsTableView.reloadData()
            }
            
        } else {
            foundLabel.text = "No Words Found"
        }
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /*
         Get and upwrap the word to search
         and use the Request function to query API
        */
        if let word = searchBar.text {
            request(word)
            self.view.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*
         Use the main thread to resign the search and keyboard
         if the word count in search input is zero
        */
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

