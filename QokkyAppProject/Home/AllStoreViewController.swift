import UIKit
import  Firebase

class AllStoreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
   
    
    
    
     //// collectionView  //////////////////////
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nameAllStoreClassArr.count
          
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allStoreCollectionViewCell", for: indexPath) as! allStoreCollectionViewCell
              let NameAllStore:NameAllStoreClass
                         NameAllStore = nameAllStoreClassArr[indexPath.row]
              cell.label.text = NameAllStore.nameStoreLabel
              
              
              cell.BgView.layer.shadowColor = UIColor.black.cgColor
              cell.BgView.layer.shadowOpacity = 0.2
              cell.BgView.layer.masksToBounds = false
              cell.BgView.layer.shadowOffset = CGSize(width: 0.0 , height: 2.0)
              cell.BgView.layer.shadowRadius = 1
              return cell
          
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
              return CGSize(width: 116, height: 43)
         
      }
      

     @IBOutlet weak var allStoreCollectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
               allStoreCollectionView.delegate = self
               allStoreCollectionView.dataSource = self
        
         readDataNamesStore()
    }
    
    
    
       ////  get All Store name ///////////
       /////// Query name All store in App //////////////////////////////////////////////////////////
           
          //   let dbRef = Firestore.firestore()
            var  nameAllStoreClassArr = [NameAllStoreClass]()
          
            func readDataNamesStore() {
                  
                     let db = Firestore.firestore()
                     let colRef = db.collection("Store")
                            colRef.getDocuments() { (querySnapshot, err) in
                                if err != nil {
                                    print("error")

                                }
                                else {

                                  self.nameAllStoreClassArr.removeAll()
                                    for doc in querySnapshot!.documents {
                                     print("\(doc.documentID) => \(doc.data())")
                                      
                                         let StoreID = doc.get("StoreID") as? String
                                         let NameStore = doc.get("Name") as? String
                                  


                                      




                                      let Data = NameAllStoreClass(StoreID: StoreID, nameStoreLabel: NameStore)
                                    self.nameAllStoreClassArr.insert(Data, at: 0) //sort Data มากไปน้อย
        
                                      self.allStoreCollectionView.reloadData()

                                    }


                                }
                            }
                 }


    ///// Back to home ///
    @IBAction func back(_ sender:Any){
           
                  let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                  navigationController?.pushViewController(vc, animated: true)
              
          }

}
