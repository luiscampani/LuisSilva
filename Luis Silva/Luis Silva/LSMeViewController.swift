//
//  LSMeViewController.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/14/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

class LSMeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var vc1:UIViewController!
    var vc2:UIViewController!
    var vc3:UIViewController!
    var vc4:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        vc1 = self.storyboard?.instantiateViewControllerWithIdentifier("vc1") as! UIViewController
        vc2 = self.storyboard?.instantiateViewControllerWithIdentifier("vc2") as! UIViewController
        vc3 = self.storyboard?.instantiateViewControllerWithIdentifier("vc3") as! UIViewController
        vc4 = self.storyboard?.instantiateViewControllerWithIdentifier("vc4") as! UIViewController
    }
    
    
    override func viewDidLayoutSubviews() {
        
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
        
        cell.text.text = "Teste"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.swapScrollViews(indexPath.row)
    }
    
    func swapScrollViews(index : Int){
        switch(index){
        case 0:
            vc1.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            vc2.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            
            self.scrollView.addSubview(vc1.view)
            self.scrollView.addSubview(vc2.view)
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*2)
        case 1:
            vc3.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            vc4.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            
            self.scrollView.addSubview(vc3.view)
            self.scrollView.addSubview(vc4.view)
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*2)
        case 2:
            vc1.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            vc2.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            
            self.scrollView.addSubview(vc1.view)
            self.scrollView.addSubview(vc2.view)
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*2)
        case 3:
            vc3.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            vc4.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
            
            self.scrollView.addSubview(vc3.view)
            self.scrollView.addSubview(vc4.view)
        
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*2)
        default: NSLog("Caiu no default")
        }
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
