//
//  ViewController.swift
//  sendtweet
//
//  Created by Andrew Konoff on 2019-07-02.
//  Copyright © 2019 Strings.fm Inc. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController, UITextViewDelegate {
    let drilPlaceholderString = """
    age 0 (baby): I want my Dada .
    age 25 (Millennial): I want my Data
    Do you see how fucked this is?
    """
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var sendTweetButton: UIBarButtonItem!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var swifter = Swifter(consumerKey: "key", consumerSecret: "secret", oauthToken: "oauthToken", oauthTokenSecret: "secret")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetTextView.inputAccessoryView = toolbar
        tweetTextView.keyboardAppearance = .dark
        sendTweetButton.isEnabled = false
    }

    @IBAction func sendTweetPressed(_ sender: Any) {
        let tweet = tweetTextView.text
        swifter.postTweet(status: tweet!, success: { JSON in
            print("Good job oyu posted '\(tweet)'")
        }) { error in
            print("Got all fucked up")
        }
        
        tweetTextView.text = drilPlaceholderString
        tweetTextView.textColor = .lightGray
        tweetTextView.resignFirstResponder()
        charCountLabel.text = String(280)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == drilPlaceholderString) {
            textView.text = ""
            textView.textColor = .white
            sendTweetButton.isEnabled = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = drilPlaceholderString
            textView.textColor = .lightGray
            sendTweetButton.isEnabled = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        charCountLabel.text = String(280 - textView.text.count)
        print("changed")
        if text.count <= 280 {
            return true
        }
        return false
    }
    
}

