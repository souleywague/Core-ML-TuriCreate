//
//  NewsAppViewController.swift
//  TextClassifierTest
//
//  Created by Souley on 12/05/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit
import CoreML

class NewsAppViewController: UIViewController {


    let testNewsHeadlines: [String] = ["Louisiana Lawmakers Approve Strict Abortion Limit, Dem. Governor Says He Will Sign it"]

    override func viewDidLoad() {
        super.viewDidLoad()

        for news in testNewsHeadlines {
            analyze(text: news)
        }
    }

}
