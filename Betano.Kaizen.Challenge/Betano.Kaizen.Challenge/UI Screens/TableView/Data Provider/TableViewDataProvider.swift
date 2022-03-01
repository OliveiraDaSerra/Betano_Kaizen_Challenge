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

    func fetchSectionFor(index: Int) -> ViewModelSection? {
        guard let viewModelSection = dataSource.viewModelSections?[index] else { return nil }
        return viewModelSection
    }

    func fetchSectionFor(indexPath: IndexPath) -> ViewModelSection? {
        guard let viewModelSection = dataSource.viewModelSections?[indexPath.section] else { return nil }
        return viewModelSection
    }
}

class TableViewDataProvider: DataProvider, UITableViewDelegate {

    // MARK: - Properties
    var tableView: UITableView? {
        didSet {
            guard let dataSource = dataSource as? TableViewDataSource else { return }
            registerCells()
            setupTableView(with: dataSource)
        }
    }
    var selectedIndexPath = PassthroughSubject<IndexPath, Never>()

    init(with dataSource: TableViewDataSource) {
        super.init(with: dataSource)
    }

    private func setupTableView(with dataSource: TableViewDataSource) {
        guard let tableView = tableView else { return }
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath.send(indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderFooterView.typeName) as? SectionHeaderFooterView, let viewModel = fetchSectionFor(index: section)
        else { return nil }
        header.update(title: viewModel.headerFooterData?.headerData?.title, expanded: false)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }

    // MARK: -

    private func registerCells() {
        // Section Header
        tableView?.registerNoNibHeaderFooterView(SectionHeaderFooterView.self)

        // Cells
        tableView?.registerNoNibCell(GamesInfoTableViewCell.self)
    }
}
