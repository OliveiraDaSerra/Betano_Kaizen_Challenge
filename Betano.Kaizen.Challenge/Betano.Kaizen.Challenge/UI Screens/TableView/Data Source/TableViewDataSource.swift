//
//  TableViewDataSource.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit

struct HeaderFooterDataContent {
    var title: String?
}

struct HeaderFooterData {
    var headerData: HeaderFooterDataContent?
    var footerData: HeaderFooterDataContent?
}

class ViewModelSection {
    var key: String?
    var headerFooterData: HeaderFooterData?
    var expanded: Bool
    var fields: [String]?

    init(with key: String?,
         headerFooterData: HeaderFooterData?,
         isExpanded: Bool = false,
         fields: [String]? = nil) {
        self.key = key
        self.headerFooterData = headerFooterData
        self.expanded = isExpanded
        self.fields = fields
    }
}

class DataSource: NSObject {
    var viewModelSections: [ViewModelSection]?

    init(with sections: [ViewModelSection]? = nil) {
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
        return sectionData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
