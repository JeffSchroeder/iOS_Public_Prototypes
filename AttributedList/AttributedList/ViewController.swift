//
//  ViewController.swift
//  AttributedList
//
//  Created by Jeff Schroeder on 1/6/20.
//  Copyright © 2020 Jeffrey Schroeder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var termTextField: UITextField!
    @IBOutlet weak var resultsSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var resultsTextView: UITextView!
    @IBOutlet weak var searchTermsTextView: UITextView!
    
    // MARK: - Page life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        resultsTextView.attributedText = nil
        resultsTextView.text = nil
        termTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        processSlider()
    }
    
    // MARK: - IBActions
    /// Handle the slider being changed
    @IBAction func resultsSliderValueChange(_ sender: Any) {
        processSlider()
        processTerm()
    }
    
    /// Handle the view being single tapped.
    @IBAction func viewSingleTapGestureRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Functions
    /// Returns an attributed delimited string containing instances containing the term with the term highlighted.
    /// - Paramters:
    ///     stringOfTerms:      Delimited string of terms
    ///     stringToHighlight:  Term you want highlighted in the passed in string of terms
    ///     highlightFont:      UIFont for highlighted terms
    ///     delimiter:          Delimiter of the input string of terms. Default: ","
    ///     returnDelimiter:    Delimiter for output list of string. Defualt: ", "
    func highlightTerm(_ stringOfTerms: String?,
                       termToHighlight: String?,
                       numberOfResults: Int,
                       highlightFont: UIFont,
                       delimiter: String = ",",
                       returnDelimiter: String  = ", ") -> NSAttributedString? {
        // Make sure we have all the bits.
        guard let stringOfTerms = stringOfTerms?.lowercased(), let termToHighlight = termToHighlight?.lowercased() else { return nil }
        // Parse the string of terms to array
        var termsArray = stringOfTerms.components(separatedBy: delimiter)
        // Clean up white spaces
        termsArray = termsArray.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        // Filter out what has the term.
        termsArray = termsArray.filter { $0.contains(termToHighlight) }
        // Make sure we have somthing to return
        guard termsArray.count != 0 else { return nil }
        // Sort smallest to largest
        termsArray = termsArray.sorted(by: {$0.count < $1.count} )
        // Limit the number of results if needed
        if termsArray.count > numberOfResults {
            termsArray = Array(termsArray.prefix(numberOfResults))
        }
        // Smoosh the terms back together in a comma delimited list
        let stringOfTermsToReturn = termsArray.joined(separator: returnDelimiter)
        // Set up the attributed string correctly
        let attributedText = NSMutableAttributedString(string: stringOfTermsToReturn.capitalized)
        let highlightFontAttribute = [NSAttributedString.Key.font: highlightFont]
        // Get the text ranges of what to highlight and apply
        for index in stringOfTermsToReturn.indices(of: termToHighlight) {
            let textRange = NSRange(location: index, length: termToHighlight.count)
            attributedText.addAttributes(highlightFontAttribute, range: textRange)
        }
        return attributedText
    }
    
    /// Update the label displaying the sliders value
    func processSlider() {
        sliderLabel.text = "\(Int(resultsSlider.value))"
    }
    
    /// Runs the common routine to produce the displayed results
    func processTerm() {
        resultsTextView.attributedText =
            highlightTerm(searchTermsTextView.text,
                          termToHighlight: termTextField.text ?? "",
                          numberOfResults: Int(resultsSlider.value),
                          highlightFont: UIFont.systemFont(ofSize: 13.0, weight: .bold)
        )
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        processTerm()
    }
}

// MARK: - String extensions
extension String {
    /// Function to return the array of starting indexes for a string within the string.
    /// - Parameters:
    ///     of: String to find
    /// Note: Pulled extension awesomeness from here:  https://stackoverflow.com/questions/40413218/swift-find-all-occurrences-of-a-substring
    func indices(of string: String) -> [Int] {
        return indices.reduce([]) {
            $1.utf16Offset(in: self) > ($0.last ?? -1) &&
                self[$1...].hasPrefix(string) ? $0 + [$1.utf16Offset(in: self)] : $0
        }
    }
}

