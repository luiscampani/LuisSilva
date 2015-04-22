//
//  LSMeViewController.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/14/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

var previousPage : NSInteger = 0

class LSMeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var vc1:AboutMeViewController!
    var vc2:SchoolViewController!
    var vc3:UIViewController!
    var vc4:UIViewController!
    var vc5:ContactViewController!
    
    var infosDict : NSDictionary!
    
    // MARK: -ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("vc1") as! AboutMeViewController
        vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("vc2") as! SchoolViewController
        vc3 = self.storyboard?.instantiateViewControllerWithIdentifier("vc3") as! UIViewController
        vc4 = self.storyboard?.instantiateViewControllerWithIdentifier("vc4") as! UIViewController
        vc5 = self.storyboard?.instantiateViewControllerWithIdentifier("vc5") as! ContactViewController
        
        if let path = NSBundle.mainBundle().pathForResource("LuisInfo", ofType: "plist") {
            infosDict = NSDictionary(contentsOfFile: path)!
        }
    }
    
    override func viewDidLayoutSubviews() {
        vc1.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        vc2.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        vc3.view.frame = CGRectMake(0, self.scrollView.frame.size.height*2, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        vc4.view.frame = CGRectMake(0, self.scrollView.frame.size.height*3, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        vc5.view.frame = CGRectMake(0, self.scrollView.frame.size.height*4, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        
        self.scrollView.addSubview(vc1.view)
        self.scrollView.addSubview(vc2.view)
        self.scrollView.addSubview(vc3.view)
        self.scrollView.addSubview(vc4.view)
        self.scrollView.addSubview(vc5.view)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*5)
    }
    
    override func viewDidAppear(animated: Bool){
        self.scrollView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height, self.scrollView.frame.width, self.scrollView.frame.height)
        self.scrollViewFirstExecAnimation()
        self.loadAboutMeInfo()
        self.loadSchoolInfo()
        self.loadContactInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -CollectiovView DelegateDataSource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : OptionCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Option", forIndexPath: indexPath) as? OptionCollectionViewCell
        if(indexPath.row > 0){
            NSLog("%d", indexPath.row)
            cell.imageOption.image = UIImage(named: self.defineCollectionCellImage(indexPath.row))
        }
        else{
            cell.imageOption.image = UIImage(named:"About Me Select")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var cellCount : Int = self.optionsCollectionView.numberOfItemsInSection(section)
        if (cellCount > 0){
            var clFlow: UICollectionViewFlowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            var cellHeight : CGFloat = (clFlow.itemSize.height + clFlow.minimumInteritemSpacing) as CGFloat
            var totalCellHeight : CGFloat = cellHeight * CGFloat(cellCount)
            var contentHeight : CGFloat = self.optionsCollectionView.frame.size.height - self.optionsCollectionView.contentInset.top - self.optionsCollectionView.contentInset.bottom
            
            if(totalCellHeight<contentHeight){
                var padding : CGFloat = (contentHeight - totalCellHeight) / 2.0
                return UIEdgeInsetsMake(padding, 0, padding, 0)
            }
        }
        return UIEdgeInsetsZero
    }
    
    // MARK: -CellCollectionView Methods
    
    func defineCollectionCellImage(index: Int) -> String{
        switch(index){
            case 0: return "About Me"
            case 1: return "Education"
            case 2: return "Skills"
            case 3: return "Experience"
            case 4: return "Contact"
            default: return ""
        }
    }
    
    func selectedCollectionCellImage(index: Int){
        var indexPathNewImage : NSIndexPath = NSIndexPath(forItem: index, inSection: 0)
        var indexPathOldImage : NSIndexPath = NSIndexPath(forItem: previousPage, inSection: 0)
        var cellNewImage : OptionCollectionViewCell = self.optionsCollectionView.cellForItemAtIndexPath(indexPathNewImage) as! OptionCollectionViewCell
        var cellOldImage : OptionCollectionViewCell = self.optionsCollectionView.cellForItemAtIndexPath(indexPathOldImage) as! OptionCollectionViewCell
        switch(index){
        case 0:
            cellNewImage.imageOption.image = UIImage(named: "About Me Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 1:
            cellNewImage.imageOption.image = UIImage(named: "Education Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 2:
            cellNewImage.imageOption.image = UIImage(named: "Skills Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 3:
            cellNewImage.imageOption.image = UIImage(named: "Experience Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 4:
            cellNewImage.imageOption.image = UIImage(named: "Contact Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        default: NSLog("Default - selectedCollectionCellImage")
        }
    }
    
    // MARK: -ScrollView DelegateDataSource Methods
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pageHeight : Float = Float(scrollView.frame.size.height)
        var fractionalPage : Float = Float(scrollView.contentOffset.y) / pageHeight
        var page : NSInteger = NSInteger(fractionalPage)
        if (previousPage != page) {
            selectedCollectionCellImage(page)
            previousPage = page
        }
        
    }
    
    
    // MARK: -Animation Methods
    
    func scrollViewFirstExecAnimation(){
        let duration = 0.5
        UIView.animateWithDuration(duration, animations: {
            self.scrollView.frame = CGRectMake(0, 0, self.scrollView.frame.width, self.scrollView.frame.height)
        })
    }
    
    // MARK: -LoadInfo Methods
    func loadAboutMeInfo(){
        vc1.aboutMeImage.image = UIImage(named: "Photo")
        vc1.aboutMeTextField.text = infosDict.valueForKey("About") as! String
    }
    
    func loadContactInfo(){
        vc5.gitImage.image = UIImage(named:"GitHub")
        vc5.linkedinImage.image = UIImage(named: "LinkedIn")
        vc5.faceImage.image = UIImage(named: "Facebook")
        
        vc5.emailLabel.text = infosDict.valueForKey("Email") as? String
        vc5.phoneLabel.text = infosDict.valueForKey("Phone") as? String
        
    }

    func loadSchoolInfo(){
        var infoSchool : NSDictionary = infosDict.valueForKey("Education") as! NSDictionary
        vc2.schoolLabel.text = infoSchool.valueForKey("school") as? String
        vc2.bachelorLabel.text = infoSchool.valueForKey("info") as? String
        vc2.periodLabel.text = infoSchool.valueForKey("period") as? String
    }

}