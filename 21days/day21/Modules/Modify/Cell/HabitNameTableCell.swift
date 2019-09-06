//
//  HabitNameTableCell.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit
import NextGrowingTextView
import RxSwift
import RxCocoa

fileprivate let kNameMaxLength: Int = 30

class HabitNameTableCell: UITableViewCell, OMPCellable {
    
    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        
        nameTextField.backgroundColor = kAppTableCellBackColor
        nameTextField.placeholder = "给该习惯命名：例如早睡、早起、跑步等"
        nameTextField.borderStyle = .none
        iconButton.rx.tap.subscribe(onNext: {
            TableCellAction(key: ModifyHabitCellActions.clickChangeIconAction, sender: self).invoke()
        }).disposed(by: disposeBag)
        
        
        handleTextViewInput()
    }
}

extension HabitNameTableCell {
    fileprivate func handleTextViewInput() {
        nameTextField.rx.text.orEmpty.subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                var text = wself.nameTextField.text ?? ""
                if text.count > kNameMaxLength {
                    text = String(text.prefix(kNameMaxLength))
                }
                wself.nameTextField.text = text
                wself.inputNameAction()
            }).disposed(by: disposeBag)
    }
}

extension HabitNameTableCell {
    
    fileprivate func inputNameAction() {
        let name = nameTextField.text ?? ""
        let userInfo = ["inputName": name]
        TableCellAction(key: ModifyHabitCellActions.inputNameAction, sender: self, userInfo: userInfo).invoke()
    }

}

extension HabitNameTableCell: ConfigurableCell {
    func configure(with vm: HabitNameCellViewModel) {
        nameTextField.text = vm.name
        let iconName = vm.mirror.icon.stringValue
        iconButton.setImage(UIImage(named: iconName)?.renderWith(color: vm.mirror.color.cocoaColor), for: .normal)
    }
}
