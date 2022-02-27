//
//  TableViewConfigurator.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit

class TableViewConfigurator {
    static func configure(bgColor: UIColor? = nil,
                          title: String? = nil,
                          style: UITableView.Style = .plain) -> UIViewController {
        let dataSource = TableViewDataSource(with: [])
        let dataProvider = TableViewDataProvider(with: dataSource)
        let coordinator: TableViewCoordinatorType = TableViewCoordinator()
        let viewModel = TableViewModel(coordinator: coordinator)
        let viewController = TableViewController(bgColor: bgColor, title: title, viewModel: viewModel, dataProvider: dataProvider, style: style)
        coordinator.viewController = viewController
        return viewController
    }
}
