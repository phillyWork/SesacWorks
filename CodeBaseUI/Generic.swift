//
//  Generic.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    func transition<T: UIViewController>(transitionType: TransitionType, viewController: T.Type) {
        let vc = T()
        switch transitionType {
        case .present:
            present(vc, animated: true)
        case .presentNav:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentNavFullScreen:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
