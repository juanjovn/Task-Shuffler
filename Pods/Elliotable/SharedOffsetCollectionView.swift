//
//  SharedOffsetCollectionView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 22/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit


// MARK: - Notifications

extension Notification.Name {
    
    /// Posted everytime when a `SharedOffsetCollectionView` scrolls. The object is the instances that got scrolled.
    fileprivate static let didScroll = Notification.Name(rawValue: "SharedContentOffset.didScroll")
}

// MARK: - Class Definition

/// `UICollectionView` subclass that makes all its instances have the same scroll offset.
/// When one instance scrolls all others will follow to the same content offset.
class SharedOffsetCollectionView: UICollectionView {
    
    /// Simple flag used for internal logic control.
    private var shouldTrack = true
    
    override var contentOffset: CGPoint {
        willSet {
            NotificationCenter.default.removeObserver(self, name: .didScroll, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(scrollOccured(_:)), name: .didScroll, object: nil)
        }
        didSet {
            guard shouldTrack == true else { return }
            NotificationCenter.default.post(name: .didScroll, object: self)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didScroll, object: nil)
    }
}

// MARK: - Notifications

extension SharedOffsetCollectionView {
    
    /// Called when a `SharedOffsetCollectionView` scrolls.
    /// It sets the content offset of other instances to the one that got scrolled
    /// while making them not track that change to avoid recursion.
    @objc private func scrollOccured(_ notification: Notification) {
        guard let scrollView = notification.object as? UIScrollView else { return }
        guard scrollView != self else { return }
        
        shouldTrack = false
        setContentOffset(scrollView.contentOffset, animated: false)
        shouldTrack = true
    }
}
