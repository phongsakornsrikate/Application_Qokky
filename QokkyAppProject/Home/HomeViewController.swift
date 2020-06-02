//
//  HomeViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 23/1/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    
    //////////////   Action sheet setup /////////////////////////
    enum CardState {
        case expanded
        case collapsed
    }
    
    
    ///set up card
    
    var CardViewController:cardViewController!
    var visualEffectView:UIVisualEffectView!
    
    ///set up  noticard card
    
    var NotificationsCardViewController:notificationViewController!
    
    let cardHeight:CGFloat = 680
    let cardHandleAreaHeight:CGFloat = 85
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    
    
    ///// cardViewController
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        //    self.view.addSubview(visualEffectView)
        
        CardViewController = cardViewController(nibName:"cardViewController", bundle:nil)
        self.addChild(CardViewController)
        // self.view.addSubview(CardViewController.view)
        
        CardViewController.view.frame = CGRect(x: 0, y: 400, width: self.view.bounds.width, height: cardHeight)
        
        CardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardPan(recognizer:)))
        let tapGestureRecognizer_closeBtn = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer_closeBtn = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardPan(recognizer:)))
        
        
        
        
        CardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        CardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        CardViewController.handleCloseBtn.addGestureRecognizer(tapGestureRecognizer_closeBtn)
        CardViewController.handleCloseBtn.addGestureRecognizer(panGestureRecognizer_closeBtn)
        
        
        
        
    }
    
    ///// notificationCardViewController
    func setupNotificationsCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        
        NotificationsCardViewController = notificationViewController(nibName:"notificationViewController", bundle:nil)
        self.addChild(NotificationsCardViewController)
        
        NotificationsCardViewController.view.frame = CGRect(x: 0, y: 400, width: self.view.bounds.width, height: cardHeight)
        
        NotificationsCardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardPan(recognizer:)))
        let tapGestureRecognizer_closeBtn = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer_closeBtn = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardPan(recognizer:)))
        
        
        
        
        NotificationsCardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        NotificationsCardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        NotificationsCardViewController.handleCloseBtn.addGestureRecognizer(tapGestureRecognizer_closeBtn)
        NotificationsCardViewController.handleCloseBtn.addGestureRecognizer(panGestureRecognizer_closeBtn)
        
        
        
        
    }
    
    //// clicked action sheet
    var actionSheet_No = 0
    
    var openSlideMenu = false
    
    @IBAction func slideMenuBtn(_ sender:Any){
        actionSheet_No = 1
        if(openSlideMenu == false){
            self.view.addSubview(visualEffectView)
            self.view.addSubview(CardViewController.view)
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
            openSlideMenu = true
        }
    }
    
    var openSlideNotifications = false
    @IBAction func slideNotificationsBtn(_ sender:Any){
        actionSheet_No = 2
        if(openSlideNotifications == false){
            self.view.addSubview(visualEffectView)
            self.view.addSubview(NotificationsCardViewController.view)
            animateTransitionIfNeeded_noti(state: nextState, duration: 0.9)
            openSlideNotifications = true
        }
    }
    
    
    
    
    
    
    /////// get handle View
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            
            self.visualEffectView.removeFromSuperview()
            if(actionSheet_No == 1){
            if(self.openSlideMenu == true){
                
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
                self.CardViewController.view.removeFromSuperview()
                self.CardViewController.removeFromParent()
                openSlideMenu = false
                actionSheet_No = 0
                }}
            else if(actionSheet_No == 2){
                    if(self.openSlideNotifications == true){
                
                animateTransitionIfNeeded(state: nextState, duration: 0.9)
                self.NotificationsCardViewController.view.removeFromSuperview()
                self.NotificationsCardViewController.removeFromParent()
                openSlideNotifications = false
                actionSheet_No = 0
                }
            }
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            if(actionSheet_No == 1){
                
               
                    let translation = recognizer.translation(in: self.CardViewController.handleArea)
                    var fractionComplete = translation.y / cardHeight
                    fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                    updateInteractiveTransition(fractionCompleted: fractionComplete)
                    }
            else if(actionSheet_No == 2){
                   
                    
                    let translation = recognizer.translation(in: self.NotificationsCardViewController.handleArea)
                    var fractionComplete = translation.y / cardHeight
                    fractionComplete = cardVisible ? fractionComplete : -fractionComplete
                    updateInteractiveTransition(fractionCompleted: fractionComplete)
                    }
                case .ended:
                continueInteractiveTransition()
                if(actionSheet_No == 1){
                    
                    
                    self.visualEffectView.removeFromSuperview()
                    self.CardViewController.view.removeFromSuperview()
                    self.CardViewController.removeFromParent()
                    openSlideMenu = false
                    }
                if(actionSheet_No == 2){
                    
                    
                    self.visualEffectView.removeFromSuperview()
                    self.NotificationsCardViewController.view.removeFromSuperview()
                    self.NotificationsCardViewController.removeFromParent()
                    openSlideNotifications = false
                    
                }
                default:
                break
            }
            
        }
        
        func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                            self.CardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                    case .collapsed:
                       
                            self.CardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                    }
                }
                
                frameAnimator.addCompletion { _ in
                    self.cardVisible = !self.cardVisible
                    self.runningAnimations.removeAll()
                }
                
                frameAnimator.startAnimation()
                runningAnimations.append(frameAnimator)
                
                
                let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                    switch state {
                    case .expanded:
                            self.CardViewController.view.layer.cornerRadius = 12
                    case .collapsed:
                            self.CardViewController.view.layer.cornerRadius = 0
                    }
                }
                
                cornerRadiusAnimator.startAnimation()
                runningAnimations.append(cornerRadiusAnimator)
                
                let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                    switch state {
                    case .expanded:
                        self.visualEffectView.effect = UIBlurEffect(style: .dark)
                    case .collapsed:
                        self.visualEffectView.effect = nil
                    }
                }
                
                blurAnimator.startAnimation()
                runningAnimations.append(blurAnimator)
            }
        }
        
        func startInteractiveTransition(state:CardState, duration:TimeInterval) {
            if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
            }
            for animator in runningAnimations {
                animator.pauseAnimation()
                animationProgressWhenInterrupted = animator.fractionComplete
            }
        }
        
        func updateInteractiveTransition(fractionCompleted:CGFloat) {
            for animator in runningAnimations {
                animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
            }
        }
        
        func continueInteractiveTransition (){
            for animator in runningAnimations {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
        }
    
    
    ///// aniate slide notifiication///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func animateTransitionIfNeeded_noti (state:CardState, duration:TimeInterval) {
              if runningAnimations.isEmpty {
                  let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                      switch state {
                      case .expanded:
                              self.NotificationsCardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                      case .collapsed:
                         
                              self.NotificationsCardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                      }
                  }
                  
                  frameAnimator.addCompletion { _ in
                      self.cardVisible = !self.cardVisible
                      self.runningAnimations.removeAll()
                  }
                  
                  frameAnimator.startAnimation()
                  runningAnimations.append(frameAnimator)
                  
                  
                  let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                      switch state {
                      case .expanded:
                              self.NotificationsCardViewController.view.layer.cornerRadius = 12
                      case .collapsed:
                              self.NotificationsCardViewController.view.layer.cornerRadius = 0
                      }
                  }
                  
                  cornerRadiusAnimator.startAnimation()
                  runningAnimations.append(cornerRadiusAnimator)
                  
                  let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                      switch state {
                      case .expanded:
                          self.visualEffectView.effect = UIBlurEffect(style: .dark)
                      case .collapsed:
                          self.visualEffectView.effect = nil
                      }
                  }
                  
                  blurAnimator.startAnimation()
                  runningAnimations.append(blurAnimator)
              }
          }
          
          func startInteractiveTransition_noti(state:CardState, duration:TimeInterval) {
              if runningAnimations.isEmpty {
                  animateTransitionIfNeeded(state: state, duration: duration)
              }
              for animator in runningAnimations {
                  animator.pauseAnimation()
                  animationProgressWhenInterrupted = animator.fractionComplete
              }
          }
          
          func updateInteractiveTransition_noti(fractionCompleted:CGFloat) {
              for animator in runningAnimations {
                  animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
              }
          }
          
          func continueInteractiveTransition_noti(){
              for animator in runningAnimations {
                  animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
              }
          }
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
        @IBOutlet weak var viewOntableView:UIView!
        @IBOutlet weak var tableView:UITableView!
        @IBOutlet weak var setDistance:UIButton!
        @IBOutlet weak var arrowDistance:UIImageView!
        @IBOutlet weak var distanceLabel:UILabel!
        @IBOutlet weak var distanceCollectionView:UICollectionView!
        
        
        
        
        
        ////////level label///////////////////////////////////////
        let levelLabel:UILabel = {
            let label = UILabel()
            label.text = "Lv.99"
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 32)
            return label
        }()
        
        //////// detail label///////////////////////////////////////
        let detailLabel:UILabel = {
            let label = UILabel()
            label.text = "แลกเหรียญค๊อกกี้"
            label.textAlignment = .center
            label.textColor = UIColor.orange
            label.font = UIFont.init(name: "Kanit", size: 15)
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            /////// table view//////
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.distanceCollectionView.delegate = self
            self.distanceCollectionView.dataSource = self
            
            
            
            
            
            /////circle progress Bar//////////////
            
            ////set background Progress Bar
            let shapeLayer = CAShapeLayer()
            
            let center = viewOntableView.center
            let circularPath = UIBezierPath(arcCenter: center, radius: 90, startAngle: -CGFloat.pi/2, endAngle:2*CGFloat.pi, clockwise: true)
            shapeLayer.path = circularPath.cgPath
            
            ///set Line Progress Bar
            shapeLayer.strokeColor = UIColor.orange.cgColor
            shapeLayer.lineWidth = 14
            shapeLayer.fillColor = UIColor.black.cgColor
            shapeLayer.lineCap = .round
            // shapeLayer.strokeStart = 0
            
            
            
            ////set animation Progress bar
            shapeLayer.strokeEnd = 0
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.toValue = 10
            basicAnimation.duration = 20
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            shapeLayer.add(basicAnimation, forKey: "urSoBasic")
            
            
            
            
            
            self.viewOntableView.layer.addSublayer(shapeLayer)
            shapeLayer.frame = CGRect(x: -0, y: -40, width: 100, height: 100)
            /////set level labe   l////////////////////////////
            self.viewOntableView.addSubview(levelLabel)
            levelLabel.frame = CGRect(x: 135, y:40, width: 100, height: 100)
            /////set detail label ////////////////////////////
            self.viewOntableView.addSubview(detailLabel)
            detailLabel.frame = CGRect(x: 125, y:60, width: 130, height: 130)
            
            /////set Distance //////////////////////////////////
            arrowDistance.image = UIImage(named: "back")
            self.distanceCollectionView.isHidden = true
            
            
            
            
            self.viewOntableView.addSubview(setDistance)
            self.viewOntableView.addSubview(arrowDistance)
            self.viewOntableView.addSubview(distanceLabel)
            self.viewOntableView.addSubview(distanceCollectionView)
            
            
            /////set up actionsheet////////////////////////////////
            setupCard()
            setupNotificationsCard()
            
            
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 1000
        }
        ///////distance collectionView  //////////////////////
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if(collectionView == distanceCollectionView){
                return 5
            }else{
                return 10
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "distanceCollectionViewCell", for: indexPath) as! distanceCollectionViewCell
            return cell
        }
        
        @IBAction func showAllDistanceClicked(_ sender: Any){
            if(distanceCollectionView.isHidden == true){
                arrowDistance.image = UIImage(named: "backConverse")
                distanceCollectionView.isHidden = false
            }else{
                arrowDistance.image = UIImage(named: "back")
                distanceCollectionView.isHidden = true
            }
        }
        
    
    
    
    ///////////////////// get data on firebase database////////////////////////////////////////////////////////////////////////////////////////////
    
  
    
    
    ///////Open Scan Qrcode page //////////////////////////////////////////////
    
    @IBAction func QrSacnClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "QrScanViewController") as! QrScanViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    ///////Open Search  page //////////////////////////////////////////////
    
    @IBAction func SearchClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func goToStore(_ sender:Any){
    let vc = storyboard?.instantiateViewController(withIdentifier: "StoreMainViewController") as! StoreMainViewController
        vc.storyBoardID_1 = "HomeViewController"
                        
    navigationController?.pushViewController(vc, animated: true)
    
}
    
    
    @IBAction func goToMyReward(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyRewardViewController") as! MyRewardViewController
          
                            
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
