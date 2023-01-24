//
//  Checkbox.swift
//  TodoList
//
//  Created by Deepak Tanwar on 27/12/22.
//

import Foundation
import UIKit
@IBDesignable
class Checkbox: UIControl {
    
    private weak var imageView : UIImageView!
    
    @IBInspectable
    var checked : Bool = false {
        didSet {
            imageView.image = image
        }
    }
    
    private var image : UIImage {
        return checked ? UIImage(systemName: "checkmark.square.fill")!  : UIImage(systemName: "square")!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.image = image
        imgView.contentMode = .scaleAspectFit
        self.imageView = imgView
        backgroundColor = UIColor.clear
        addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
    }
    
    @objc func buttonTouch(){
        if checked {
            checked = false
        }else{
            checked = true
        }
        sendActions(for: .valueChanged)
    }
    
}
