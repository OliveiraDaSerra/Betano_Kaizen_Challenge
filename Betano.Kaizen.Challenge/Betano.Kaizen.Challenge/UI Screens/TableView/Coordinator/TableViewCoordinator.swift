//
//  TableViewCoordinator.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit

protocol TableViewCoordinatorType: AnyObject {
    var viewController: UIViewController? { get set }
}

class TableViewCoordinator: TableViewCoordinatorType {

    // MARK: - Properties
    var viewController: UIViewController?

    // Initializers
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    // MARK: - Methods
    func screen(_ screen: Screen) {
        switch screen {
        case .dismiss:
            viewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension TableViewCoordinator {
    enum Screen {
        case dismiss
    }
}
