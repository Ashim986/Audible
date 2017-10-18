//
//  ViewController.swift
//  Audible
//
//  Created by ashim Dahal on 10/12/17.
//  Copyright © 2017 ashim Dahal. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate : class {
    func finishLoggingIn()
}


class LoginController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginControllerDelegate{
    
    let cellID = "cellID"
    let loginCellID = "loginCellID"
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipBottomAnchor: NSLayoutConstraint?
    var nextBottomAnchor: NSLayoutConstraint?
    
    var pages : [Page] = {
        
        
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: "page1")
        
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book .choose \"Send This Book\"", imageName: "page2")
        
        let thirdPage = Page(title: "Send form the player", message: "Tap the More menu in the upper corner. Choose \" Send this Book\"", imageName: "page3")
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        
        return cv
    }()
    
    lazy var pageControl : UIPageControl = {
        let pgControl = UIPageControl()
        pgControl.pageIndicatorTintColor = .lightGray
        pgControl.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pgControl.numberOfPages = self.pages.count + 1
        return pgControl
    }()
    
    lazy var skipButton : UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handelSkipButton), for: .touchUpInside)
        return button
    }()
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(handelNextButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        observeKeyboardNotification()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        registerCell()
        
        collectionView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        // anchor is the set of nsAnchor where first member is top, second member is bottom and so on
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        skipBottomAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 80).first
        
        nextBottomAnchor = nextButton.anchor(view.topAnchor, left: nil , bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 80).first
        
    }
    
    @objc func handelNextButton() {
        if pageControl.currentPage == pages.count{
            return
        }
        
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstrainOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options:.curveEaseOut, animations: ({
                self.view.layoutIfNeeded()
            }), completion: nil)
        }
        let indexPath = IndexPath(item: pageControl.currentPage + 1 , section: 0)
        //item is for collection view as row is for table view
        //scrollToItem just takes to indexPath and let the collection view scroll directly to that index path
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    @objc func handelSkipButton(){
        // sending pageControl.current page to second last screen and animate next button condition to go to last screen.
        pageControl.currentPage = pages.count - 1
        handelNextButton()
    }
    
    func registerCell(){
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellID)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber =  targetContentOffset.pointee.x / view.frame.width
        pageControl.currentPage = Int(pageNumber)
        if pageNumber == CGFloat(pages.count)  {
            moveControlConstrainOffScreen()
        }else {
            self.pageControlBottomAnchor?.constant = 0
            // 16 is for top bar for network , battery , 
            self.skipBottomAnchor?.constant = 0
            self.nextBottomAnchor?.constant = 0
        }
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options:.curveEaseOut, animations: ({
            self.view.layoutIfNeeded()
        }), completion: nil)
    }
    
    func moveControlConstrainOffScreen(){
        
        self.pageControlBottomAnchor?.constant = 40
        self.skipBottomAnchor?.constant = -50
        self.nextBottomAnchor?.constant = -50
    }
    
    fileprivate func observeKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(){
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options:.curveEaseOut, animations: ({
            let y : CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
            
        }), completion: nil)
        
    }
    @objc func keyboardWillHide(){
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options:.curveEaseOut, animations: ({
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }), completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // if pages is at it will add one more cell at the end of collection views.
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellID, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
        
    }
    func finishLoggingIn(){
        // dismissing entire login view require to dismiss all the view heriarchy
        // The application has main window which can be access as below
        // keywindow give actual window of the application
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {
            return
        }
        mainNavigationController.viewControllers = [HomeController()]
        UserDefaults.standard.setIsLoggedIn(value: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.collectionViewLayout.invalidateLayout()
        // scroll to index path after the rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
        
    }
    
    
}

