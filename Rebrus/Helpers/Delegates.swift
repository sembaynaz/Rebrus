//
//  Delegates.swift
//  Rebrus
//
//

import UIKit
protocol SomethingTappedDelegate: AnyObject {
    func somethingTapped()
}
protocol SendValueDelegate: AnyObject {
    func valueChanged(in cell: UITableViewCell, value: String)
}
