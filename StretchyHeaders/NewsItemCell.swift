//
//  NewsItemCell.swift
//  StretchyHeaders
//
//  Created by Cristian Leonel Gibert on 8/27/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

	@IBOutlet var categoryLabel: UILabel!
	@IBOutlet var summaryLabel: UILabel!
	
	var newsItem: NewsItem? {
		didSet {
			if let item = newsItem {
				categoryLabel.text = item.category.toString()
				categoryLabel.textColor = item.category.toColor()
				summaryLabel.text = item.summary
			}
			else {
				categoryLabel.text = nil
				summaryLabel.text = nil
			}
		}
	}
}
