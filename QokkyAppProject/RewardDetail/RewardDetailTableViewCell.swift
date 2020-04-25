//
//  RewardDetailTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 4/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class RewardDetailTableViewCell: UITableViewCell {

     @IBOutlet weak var ImageRewardDetailCollectionView:UICollectionView!
     @IBOutlet weak var ImageRewardDetailRecommendCollectionView:UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ImageRewardDetailCollectionView.delegate = self
        self.ImageRewardDetailCollectionView.dataSource = self
        self.ImageRewardDetailRecommendCollectionView.delegate = self
        self.ImageRewardDetailRecommendCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


    extension RewardDetailTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == ImageRewardDetailCollectionView){
            return 4
        }
        else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == ImageRewardDetailCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageRewardDetailCollectionViewCell", for: indexPath) as! ImageRewardDetailCollectionViewCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageRewardDetailRecommendCollectionViewCell", for: indexPath) as! ImageRewardDetailRecommendCollectionViewCell
                       return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == ImageRewardDetailCollectionView){
            return CGSize(width: 375, height: 196)
        }
        else{
            return CGSize(width: 174, height: 125)
        }
    }
    
}
    
