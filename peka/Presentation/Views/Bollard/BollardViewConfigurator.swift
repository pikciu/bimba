//
//  BollardViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: BollardViewController!
    @IBOutlet private weak var tableView: UITableView!
    
	func configure() {
		self.tableView.register(TimeCell.self)
	}
}
