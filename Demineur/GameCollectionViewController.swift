//
//  GameCollectionViewController.swift
//  Demineur
//
//  Created by Thomas Mac on 01/07/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GameCollectionViewController: UICollectionViewController {

    internal var nombreDeMines = 0
    
    internal var longueur = 0
    
    internal var largeur = 0
    
    private var modeMarquer = false
    
    private var tempsEcoule = 0.0
    
    private var timer = NSTimer()
    
    internal var accueilTableViewController = AccueilTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Démineur"
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        self.collectionView?.scrollEnabled = false
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        let buttonMarquer = UIBarButtonItem(title:"Marquer", style:UIBarButtonItemStyle.Done, target:self, action:#selector(self.buttonMarquerActionListener))
        buttonMarquer.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItem = buttonMarquer
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(CollectionViewCellWithLabel.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated:true)
        
        self.setAllMines()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:#selector(self.time), userInfo:nil, repeats:true)
        
        super.viewDidAppear(animated)
    }
    
    @objc private func time()
    {
        self.tempsEcoule += 0.1
    }
    
    @objc private func buttonMarquerActionListener()
    {
        self.modeMarquer = !self.modeMarquer
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        if (self.modeMarquer)
        {
            self.navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.greenColor(), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        }
    }

    private func setAllMines()
    {
        var i = 0
        while (i < self.nombreDeMines)
        {
            var indice = Int(arc4random_uniform(UInt32(self.longueur * self.largeur)))
            var cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:indice, inSection:0)) as! CollectionViewCellWithLabel
            while (cell.isMinePresente())
            {
                indice = Int(arc4random_uniform(UInt32(self.longueur * self.largeur)))
                cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:indice, inSection:0)) as! CollectionViewCellWithLabel
            }
            cell.setMinePresente()
            i += 1
        }
        self.setAllIndication()
    }
    
    private func setAllIndication()
    {
        var i = 0
        while (i < self.collectionView?.numberOfItemsInSection(0))
        {
            var indication = 0
            let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:i, inSection:0)) as! CollectionViewCellWithLabel
            if (!cell.isMinePresente())
            {
                if (cell.indiceCellHaut != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellHaut, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellBas != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellBas, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellDroite != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellDroite, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellGauche != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellGauche, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellHautDroite != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellHautDroite, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellHautGauche != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellHautGauche, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellBasDroite != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellBasDroite, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                if (cell.indiceCellBasGauche != -1 && (self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:cell.indiceCellBasGauche, inSection:0)) as! CollectionViewCellWithLabel).isMinePresente())
                {
                    indication += 1
                }
                cell.titleLabel.text = String(indication)
            }
            i += 1
        }
    }
    
    private func allCellWithoutMineAreDiscovered() -> Bool
    {
        var i = 0
        while (i < self.collectionView?.numberOfItemsInSection(0))
        {
            let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forRow:i, inSection:0)) as! CollectionViewCellWithLabel
            if (!cell.isMinePresente() && !cell.isDecouvert())
            {
                return false
            }
            i += 1
        }
        return true
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.longueur * self.largeur
    }

    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.view.frame.size.width / CGFloat(self.longueur), (self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - 30.0) / CGFloat(self.largeur))
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCellWithLabel
    
        cell.setAllIndiceNeighbourForCellAtIndex(indexPath.row, longueurTerrain:self.longueur, largeurTerrain:self.largeur)
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCellWithLabel
        if (cell.isDecouvert())
        {
            return
        }
        if (self.modeMarquer)
        {
            cell.imageView.hidden = !cell.imageView.hidden
            return
        }
        
        cell.setDecouvert()
        
        if (cell.isMinePresente())
        {
            self.timer.invalidate()
            
            cell.imageView.image = UIImage(named:NSLocalizedString("ICON_EXPLOSION", comment:""))
            cell.imageView.hidden = false
            
            let alertController = UIAlertController(title:"Défaite", message:"Vous avez sauté !", preferredStyle:.Alert)
            
            let alertAction = UIAlertAction(title:"OK", style:.Default) { (_) in self.navigationController?.popViewControllerAnimated(true) }
            
            alertController.addAction(alertAction)
            
            self.presentViewController(alertController, animated:true, completion:nil)
        }
        else if (self.allCellWithoutMineAreDiscovered())
        {
            self.timer.invalidate()
            
            let alertController = UIAlertController(title:"Victoire", message:"Vous avez réussi ! Vous avez déminé en " + String(self.tempsEcoule) + "s.", preferredStyle:.Alert)
            
            let alertAction = UIAlertAction(title:"OK", style:.Default) { (_) in
                self.accueilTableViewController.gameSucceed(String(self.longueur) + "x" + String(self.largeur) + "_" + String(self.nombreDeMines), score:self.tempsEcoule)
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            alertController.addAction(alertAction)
            
            self.presentViewController(alertController, animated:true, completion:nil)
        }
    }
    
}
