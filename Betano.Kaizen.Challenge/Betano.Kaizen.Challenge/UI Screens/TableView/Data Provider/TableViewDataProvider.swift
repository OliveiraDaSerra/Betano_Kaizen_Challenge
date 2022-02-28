//
//  TableViewDataProvider.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit
import Combine

class DataProvider: NSObject {
    let dataSource: DataSource

    init(with dataSource: DataSource) {
        self.dataSource = dataSource
    }
}

class TableViewDataProvider: NSObject, UITableViewDelegate {

    // MARK: - Properties
    var dataSource: TableViewDataSource!
    var selectedIndexPath = PassthroughSubject<IndexPath, Never>()

    init(with dataSource: TableViewDataSource) {
        self.dataSource = dataSource
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath.send(indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
