//
//  TableViewModel.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import Combine
import UIKit

protocol TableViewModelType: AnyObject, ViewModelType {
    
}

class TableViewModel: TableViewModelType {

    // MARK: - Properties

    struct Input {
        let viewDidLoadTrigger: Driver<Void>
        let selectedIndexPath: PassthroughSubject<IndexPath, Never>
    }

    struct Output {
        let reloadDataTrigger: PassthroughSubject<[ViewModelSection], Never>
    }

    var dataSourceData: [ViewModelSection] = []
    var reloadDataTrigger = PassthroughSubject<[ViewModelSection], Never>()

    // MARK: - Initializers

    init(coordinator: TableViewCoordinatorType) {}

    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        input.viewDidLoadTrigger.sink { [weak self] _ in
            self?.createDataSource()
        }
        .store(in: disposeBag)

        input.selectedIndexPath.sink { [weak self] indexPath in
            print(">>> IndexPath: S: \(indexPath.section) ; R: \(indexPath.row)")
        }
        .store(in: disposeBag)

        return Output(reloadDataTrigger: reloadDataTrigger)
    }

    // MARK: - Private Methods

    func createDataSource() {
        ServicesRequests.getListOfSports { [weak self] result in
            switch result {
            case .success(let gamesList):
                print(gamesList)
                let newData = gamesList.compactMap({ $0.asViewModelSection() }) ?? []
                self?.dataSourceData = newData
                self?.reloadDataTrigger.send(newData)
            case .failure(let error):
                break
            }
        }
    }
}
