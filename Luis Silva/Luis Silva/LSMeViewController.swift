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
    
    var vc1:UIViewController!
    var vc2:UIViewController!
    var vc3:UIViewController!
    var vc4:UIViewController!
    var vc5:UIViewController!
    
    var infos : LSInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("vc1") as! UIViewController
        vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("vc2") as! UIViewController
        vc3 = self.storyboard?.instantiateViewControllerWithIdentifier("vc3") as! UIViewController
        vc4 = self.storyboard?.instantiateViewControllerWithIdentifier("vc4") as! UIViewController
        vc5 = self.storyboard?.instantiateViewControllerWithIdentifier("vc5") as! UIViewController
        
        infos = LSInfo.init()
        
        NSLog("%@",infos.infoDict!)
        
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
        self.scrollView.frame = CGRectMake(60, UIScreen.mainScreen().bounds.height, self.scrollView.frame.width, self.scrollView.frame.height)
        self.scrollViewFirstExecAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : OptionCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Option", forIndexPath: indexPath) as? OptionCollectionViewCell
        
        cell.imageOption.image = UIImage(named: self.defineCollectionCellImage(indexPath.row))
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pageHeight : Float = Float(scrollView.frame.size.height)
        var fractionalPage : Float = Float(scrollView.contentOffset.y) / pageHeight
        var page : NSInteger = NSInteger(fractionalPage)
        if (previousPage != page) {
            changeBackgroundColorCollectionCell(page)
            NSLog("Previous %d", previousPage)
            NSLog("Current %d", page)

            previousPage = page
        }

    }
    
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

    
    func changeBackgroundColorCollectionCell(index: NSInteger){
        switch(index){
        case 0:
            self.changeCollectionColorAnimation(UIColor(red: 141/255.0, green: 91/255.0, blue: 245/255.0, alpha: 0.8))
            self.selectedCollectionCellImage(index)
        case 1:
            self.changeCollectionColorAnimation(UIColor(red: 94/255.0, green: 132/255.0, blue: 251/255.0, alpha: 0.8))
            self.selectedCollectionCellImage(index)
        case 2:
            self.changeCollectionColorAnimation(UIColor(red: 155/255.0, green: 231/255.0, blue: 217/255.0, alpha: 0.8))
            self.selectedCollectionCellImage(index)
        case 3:
            self.changeCollectionColorAnimation(UIColor(red: 238/255.0, green: 195/255.0, blue: 109/255.0, alpha: 0.8))
            self.selectedCollectionCellImage(index)
        case 4:
            self.changeCollectionColorAnimation(UIColor(red: 231/255.0, green: 145/255.0, blue: 120/255.0, alpha: 0.8))
            self.selectedCollectionCellImage(index)
        default: NSLog("Default Background Color")
        }
    }

    func scrollViewFirstExecAnimation(){
        let duration = 1.0
        UIView.animateWithDuration(duration, animations: {
            self.scrollView.frame = CGRectMake(60, 64, self.scrollView.frame.width, self.scrollView.frame.height)
        })
    }
    
    func changeCollectionColorAnimation(color : UIColor){
        let duration = 0.15
        UIView.animateWithDuration(duration, animations: {
            self.optionsCollectionView.backgroundColor = color
        })
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
}