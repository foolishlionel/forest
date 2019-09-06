//
//  DefaultHabitListVC.swift
//  day21
//
//  Created by flion on 2018/11/19.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

fileprivate let kDefaultHabitCollectCellReuseId = "kDefaultHabitCollectCellReuseId"

class DefaultHabitListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    fileprivate let interacter = HabitListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUniversal()
        _initCollectionView()
    }
    
    fileprivate func _initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kScreenWidth / 4.0, height: 91)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: 40)
        
        collectionView.register(UINib(nibName: "DefaultHabitCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kDefaultHabitCollectCellReuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DefaultHabitHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kDefaultHabitHeaderReuseId")
        collectionView.collectionViewLayout = flowLayout
    }
}

extension DefaultHabitListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habit = interacter.sections[indexPath.section][indexPath.item]
        let modifyVC = ModifyHabitViewController(habit: habit)
        modifyVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(modifyVC, animated: true)
    }
}

extension DefaultHabitListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return interacter.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let habitHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kDefaultHabitHeaderReuseId", for: indexPath) as? DefaultHabitHeader
            habitHeader?.index = indexPath.section
            return habitHeader!
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interacter.sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDefaultHabitCollectCellReuseId, for: indexPath) as? DefaultHabitCollectionViewCell
        cell?.habit = interacter.sections[indexPath.section][indexPath.item]
        return cell!
    }
}

extension DefaultHabitListVC: OPNaviUniversalable {
    fileprivate func initUniversal() {
        let closeItem = OPNavigationBarItemMetric.close
        universal(model: closeItem) { [weak self] _ in
            guard let wself = self else { return }
            wself.dismiss(animated: true, completion: nil)
        }
    }
}
