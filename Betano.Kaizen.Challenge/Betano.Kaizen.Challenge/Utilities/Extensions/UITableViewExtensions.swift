//
//  UITableViewExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import Foundation
import UIKit

//protocol ReusableView: AnyObject {
//    static var defaultReuseIdentifier: String { get }
//}
//
//extension ReusableView where Self: UIView {
//    static var defaultReuseIdentifier: String {
//        return NSStringFromClass(self)
//    }
//}

extension UITableView {
    func registerNoNibCell<T: UITableViewCell>(_:T.Type) {
        register(T.self, forCellReuseIdentifier: T.typeName)
    }

    func registerNoNibHeaderFooterView<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.typeName)
    }

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
}
