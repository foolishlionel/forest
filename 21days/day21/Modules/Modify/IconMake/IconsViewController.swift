//
//  IconsViewController.swift
//  day21
//
//  Created by flion on 2019/6/18.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IconsViewController: UIViewController {
    
    var clickMirrorBlock: ClickMirrorBlock?
    
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    fileprivate var currentMirror = HabitMirror(icon: .apple, color: .color1, category: .other)
    
    fileprivate let interactor = IconMakeInteractor()
    
    fileprivate let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: "IconsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSubviews()
    }

    fileprivate func setupSubviews() {
        bgContentView.layer.cornerRadius = 10
        bgContentView.layer.masksToBounds = true
        
        setupTableView()
        
        confirmButton.backgroundColor = kAppLightSkyBlueThemeColor
        
        closeButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let wself = self else { return }
            wself.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        confirmButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let wself = self else { return }
            if let block = wself.clickMirrorBlock {
                block(wself.currentMirror)
            }
            wself.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupTableView() {
        tableView.register(UINib(nibName: "IconContentTableCell", bundle: nil), forCellReuseIdentifier: IconContentTableCell.cellReuseIdentifier)
        tableView.register(UINib(nibName: "CategoryContentTableCell", bundle: nil), forCellReuseIdentifier: CategoryContentTableCell.cellReuseIdentifier)
        tableView.register(UINib(nibName: "ColorContentTableCell", bundle: nil), forCellReuseIdentifier: ColorContentTableCell.cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
}

extension IconsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 30, height: 32.5))
        if section == 0 {
            label.text = "选择图标"
        } else {
            label.text = "选择颜色"
        }
        return label
    }
}

extension IconsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let data = interactor.doubleLevelHabitMirrors()
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IconContentTableCell.cellReuseIdentifier, for: indexPath) as! IconContentTableCell
                cell.handleCell(doubleLevelMirrors: data) { [weak self] mirror in
                    guard let wself = self else { return }
                    wself.currentMirror = mirror
                }
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryContentTableCell.cellReuseIdentifier, for: indexPath) as! CategoryContentTableCell
            cell.handleCell(doubleLevelMirrors: data) { [weak self] index in
                guard let wself = self else { return }
                ompLog("category index is \(index)")
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ColorContentTableCell.cellReuseIdentifier, for: indexPath) as! ColorContentTableCell
            cell.clickColorBlock = { [weak self] color in
                guard let wself = self else { return }
                wself.currentMirror.color = color
            }
            return cell
        }
    }
}
