//
//  UIViewControllerExtensions.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 28/02/2022.
//

import UIKit

extension UIViewController {
    func executeInMainThread(code: @escaping () -> ()) {
        DispatchQueue.main.async { code() }
    }

    func executeInMainThread(withDelay delay: TimeInterval, code: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { code() }
    }
}
