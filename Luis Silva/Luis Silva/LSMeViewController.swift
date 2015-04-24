//
//  LSMeViewController.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/14/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

var previousPage : NSInteger = 0
var currentPage : NSInteger = 0

class LSMeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var about : LSAboutMeViewController!
    var school : LSSchoolViewController!
    var skills : LSSkillsViewController!
    var experiences : LSExperiencesViewController!
    var cloud : LSProjectsViewController!
    var notification : LSProjectsViewController!
    var day : LSProjectsViewController!
    var contact : LSContactViewController!
    
    var infosDict : LSMeInfo!
    
    // MARK: - ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        about = self.storyboard?.instantiateViewControllerWithIdentifier("about") as! LSAboutMeViewController
        school = self.storyboard?.instantiateViewControllerWithIdentifier("school") as! LSSchoolViewController
        skills = self.storyboard?.instantiateViewControllerWithIdentifier("skills") as! LSSkillsViewController
        experiences = self.storyboard?.instantiateViewControllerWithIdentifier("experiences") as! LSExperiencesViewController
        cloud = self.storyboard?.instantiateViewControllerWithIdentifier("day") as! LSProjectsViewController
        notification = self.storyboard?.instantiateViewControllerWithIdentifier("day") as! LSProjectsViewController
        day = self.storyboard?.instantiateViewControllerWithIdentifier("day") as! LSProjectsViewController
        contact = self.storyboard?.instantiateViewControllerWithIdentifier("contact") as! LSContactViewController
        
        infosDict = LSMeInfo()
    }
    
    override func viewDidLayoutSubviews() {
        about.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        school.view.frame = CGRectMake(0, self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        skills.view.frame = CGRectMake(0, self.scrollView.frame.size.height*2, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        experiences.view.frame = CGRectMake(0, self.scrollView.frame.size.height*3, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        cloud.view.frame = CGRectMake(0, self.scrollView.frame.size.height*4, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        notification.view.frame = CGRectMake(0, self.scrollView.frame.size.height*5, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        day.view.frame = CGRectMake(0, self.scrollView.frame.size.height*6, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        contact.view.frame = CGRectMake(0, self.scrollView.frame.size.height*7, self.scrollView.frame.size.width, self.scrollView.frame.size.height)
        
        self.scrollView.addSubview(about.view)
        self.scrollView.addSubview(school.view)
        self.scrollView.addSubview(skills.view)
        self.scrollView.addSubview(experiences.view)
        self.scrollView.addSubview(cloud.view)
        self.scrollView.addSubview(notification.view)
        self.scrollView.addSubview(day.view)
        self.scrollView.addSubview(contact.view)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height*8)
    }
    
    override func viewDidAppear(animated: Bool){
        self.scrollView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height, self.scrollView.frame.width, self.scrollView.frame.height)
        self.scrollViewFirstExecAnimation()
        self.loadAboutMeInfo()
        self.loadSchoolInfo()
        self.loadSkillsInfo()
        self.loadExperienceInfo()
        self.loadProjectsInfo()
        self.loadContactInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectiovView DelegateDataSource Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell : LSOptionCollectionViewCell! = collectionView.dequeueReusableCellWithReuseIdentifier("Option", forIndexPath: indexPath) as? LSOptionCollectionViewCell
        if(indexPath.row > 0){
            cell.imageOption.image = UIImage(named: self.defineCollectionCellImage(indexPath.row))
        }
        else{
            cell.imageOption.image = UIImage(named:"About Me Select")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var itemRow : CGFloat = CGFloat(indexPath.row)
        previousPage = currentPage
        currentPage = indexPath.row
        self.scrollView.setContentOffset(CGPointMake(0, self.scrollView.frame.size.height*itemRow), animated: true)
        self.changeSelectedCollectionCellImage(indexPath.row)
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
    
    // MARK: - CellCollectionView Methods
    
    func defineCollectionCellImage(index: Int) -> String{
        switch(index){
            case 0: return "About Me"
            case 1: return "Education"
            case 2: return "Skills"
            case 3: return "Experience"
            case 4: return "Cloud"
            case 5: return "Notification"
            case 6: return "Day"
            case 7: return "Contact"
            default: return ""
        }
    }
    
    func changeSelectedCollectionCellImage(index: Int){
        var indexPathNewImage : NSIndexPath = NSIndexPath(forItem: index, inSection: 0)
        var indexPathOldImage : NSIndexPath = NSIndexPath(forItem: previousPage, inSection: 0)
        var cellNewImage : LSOptionCollectionViewCell = self.optionsCollectionView.cellForItemAtIndexPath(indexPathNewImage) as! LSOptionCollectionViewCell
        var cellOldImage : LSOptionCollectionViewCell = self.optionsCollectionView.cellForItemAtIndexPath(indexPathOldImage) as! LSOptionCollectionViewCell
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
            cellNewImage.imageOption.image = UIImage(named: "Cloud Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 5:
            cellNewImage.imageOption.image = UIImage(named: "Notification Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 6:
            cellNewImage.imageOption.image = UIImage(named: "Day Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        case 7:
            cellNewImage.imageOption.image = UIImage(named: "Contact Select")
            cellOldImage.imageOption.image = UIImage(named: defineCollectionCellImage(previousPage))
        default: println()
        }
    }
    
    // MARK: - ScrollView DelegateDataSource Methods
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pageHeight : Float = Float(scrollView.frame.size.height)
        var fractionalPage : Float = Float(scrollView.contentOffset.y) / pageHeight
        currentPage = NSInteger(fractionalPage)
        if (previousPage != currentPage) {
            self.changeSelectedCollectionCellImage(currentPage)
            previousPage = currentPage
        }
        
    }
    
    // MARK: - Animation Methods
    
    func scrollViewFirstExecAnimation(){
        let duration = 0.5
        UIView.animateWithDuration(duration, animations: {
            self.scrollView.frame = CGRectMake(0, 0, self.scrollView.frame.width, self.scrollView.frame.height)
        })
    }
    
    // MARK: - LoadInfo Methods
    
    func loadAboutMeInfo(){
        about.aboutMeImage.image = UIImage(named: "Photo")
        about.aboutMeTextField.text = infosDict.infoDict.valueForKey("About") as! String
    }
    
    func loadSchoolInfo(){
        var infoSchool : NSDictionary = infosDict.infoDict.valueForKey("Education") as! NSDictionary
        school.schoolLabel.text = infoSchool.valueForKey("school") as? String
        school.bachelorLabel.text = infoSchool.valueForKey("info") as? String
        school.periodLabel.text = infoSchool.valueForKey("period") as? String
    }
    
    func loadSkillsInfo(){
        var infoSkill : NSDictionary = infosDict.infoDict.valueForKey("Knowledges") as! NSDictionary
        skills.languagesLabel.text = infoSkill.valueForKey("languages") as? String
        skills.databaseLabel.text = infoSkill.valueForKey("database") as? String
        skills.protocolsLabel.text = infoSkill.valueForKey("protocols") as? String
        skills.agileLabel.text = infoSkill.valueForKey("agile") as? String
    }
    
    func loadExperienceInfo(){
        var infoExperience : NSArray = infosDict.infoDict.valueForKey("Experiences") as! NSArray
        experiences.firstExperienceLabel.text = infoExperience.objectAtIndex(0).valueForKey("job") as? String
        experiences.firstExperienceDurationLabel.text = infoExperience.objectAtIndex(0).valueForKey("duration") as? String
        experiences.firstExperienceDescriptionLabel.text = infoExperience.objectAtIndex(0).valueForKey("description") as? String
        experiences.secondExperienceLabel.text = infoExperience.objectAtIndex(1).valueForKey("job") as? String
        experiences.secondExperienceDurationLabel.text = infoExperience.objectAtIndex(1).valueForKey("duration") as? String
        experiences.secondExperienceDescriptionLabel.text = infoExperience.objectAtIndex(1).valueForKey("description") as? String
    }
    
    func loadProjectsInfo(){
        var infoProjects : NSDictionary = infosDict.infoDict.valueForKey("Projects") as! NSDictionary
        for(key,value) in infoProjects{
            if(key.isEqual("n3phele")){
                cloud.projectLabel.text = key as? String
                cloud.projectTextView.text = value as? String
                cloud.view.backgroundColor = UIColor(red: 201/255.0, green: 68/255.0, blue: 40/255.0, alpha: 1.0)
            }
            else if(key.isEqual("Push Notifications")){
                notification.projectLabel.text = key as? String
                notification.projectTextView.text = value as? String
                notification.view.backgroundColor = UIColor(red: 151/255.0, green: 29/255.0, blue: 62/255.0, alpha: 1.0)
            }
            else{
                day.projectLabel.text = key as? String
                day.projectTextView.text = value as? String
            }
        }
    }
    
    func loadContactInfo(){
        contact.gitImage.image = UIImage(named:"GitHub")
        contact.linkedinImage.image = UIImage(named: "LinkedIn")
        contact.faceImage.image = UIImage(named: "Facebook")
        
        contact.emailLabel.text = infosDict.infoDict.valueForKey("Email") as? String
        contact.phoneLabel.text = infosDict.infoDict.valueForKey("Phone") as? String
        
        
    }
    
    
    

}