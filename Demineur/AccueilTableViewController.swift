//
//  AccueilTableViewController.swift
//  Demineur
//
//  Created by Thomas Mac on 01/07/2016.
//  Copyright © 2016 ThomasNeyraut. All rights reserved.
//

import UIKit

class AccueilTableViewController: UITableViewController {

    private let itemsArray: NSArray = ["Longueur : ", "Largeur : ", "Nombre de mines : "]
    
    private let imagesArray: NSArray = [NSLocalizedString("ICON_MESURE", comment:""), NSLocalizedString("ICON_MESURE", comment:""), NSLocalizedString("ICON_MINE", comment:"")]
    
    private var longueur = 5
    
    private var largeur = 5
    
    private var nombreDeMines = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.tableView.registerClass(TableViewCellWithStepper.classForCoder(), forCellReuseIdentifier:"cell")
        
        self.title = "Démineur : Menu Principal"
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        let buttonPrevious = UIBarButtonItem(title:"Retour", style:UIBarButtonItemStyle.Done, target:nil, action:nil)
        buttonPrevious.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        self.navigationItem.backBarButtonItem = buttonPrevious
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated:true)
        
        self.navigationController?.toolbar.barTintColor = UIColor(red:0.439, green:0.776, blue:0.737, alpha:1)
        
        let shadow = NSShadow()
        
        shadow.shadowColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.8)
        
        shadow.shadowOffset = CGSizeMake(0, 1)
        
        let playButton = UIBarButtonItem(title:"Play", style:.Plain, target:self, action:#selector(self.playButtonActionListener))
        
        playButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red:245.0/255.0, green:245.0/255.0, blue:245.0/255.0, alpha:1.0), NSShadowAttributeName: shadow, NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size:21.0)!], forState:UIControlState.Normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil)
        
        self.navigationController?.toolbar.setItems([flexibleSpace, playButton, flexibleSpace], animated:true)
        
        super.viewDidAppear(animated)
    }
    
    @objc private func playButtonActionListener()
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let gameCollectionViewController = GameCollectionViewController(collectionViewLayout:layout)
        
        gameCollectionViewController.nombreDeMines = self.nombreDeMines
        gameCollectionViewController.longueur = self.longueur
        gameCollectionViewController.largeur = self.largeur
        
        self.navigationController?.pushViewController(gameCollectionViewController, animated:true)
    }
    
    @objc private func stepperLongueurActionListener(sender: UIStepper)
    {
        self.longueur = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc private func stepperLargeurActionListener(sender: UIStepper)
    {
        self.largeur = Int(sender.value)
        self.tableView.reloadData()
    }
    
    @objc private func stepperNombreMinesActionListener(sender: UIStepper)
    {
        self.nombreDeMines = Int(sender.value)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.itemsArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCellWithStepper

        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.imageView?.image = UIImage(named:String(self.imagesArray[indexPath.row]))
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        
        if (indexPath.row == 0)
        {
            cell.textLabel?.text = String(self.itemsArray[indexPath.row]) + String(self.longueur)
            cell.stepper.minimumValue = 2
            cell.stepper.maximumValue = 10
            cell.stepper.value = Double(self.longueur)
            cell.stepper.addTarget(self, action:#selector(self.stepperLongueurActionListener(_:)), forControlEvents:.TouchUpInside)
        }
        else if (indexPath.row == 1)
        {
            cell.textLabel?.text = String(self.itemsArray[indexPath.row]) + String(self.largeur)
            cell.stepper.minimumValue = 2
            cell.stepper.maximumValue = 10
            cell.stepper.value = Double(self.largeur)
            cell.stepper.addTarget(self, action:#selector(self.stepperLargeurActionListener(_:)), forControlEvents:.TouchUpInside)
        }
        else if (indexPath.row == 2)
        {
            cell.stepper.minimumValue = 1
            cell.stepper.maximumValue = Double(self.longueur * self.largeur) - 1
            if (self.nombreDeMines > self.longueur * self.largeur - 1)
            {
                self.nombreDeMines = self.longueur * self.largeur - 1
            }
            cell.stepper.value = Double(self.nombreDeMines)
            cell.stepper.addTarget(self, action:#selector(self.stepperNombreMinesActionListener(_:)), forControlEvents:.TouchUpInside)
            cell.textLabel?.text = String(self.itemsArray[indexPath.row]) + String(self.nombreDeMines)
        }
        return cell
    }

}
