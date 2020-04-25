//
//  HomeTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 25/2/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hotAreaCollectionView:UICollectionView!
    @IBOutlet weak var categoryCollectionView:UICollectionView!
    @IBOutlet weak var recommendCollectionView:UICollectionView!
    @IBOutlet weak var allStoreCollectionView:UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        hotAreaCollectionView.delegate = self
        hotAreaCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        allStoreCollectionView.delegate = self
        allStoreCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension HomeTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == hotAreaCollectionView){
            return 7
        }else if(collectionView == categoryCollectionView){
            return 5
        }else if(collectionView == recommendCollectionView){
            return 5
        }
        else if(collectionView == allStoreCollectionView){
            return 15
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == hotAreaCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hotAreaCollectionViewCell", for: indexPath) as! hotAreaCollectionViewCell
            return cell
        }else if(collectionView == recommendCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCollectionViewCell", for: indexPath) as! recommendCollectionViewCell
            return cell
        }else if(collectionView == allStoreCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allStoreCollectionViewCell", for: indexPath) as! allStoreCollectionViewCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! categoryCollectionViewCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == hotAreaCollectionView){
            return CGSize(width: 254, height: 165)
        }else if(collectionView == recommendCollectionView){
            return CGSize(width: 176, height: 111)
        }else if(collectionViewLayout == allStoreCollectionView){
            return CGSize(width: 116, height: 43)
        }
        else{
             return CGSize(width: 87, height: 60)
        }
    }

}
