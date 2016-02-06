//
//  ViewController.swift
//  WordCount
//
//  Created by Mesfin Bekele Mekonnen on 2/5/16.
//  Copyright © 2016 Mesfin Bekele Mekonnen. All rights reserved.
//

import UIKit

import Foundation

extension String {
    
    func words() -> [String] {
        
        let range = Range<String.Index>(start: self.startIndex, end: self.endIndex)
        var words = [String]()
        
        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByWords) { (substring, _, _, _) -> () in
            words.append(substring!)
        }
        return words
    }
    
    func paragraphs() -> [String] {
        
        let range = Range<String.Index>(start: self.startIndex, end: self.endIndex)
        var words = [String]()
        
        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByParagraphs) { (substring, _, _, _) -> () in
            words.append(substring!)
        }
        return words
    }
    
    func sentences() -> [String] {
        
        let range = Range<String.Index>(start: self.startIndex, end: self.endIndex)
        var words = [String]()
        
        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.BySentences) { (substring, _, _, _) -> () in
            words.append(substring!)
        }
        return words
    }
}

class ViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        setupTapGesture()
    }
    
    func setupTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        textView.resignFirstResponder()
    }
    
    @IBAction func wordCountButtonTapped(sender: UIButton) {
        
        var pureWords = [String]()
        pureWords = textView.text.words()
        showAlert("Number of words : ", message: "\(pureWords.count)")
    }
    
    @IBAction func sentenceCountTapped(sender: UIButton) {
        
        var sentences = [String]()
        sentences = textView.text.sentences()
        
        showAlert("Number of sentences : ", message: "\(sentences.count)")
    }
    
    @IBAction func characterCountTapped(sender: UIButton) {
        
        var sum = 0
        var pureWords = [String]()
        pureWords = textView.text.words()
        
        for word in pureWords {
            sum += word.characters.count
        }
        showAlert("Number of Characters : ", message: "\(sum)")
    }
    
    @IBAction func paragraphCount(sender: UIButton) {
        
        var paragraphs = [String]()
        paragraphs = textView.text.paragraphs()
        
        showAlert("Number of Paragraphs : ", message: "\(paragraphs.count)")
    }
    
    @IBAction func distributionTapped(sender: UIButton) {
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("WordStatsDetailVCID") as! WordStatsDetailViewController
        detailVC.distributionByType = wordType()
        
        presentViewController(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func bigramsButtonTapped(sender: UIButton) {
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("WordStatsDetailVCID") as! WordStatsDetailViewController
        detailVC.detailText = bigrams(textView.text)
        
        presentViewController(detailVC, animated: true, completion: nil)
    }
    
    func wordType() -> [String : String] {
        
        var result: [String : String] = [:]
        
        let question = textView.text
        let options: NSLinguisticTaggerOptions = [.OmitWhitespace, .OmitPunctuation, .JoinNames]
        let schemes = NSLinguisticTagger.availableTagSchemesForLanguage("en")
        let tagger = NSLinguisticTagger(tagSchemes: schemes, options: Int(options.rawValue))
        tagger.string = question
        tagger.enumerateTagsInRange(NSMakeRange(0, (question as NSString).length), scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: options) { (tag, tokenRange, _, _) in
            let token = (question as NSString).substringWithRange(tokenRange)
            print("\(token): \(tag)")
            result["\(token)"] = "\(tag)"
        }
        return result
    }
    
    func bigrams(text: String) -> [(String, String)] {
        
        var result = [(String, String)]()
        let wordsArr = textView.text.words()
        for i in 0..<wordsArr.count {
            let j = i + 1
            if j < wordsArr.count{
                result.append((wordsArr[i], wordsArr[j]))
            }
        }
        print(result)
        return result
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}

