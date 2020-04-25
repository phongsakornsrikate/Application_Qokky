//
//  SearchTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 29/2/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var RecentSearchCollectionView:UICollectionView!
    @IBOutlet weak var PopularSearchCollectionView:UICollectionView!
    @IBOutlet weak var InterestingSearchCollectionView:UICollectionView!
    @IBOutlet weak var AllStoreSearchCollectionView:UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.RecentSearchCollectionView.delegate = self
        self.RecentSearchCollectionView.dataSource = self
        self.PopularSearchCollectionView.delegate = self
        self.PopularSearchCollectionView.dataSource = self
        self.InterestingSearchCollectionView.delegate = self
        self.InterestingSearchCollectionView.dataSource = self
        self.AllStoreSearchCollectionView.delegate = self
        self.AllStoreSearchCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}

extension SearchTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == RecentSearchCollectionView){
            return 4
        }else if(collectionView == InterestingSearchCollectionView){
            return 3
        }else if(collectionView == AllStoreSearchCollectionView){
            return 15
        }
        else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == RecentSearchCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentSearchCollectionViewCell", for: indexPath) as! RecentSearchCollectionViewCell
            return cell
        }else if(collectionView == InterestingSearchCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestingSearchCollectionViewCell", for: indexPath) as! InterestingSearchCollectionViewCell
            return cell
        }else if(collectionView == AllStoreSearchCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllStoreSearchCollectionViewCell", for: indexPath) as! AllStoreSearchCollectionViewCell
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularSearchCollectionViewCell", for: indexPath) as! PopularSearchCollectionViewCell
                       return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == RecentSearchCollectionView){
            return CGSize(width: 125, height: 54)
        }else if(collectionView == InterestingSearchCollectionView){
                  return CGSize(width: 375, height: 140)
              }
        else if(collectionView == AllStoreSearchCollectionView){
            return CGSize(width: 116, height: 52)
        }
        else{
             return CGSize(width: 125, height: 54)
        }
    }
    
    
    
   }
