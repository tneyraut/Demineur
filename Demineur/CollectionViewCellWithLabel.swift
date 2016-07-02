//
//  CollectionViewCellWithLabel.swift
//  BrainFuck
//
//  Created by Thomas Mac on 16/06/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class CollectionViewCellWithLabel: UICollectionViewCell {
 
    internal let titleLabel = UILabel()
    
    internal let imageView = UIImageView()
    
    internal var indiceCellGauche = -1
    internal var indiceCellDroite = -1
    internal var indiceCellHaut = -1
    internal var indiceCellBas = -1
    internal var indiceCellHautGauche = -1
    internal var indiceCellHautDroite = -1
    internal var indiceCellBasGauche = -1
    internal var indiceCellBasDroite = -1
    
    private var minePresente = false
    
    private var decouvert = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)
        self.imageView.image = UIImage(named:NSLocalizedString("ICON_RED_FLAG", comment:""))
        self.imageView.hidden = true
        self.addSubview(self.imageView)
        
        self.titleLabel.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        self.titleLabel.shadowOffset = CGSizeMake(0, 1)
        self.titleLabel.textColor = UIColor.blackColor()
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.text = ""
        var size = self.frame.size.width
        if (size > self.frame.size.height)
        {
            size = self.frame.size.height
        }
        self.titleLabel.font = UIFont(name:"HelveticaNeue-CondensedBlack", size:size/3)
        self.titleLabel.hidden = true
        self.addSubview(self.titleLabel)
        
        self.backgroundColor = UIColor.blackColor()
        
        self.layer.borderColor = UIColor(red:213.0/255.0, green:210.0/255.0, blue:199.0/255.0, alpha:1.0).CGColor
        
        self.layer.borderWidth = 2.5
        self.layer.cornerRadius = 7.5
        self.layer.shadowOffset = CGSizeMake(0, 1)
        self.layer.shadowColor = UIColor.lightGrayColor().CGColor
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
    
    internal func setAllIndiceNeighbourForCellAtIndex(index: Int, longueurTerrain: Int, largeurTerrain: Int)
    {
        if (index < longueurTerrain * largeurTerrain - longueurTerrain)
        {
            self.indiceCellBas = index + longueurTerrain
        }
        if (index >= longueurTerrain)
        {
            self.indiceCellHaut = index - longueurTerrain
        }
        if ((index + 1) % longueurTerrain != 0)
        {
            self.indiceCellDroite = index + 1
        }
        if (index % longueurTerrain != 0)
        {
            self.indiceCellGauche = index - 1
        }
        if (index >= longueurTerrain && index % longueurTerrain != 0)
        {
            self.indiceCellHautGauche = index - longueurTerrain - 1
        }
        if (index >= longueurTerrain && (index + 1) % longueurTerrain != 0)
        {
            self.indiceCellHautDroite = index - longueurTerrain + 1
        }
        if (index < longueurTerrain * largeurTerrain - longueurTerrain && index % longueurTerrain != 0)
        {
            self.indiceCellBasGauche = index + longueurTerrain - 1
        }
        if (index < longueurTerrain * largeurTerrain - longueurTerrain && (index + 1) % longueurTerrain != 0)
        {
            self.indiceCellBasDroite = index + longueurTerrain + 1
        }
    }
    
    internal func setMinePresente()
    {
        self.minePresente = true
    }
    
    internal func isMinePresente() -> Bool
    {
        return self.minePresente
    }
    
    internal func setDecouvert()
    {
        self.decouvert = true
        self.titleLabel.hidden = false
        self.backgroundColor = UIColor.whiteColor()
    }
    
    internal func isDecouvert() -> Bool
    {
        return self.decouvert
    }
    
}
