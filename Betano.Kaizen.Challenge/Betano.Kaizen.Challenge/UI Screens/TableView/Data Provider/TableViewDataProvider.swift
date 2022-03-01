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

    var selectedElement = PassthroughSubject<(String?, String?), Never>()

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
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderFooterView.typeName) as? SectionHeaderFooterView, let viewModel = fetchSectionFor(index: section)
        else { return nil }
        viewModel.handler = { [weak self] (sectionKey: String?, rowKey: String?) in
            self?.selectedElement.send((sectionKey, rowKey))
        }
        header.update(with: viewModel)
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

    func reloadCell(for reloadInfo: ReloadInfo?) {
        guard let reloadInfo = reloadInfo,
              let tableView = tableView,
              let sectionNumber = reloadInfo.section
        else { return }

        if reloadInfo.type == .section {
            tableView.reloadSections([sectionNumber], with: .automatic)
        } else if reloadInfo.type == .row,
                  let rowNumber = reloadInfo.row,
                  let cell = tableView.cellForRow(at: IndexPath(row: 0, section: sectionNumber)) as? GamesInfoTableViewCell {
            cell.collectionView.reloadItems(at: [IndexPath(row: rowNumber, section: 0)])
        }
    }
}
