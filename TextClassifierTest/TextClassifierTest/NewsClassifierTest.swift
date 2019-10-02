//
//  NewsClassifierTest.swift
//  TextClassifierTest
//
//  Created by Souley on 12/05/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation


func wordCounts(text: String) -> [String: Double] {
    var bagOfWords: [String: Double] = [:]
    
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
    
    let range = NSRange(text.startIndex..., in: text)
    
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
    
    tagger.string = text
    
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (_, tokenRange, _) in
        let word = (text as NSString).substring(with: tokenRange)
        bagOfWords[word, default: 0] += 1
    }
    
    return bagOfWords
}

func analyze(text: String) {
    let counts = wordCounts(text: text)
    
    let model = TextClassifier()
    
    do {
        let prediction = try model.prediction(text: counts)
        print("\(prediction.labelProbability) \(prediction.label)")
        
    } catch {
        print(error)
    }
}


