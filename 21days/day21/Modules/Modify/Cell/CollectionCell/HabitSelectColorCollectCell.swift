//
//  HabitSelectColorCollectCell.swift
//  day21
//
//  Created by flion on 2018/10/17.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

typealias ClickColorBlock = (HabitColor) -> Void

class HabitSelectColorCollectCell: UICollectionViewCell {
    var clickColor: ClickColorBlock?
    @IBOutlet weak var collect: UICollectionView!
    fileprivate var habitColors = [HabitColor]()
    
    fileprivate var colorTuples = [(HabitColor, Bool)]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.colorView.clipsToBounds = true
//        self.colorView.layer.cornerRadius = 30.0
        setupCollectView()
    }
    
    fileprivate func setupCollectView() {
        
        collect.register(UINib(nibName: "HabitSubColorCollectCell", bundle: nil), forCellWithReuseIdentifier: "HabitSubColorCollectCell")
        collect.delegate = self
        collect.dataSource = self
        
        let itemHeight = ((kScreenWidth - 24) - 8 * 5) / 6
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemHeight, height: itemHeight)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        collect.collectionViewLayout = layout
        collect.isScrollEnabled = false
    }
    
    func handleCell(colorTuples: [(HabitColor, Bool)]) {
        self.colorTuples = colorTuples
        collect.reloadData()
    }
}

extension HabitSelectColorCollectCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = clickColor {
            let color = colorTuples[indexPath.item].0
            block(color)
        }
    }
}

extension HabitSelectColorCollectCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorTuples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitSubColorCollectCell", for: indexPath) as! HabitSubColorCollectCell
        cell.colorTuple = colorTuples[indexPath.item]
        return cell
    }
}
