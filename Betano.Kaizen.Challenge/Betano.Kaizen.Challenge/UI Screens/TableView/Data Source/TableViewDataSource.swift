//
//  TableViewDataSource.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit

class DataSource: NSObject {
    var viewModelSections: [ViewModelSection]?

    init(with sections: [ViewModelSection]? = nil) {
        self.viewModelSections = sections
    }

    func updateDataSource(with sections: [ViewModelSection]? = nil) {
        self.viewModelSections = sections
    }
}

class TableViewDataSource: DataSource, UITableViewDataSource {

    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModelSections = viewModelSections else { return 0 }
        return viewModelSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModelSections = viewModelSections,
              let sectionData = viewModelSections[section].fields else { return 0 }
        let sectionExpanded = viewModelSections[section].expanded
        return sectionData.count > 0 && sectionExpanded ? 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GamesInfoTableViewCell.typeName,
                                                       for: indexPath) as? GamesInfoTableViewCell,
              let viewModelSections = viewModelSections,
              let sectionData = viewModelSections[indexPath.section] else { return UITableViewCell() }

        cell.update(with: sectionData, collectionViewLayout: ListType.horizontalList.cvFlowLayout)
        return cell
    }
}
