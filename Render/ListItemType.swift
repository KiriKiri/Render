//
//  ListItemType.swift
//  Render
//
//  Created by Alex Usbergo on 02/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import UIKit

public protocol ListComponentItemDelegate: class {

    /// The item has been selected.
    /// - parameter item: The selected item.
    /// - parameter indexPath: The indexpath for the current item.
    /// - parameter listComponent: The list component view that owns the list item
    func didSelectItem(item: ListComponentItemType, indexPath: NSIndexPath, listComponent: ListComponentView)
}

public protocol ListComponentItemType {
    
    /// The reuse identifier for the component passed as argument.
    var reuseIdentifier: String { get }
    
    /// The component state.
    var itemState: ComponentStateType { get  set }
    
    /// Additional configuration closure for the component.
    var configuration: ((ComponentViewType) -> Void)? { get }
    
    /// The list item delegate.
    weak var delegate: ListComponentItemDelegate? { get set }
    
    /// Creates a new instance for the associated component.
    func newComponentIstance() -> ComponentViewType
}

public class ListComponentItem<C: ComponentViewType, S: ComponentStateType>: ListComponentItemType {
    
    /// The reuse identifier for the component passed as argument.
    public var reuseIdentifier: String
    
    /// The component state.
    public var itemState: ComponentStateType
    public var state: S {
        return self.itemState as! S
    }
    
    /// Additional configuration closure for the component.
    public var configuration: ((ComponentViewType) -> Void)?
    
    /// The list item delegate.
    public weak var delegate: ListComponentItemDelegate? = nil
    
    /// Initialise a new component with
    public init(reuseIdentifier: String = String(C), state: S, configuration: ((ComponentViewType) -> Void)? = nil) {
        self.reuseIdentifier = reuseIdentifier
        self.itemState = state
        self.configuration = configuration
    }
    
    /// Creates a new instance for the associated component
    public func newComponentIstance() -> ComponentViewType {
        return C() as ComponentViewType
    }
}

public struct ListComponentState: ComponentStateType {
    
    /// Simply wraps the items inside 
    public let items: [ListComponentItemType]
}


