//
//  WordStatsDetailViewController.swift
//  WordCount
//
//  Created by Mesfin Bekele Mekonnen on 2/5/16.
//  Copyright © 2016 Mesfin Bekele Mekonnen. All rights reserved.
//

import UIKit

class WordStatsDetailViewController: UIViewController {

    @IBOutlet weak var detailTextView: UITextView!
    
    var detailText : [(String, String)] = []
    var distributionByType : [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if detailText.count > 0 {
            setupBigrams()
        }
        else if distributionByType.count > 0 {
            setupDistributionByType()
        }
    }
    
    func setupBigrams() {
        var bigrams = ""
        
        for pair in detailText {
            bigrams += String(pair)
        }
        detailTextView.text = bigrams
    }
    
    func setupDistributionByType() {
        detailTextView.text = String(distributionByType)
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
