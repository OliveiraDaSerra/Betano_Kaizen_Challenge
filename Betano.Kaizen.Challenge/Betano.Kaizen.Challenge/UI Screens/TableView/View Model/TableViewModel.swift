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
        let reloadDataTrigger: Driver<Void>
    }

    var dataSourceData: [ViewModelSection] = []

    var reloadDataTrigger = PassthroughSubject<Void, Never>()

    // MARK: - Initializers

    init(coordinator: TableViewCoordinatorType) {}

    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        input.viewDidLoadTrigger.sink { [weak self] _ in
            
        }
        .store(in: disposeBag)

        return Output(reloadDataTrigger: reloadDataTrigger.asDriver())
    }

    // MARK: - Private Methods

    func createDataSource() -> [ViewModelSection] {
        return []
    }
}
