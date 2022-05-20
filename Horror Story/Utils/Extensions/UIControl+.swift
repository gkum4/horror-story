//
//  UIControl+.swift
//  Horror Story
//
//  Created by Gustavo Kumasawa on 20/05/22.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
