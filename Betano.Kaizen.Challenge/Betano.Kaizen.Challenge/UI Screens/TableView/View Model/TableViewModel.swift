//
//  TableViewModel.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import Combine
import UIKit

protocol TableViewModelType: AnyObject, ViewModelType {}

class TableViewModel: TableViewModelType {

    // MARK: - Properties

    struct Input {
        let viewDidLoadTrigger: Driver<Void>
        let selectedElement: Driver<(String?, String?)>
    }

    struct Output {
        let reloadDataTrigger: PassthroughSubject<([ViewModelSection], ReloadInfo?), Never>
    }

    var dataSourceData: [ViewModelSection] = []
    var reloadDataTrigger = PassthroughSubject<([ViewModelSection], ReloadInfo?), Never>()

    // MARK: - Initializers

    init(coordinator: TableViewCoordinatorType) {}

    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        input.viewDidLoadTrigger.sink { [weak self] _ in
            self?.createDataSource()
        }
        .store(in: disposeBag)

        input.selectedElement.sink { [weak self] (sectionID, rowID) in
            self?.updateDataSource(sectionID: sectionID, rowID: rowID)
        }
        .store(in: disposeBag)

        return Output(reloadDataTrigger: reloadDataTrigger)
    }

    // MARK: - Private Methods

    private func createDataSource() {
        ServicesRequests.getListOfSports { [weak self] result in
            switch result {
            case .success(let gamesList):
                let newData = gamesList.compactMap({ $0.asViewModelSection() })
                self?.dataSourceData = newData
                self?.reloadDataTrigger.send((newData, nil))
            case .failure(let error):
                break
            }
        }
    }

    private func updateDataSource(sectionID: String? = nil, rowID: String? = nil) {
        guard let sectionID = sectionID,
              let indexOfSectionID = dataSourceData.firstIndex(where: { $0.key == sectionID })
        else { return }
        var reloadInfo: ReloadInfo?
        if let rowID = rowID,
           let indexOfRowID = dataSourceData[indexOfSectionID].fields?.firstIndex(where: { $0.key == rowID }) {
            dataSourceData[indexOfSectionID].fields?[indexOfRowID].favourite.toggle()
            reloadInfo = ReloadInfo(type: .row, section: indexOfSectionID, row: indexOfRowID)
        } else {
            dataSourceData[indexOfSectionID].expanded.toggle()
            reloadInfo = ReloadInfo(type: .section, section: indexOfSectionID)
        }
        reloadDataTrigger.send((dataSourceData, reloadInfo))
    }
}
