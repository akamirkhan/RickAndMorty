//
//  ModuleTransitionable.swift
//  RickAndMorty
//
//  Created by Amirkhan Akaev on 2/1/23.
//

import UIKit

protocol ModuleTransitionable: AnyObject {
    func dismissModule(animation: Bool, completion: (() -> Void)?)
    func pushModule(module: UIViewController, animation: Bool)
    func popModule(animation: Bool)
    func presentModule(
        module: UIViewController, presentationStyle: UIModalPresentationStyle,
        animation: Bool, completion: (() -> Void)?
    )
}

extension ModuleTransitionable where Self: UIViewController {
    func dismissModule(animation: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animation, completion: completion)
    }

    func pushModule(module: UIViewController, animation: Bool) {
        self.navigationController?.pushViewController(module, animated: true)
    }

    func popModule(animation: Bool) {
        self.navigationController?.popViewController(animated: animation)
    }

    func presentModule(
        module: UIViewController, presentationStyle: UIModalPresentationStyle = .fullScreen,
        animation: Bool, completion: (() -> Void)?
    ) {
        module.modalPresentationStyle = presentationStyle
        self.present(module, animated: animation, completion: completion)
    }

}
