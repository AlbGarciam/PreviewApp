//
//  ColumnsCollectionFlowLayout.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 04/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class ColumnsCollectionFlowLayout: UICollectionViewLayout {
    var cellHeight: CGFloat = 160
    var numberOfColumns: Int = 2
    var cellPadding: CGFloat = 13.0
    
    private var cache = [[UICollectionViewLayoutAttributes]]()
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override  var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        for section in 0 ..< collectionView.numberOfSections {
            column = 0
            var sectionCache = [UICollectionViewLayoutAttributes]()
            
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let height = cellPadding * 2 + cellHeight
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                sectionCache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                if yOffset[column] >= (yOffset.max() ?? 0) {
                    column = column < (numberOfColumns - 1) ? (column + 1) : 0
                }
            }
            cache.append(sectionCache)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        cache.forEach {
            $0.forEach({ (attributes) in
                if attributes.frame.intersects(rect) {
                    layoutAttributes.append(attributes)
                }
            })
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.section][indexPath.item]
    }
    
    override func invalidateLayout() {
        cache = [[UICollectionViewLayoutAttributes]]()
        super.invalidateLayout()
    }
}
