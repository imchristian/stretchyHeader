//
//  ViewController.swift
//  StretchyHeaders
//
//  Created by Cristian Leonel Gibert on 8/27/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 80.0

class ViewController: UITableViewController  {
	
	let items = [NewsItem(category: .World, summary: "Climate change protests, divestments meet fossil fuels realities"), NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"), NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"), NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"), NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"), NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"), NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"), NewsItem(category: .Europe, summary: "'One million babies' created by EU student exchanges"),]
	
	var headerView: UIView!
	var headerMaskLayer: CAShapeLayer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		headerView = tableView.tableHeaderView
		tableView.tableHeaderView = nil
		tableView.addSubview(headerView)
		
		tableView.estimatedRowHeight = 70	
		tableView.rowHeight = UITableViewAutomaticDimension
		
		let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
		tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
		tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
		
		headerMaskLayer = CAShapeLayer()
		headerMaskLayer.fillColor = UIColor.blackColor().CGColor
		headerView.layer.mask = headerMaskLayer
		updateHeaderView()
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsItemCell
		cell.newsItem = item

		return cell
	}
	
	func updateHeaderView() {
		let effectiveHeight = kTableHeaderHeight - kTableHeaderCutAway/2
		var headerRect = CGRect(x: 0, y: -effectiveHeight, width: CGRectGetWidth(tableView.bounds), height: kTableHeaderHeight)
		
		if tableView.contentOffset.y < -effectiveHeight {
			headerRect.origin.y = tableView.contentOffset.y
			headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
		}
		
		headerView.frame = headerRect
		
		let path = UIBezierPath()
		path.moveToPoint(CGPoint(x: 0, y: 0))
		path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
		path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
		path.addLineToPoint(CGPoint(x: 0, y: headerRect.height - kTableHeaderCutAway))
		headerMaskLayer?.path = path.CGPath
	}
	
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		updateHeaderView()
	}
}

