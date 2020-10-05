//
//  MainLayout.swift
//  500px
//
//  Created by Kurt Kim on 2020-10-01.
//

import UIKit

protocol MainLayoutDelegate {
    func collectionView(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
}

class MainLayout: UICollectionViewLayout {
   
//    variables
    private var itemAttributes = [UICollectionViewLayoutAttributes]()
    var columnOffsets: [CGFloat]!
    var delegate: MainLayoutDelegate!
    var layoutVertical = true
    var doubleCellProbability = 5 // between 0 and 10
    var columnsCount = 3
    var columnWidth: CGFloat = 0
    var cellPadding: CGFloat = 1.0

//    Functions
    override var collectionViewContentSize: CGSize {
        get {
            guard var size = self.collectionView?.bounds.size else { return CGSize.zero }
            let longestIndex = self.longestColumnIndex()
            let columnMax = self.columnOffsets[longestIndex]
            size.height = columnMax
            return size
        }
    }
    
    override func prepare() {
        self.itemAttributes.removeAll()
        setColumnWidth()
        guard let itemCounts = self.collectionView?.numberOfItems(inSection: 0) else { return }
        columnOffsets = [CGFloat].init(repeating: 0, count: columnsCount)
        
        
        for i in 0..<itemCounts {
            
            let shortestIndex = self.shortestColumnIndex()
            let xPosition = shortestIndex * Int(self.columnWidth)
            let yPosition = Int(self.columnOffsets[shortestIndex])
            let indexPath = IndexPath(item: i, section: 0)
            
            
            let itemSize = delegate.collectionView(collectionView: self.collectionView!, indexPath: indexPath)
            let width = (canDoubleCellWidth(at: shortestIndex, indexPath: indexPath) ? 2 * columnWidth : columnWidth)
            var height = round(width/itemSize.width*itemSize.height)
            
            
            height += height / width < 1 ? CGFloat(40 - (Int(height) % 40)) : -CGFloat(Int(height) % 40)
            columnOffsets[shortestIndex] = CGFloat(yPosition) + height
            if width > columnWidth {
                columnOffsets[shortestIndex+1] = CGFloat(yPosition) + height
            }
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: CGFloat(xPosition), y: CGFloat(yPosition), width: width, height: height).insetBy(dx: cellPadding, dy: cellPadding)
            self.itemAttributes.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.itemAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.item < self.itemAttributes.count else { return nil }
        return self.itemAttributes[indexPath.item]
    }
    
    private func shortestColumnIndex() -> Int {
        return columnOffsets.firstIndex(of: columnOffsets.min()!)!
    }
    
    private func longestColumnIndex() -> Int {
        return columnOffsets.firstIndex(of: columnOffsets.max()!)!
    }
    
    private func setColumnWidth() {
        self.columnWidth = round(self.collectionView!.bounds.size.width / CGFloat(self.columnsCount))
    }
    
    private func canDoubleCellWidth(at index: Int, indexPath: IndexPath) -> Bool {
        return (index < self.columnsCount - 1) && self.columnOffsets[index] == self.columnOffsets[index+1] && indexPath.item % 10 < doubleCellProbability
    }
}
