//
//  PageCell.swift
//  Audible
//
//  Created by ashim Dahal on 10/13/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit

class  PageCell: UICollectionViewCell {
    
    var page : Page? {
        didSet{
            guard let page = page else {
                return
            }
            var pageImage = page.imageName
            
            if UIDevice.current.orientation.isLandscape {
                pageImage += "_landscape"
            }
            imageView.image = UIImage(named: pageImage)
            
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor : color]))
            
            let length = attributedText.string.characters.count
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "page1") // UIImage(name : "")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .yellow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let textView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Some Sample Code"
        // spacing for textView from current constraint
        textView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let lineSeparator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    func setupView(){
        // Always First load the view in hirachary before setting up constraint
        // Or else you will get view heriachary error
        
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparator)
        anchorImageView()
        anchorTextView()
        anchorlineSeparator()
    }
    func anchorImageView() {
        imageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        imageView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    func anchorTextView(){
        textView.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.33).isActive = true
        textView.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor, constant : 16).isActive = true
        textView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    func anchorlineSeparator(){
        lineSeparator.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        lineSeparator.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lineSeparator.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lineSeparator.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
