//
//  EventsCollectionViewController.swift
//  friends
//
//  Created by Lucas Alves Da Silva on 26/08/2018.
//  Copyright © 2018 Lucas Alves Da Silva. All rights reserved.
//

import UIKit

private let cellID = "CellID"

class EventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(EventsCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.isPagingEnabled = true
        navigationItem.title = "Events"
        navigationController?.extensionSetNavigationControllerBar(color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        
    }

     override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = .white

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: 500)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    

}


// -MARK: eventscell

class EventsCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
 
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    let containerView: UIView = {
      let container = UIView()
        let eventView = UIImageView()
        eventView.backgroundColor = UIColor.red
        eventView.layer.cornerRadius = 10
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.layer.masksToBounds = true
        eventView.image = UIImage(named: "eventBowling")
        
        container.frame = eventView.frame
        container.layer.masksToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(eventView)
        
        // constraints...
        
        container.extensionSetConstraintsWithFormat(horizontalFormat: "|[v0]|", verticalFormat: "|[v0]|", views: [eventView])
        container.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
      return container
    }()
    
    
    
    
//    collectionView setting up
    

    
 
    lazy var usersInEvent: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        
        
        let usersCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        usersCollection.translatesAutoresizingMaskIntoConstraints = false
        usersCollection.delegate = self
        usersCollection.dataSource = self
        usersCollection.register(UsersCell.self, forCellWithReuseIdentifier: "usersCollectionID")
        usersCollection.layer.cornerRadius = 10
        usersCollection.isScrollEnabled = true
        usersCollection.backgroundColor = UIColor.red
        usersCollection.layoutMargins.left = 10
        usersCollection.layoutMargins.right = 10
        usersCollection.extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: -3))
        usersCollection.showsHorizontalScrollIndicator = false
        return usersCollection
    }()
    
    let eventsLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = UIBaselineAdjustment.alignCenters
        label.textColor = UIColor.black
        label.layoutMargins.left = 10
        label.text = "bowling play"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = usersInEvent.dequeueReusableCell(withReuseIdentifier: "usersCollectionID", for: indexPath)
        
        return cell
    }
        
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
    func setUpCell(){
        
        layer.masksToBounds = false
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
        
        contentView.addSubview(usersInEvent)
        contentView.addSubview(containerView)
        contentView.addSubview(eventsLabel)
        
        extensionSetConstraintsWithFormat(horizontalFormat: "|-10-[v0]-10-|", verticalFormat: "|-10-[v0(200)][v1(60)]|", views: [containerView, usersInEvent])
        
        extensionSetConstraintsWithFormat(horizontalFormat: "|[v0]|", verticalFormat: nil, views: [usersInEvent])
        
        extensionSetConstraintsWithFormat(horizontalFormat: "|-10-[v0]-10-|", verticalFormat: "|-220-[v0(30)]|", views: [eventsLabel])
       


    }
    
}


class UsersCell: UICollectionViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUserCell()
    }
 

    func setUpUserCell(){
        
        layer.cornerRadius = self.frame.width/2
        frame.size = CGSize(width: 50, height: 50)
        backgroundColor = UIColor.blue
        extensionSetShadowEasy(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), offSet: CGSize(width: 0, height: 3))
        
    }

    
}



