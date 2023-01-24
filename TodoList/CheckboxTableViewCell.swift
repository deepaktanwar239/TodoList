//
//  CheckboxTableViewCell.swift
//  TodoList
//
//  Created by Deepak Tanwar on 27/12/22.
//

import UIKit

protocol CheckboxTableViewCellDelegate : AnyObject {
    func checkTableViewCell(_ cell : CheckboxTableViewCell, didChangeCheckState checked : Bool)
}

class CheckboxTableViewCell: UITableViewCell {

    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var lbl: UILabel!
    weak var delegate :  CheckboxTableViewCellDelegate?
    @IBAction func checked(_ sender : Checkbox){
        updateChecked()
        delegate?.checkTableViewCell(self, didChangeCheckState: checkbox.checked)
    }
    func set(title : String, checkBox : Bool){
        self.lbl.text = title
        self.checkbox.checked = checkBox
        updateChecked()
    }
    func setChekbox(checked : Bool){
        checkbox.checked = checked
        updateChecked()
    }
    func updateChecked(){
        let attributeString = NSMutableAttributedString(string: lbl.text ?? "")
        if checkbox.checked{
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length-1))
        }else{
            attributeString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributeString.length-1))
        }
        lbl.attributedText = attributeString
    }
}
