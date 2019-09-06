//
//  HabitEncourageTableCell.swift
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

fileprivate let kEncourageWordMaxLength: Int = 50

class HabitEncourageTableCell: UITableViewCell, OMPCellable {
    
    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var nextGrowTextView: NextGrowingTextView!
    @IBOutlet weak var randomButton: OPButton!
    @IBOutlet weak var limitCountLabel: UILabel!
    
    fileprivate let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        
        bgContent.backgroundColor = UIColor(240, 240, 240)
        nextGrowTextView.backgroundColor = UIColor(240, 240, 240)
        nextGrowTextView.placeholderAttributedText = NSAttributedString(
            string: "写一句话鼓励自己",
            attributes:[
                .font: self.nextGrowTextView.textView.font!,
                .foregroundColor: UIColor.gray
            ]
        )
        
        nextGrowTextView.delegates.didChangeHeight = { ompLog("height is \($0)") }
        handleTextViewInput()
        
        randomButton.setTitleColor(kAppSkyBlueThemeColor, for: .normal)
        randomButton.layer.borderColor = kAppSkyBlueThemeColor.cgColor
        randomButton.layer.borderWidth = 0.5
        randomButton.layer.cornerRadius = 5
        
        randomButton.imgRect = CGRect.init(x: 0, y: 5, width: 20, height: 20)
        randomButton.textRect = CGRect.init(x: 0, y: 5, width: 27, height: 20)
    }

    @IBAction func randomButtonClicked(_ sender: Any) {
        TableCellAction(key: ModifyHabitCellActions.randomEncoruageAction, sender: self).invoke()
    }
    
}

extension HabitEncourageTableCell {
    
    fileprivate func handleTextViewInput() {
        nextGrowTextView.textView
            .rx.didChange.subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                var text = wself.nextGrowTextView.textView.text ?? ""
                if text.count > kEncourageWordMaxLength {
                    text = String(text.prefix(kEncourageWordMaxLength))
                }
                wself.nextGrowTextView.textView.text = text
                wself.inputEncourageAction()
            }).disposed(by: disposeBag)
        
        nextGrowTextView.textView
            .rx.text.asObservable()
            .subscribe(onNext: { [weak self] text in
                guard let wself = self else { return }
                guard let text = text else {
                    wself.limitCountLabel.text = "0 / \(kEncourageWordMaxLength)"
                    return
                }
                let textCount = text.count
                wself.limitCountLabel.text = "\(textCount) / \(kEncourageWordMaxLength)"
        }).disposed(by: disposeBag)
    }
    
    fileprivate func inputEncourageAction() {
        let words = nextGrowTextView.textView.text ?? ""
        let userInfo = ["encourageWords": words]
        TableCellAction(key: ModifyHabitCellActions.inputEncourageAction, sender: self, userInfo: userInfo).invoke()
    }
}

extension HabitEncourageTableCell: ConfigurableCell {
    func configure(with vm: HabitEncourageCellViewModel) {
        nextGrowTextView.textView.text = vm.encourageWords
    }
}
