//
//  Reusable.swift
//  App
//
//  Created by Sheikh Ahmed on 16/07/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}

extension UITableView {
    func register<Cell>(_: Cell.Type) where Cell: UITableViewCell {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<Cell>(_: Cell.Type) where Cell: UITableViewCell, Cell: NibBased {
        register(Cell.nib, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<HeaderFooter>(_: HeaderFooter.Type) where HeaderFooter: UITableViewHeaderFooterView, HeaderFooter: NibBased {
        register(HeaderFooter.nib, forHeaderFooterViewReuseIdentifier: HeaderFooter.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("unable to dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooter<HeaderFooter>() -> HeaderFooter where HeaderFooter: UITableViewHeaderFooterView {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: HeaderFooter.reuseIdentifier) as? HeaderFooter else {
            fatalError("unable to dequeue HeaderFooter with identifier: \(HeaderFooter.reuseIdentifier)")
        }
        return view
    }
}

extension UICollectionView {
    func register<Cell>(_: Cell.Type) where Cell: UICollectionViewCell {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<Cell>(_: Cell.Type) where Cell: UICollectionViewCell, Cell: NibBased {
        register(Cell.nib, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func register<ReusableView>(_: ReusableView.Type, forSupplementaryViewOfKind kind: String) where ReusableView: UICollectionReusableView {
        register(ReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: ReusableView.reuseIdentifier)
    }
    
    func register<ReusableView>(_: ReusableView.Type, forSupplementaryViewOfKind kind: String) where ReusableView: UICollectionReusableView, ReusableView: NibBased {
        register(ReusableView.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: ReusableView.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("unable to dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<ReusableView>(ofKind kind: String, for indexPath: IndexPath) -> ReusableView where ReusableView: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableView.reuseIdentifier, for: indexPath) as? ReusableView else {
            fatalError("unable to dequeue reusable view with identifier: \(ReusableView.reuseIdentifier)")
        }
        return view
    }
}
