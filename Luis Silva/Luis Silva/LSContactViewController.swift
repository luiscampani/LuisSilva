//
//  LSContactViewController.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

class LSContactViewController: UIViewController {
    
    @IBOutlet weak var gitImage: UIImageView!
    @IBOutlet weak var linkedinImage: UIImageView!
    @IBOutlet weak var faceImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var clickGitImage = UITapGestureRecognizer(target:self ,action:Selector("gitImageTapped:"))
        self.gitImage.addGestureRecognizer(clickGitImage)
        
        var clickLinkedinImage = UITapGestureRecognizer(target:self ,action:Selector("linkedinImageTapped:"))
        self.linkedinImage.addGestureRecognizer(clickLinkedinImage)
        
        var clickFaceImage = UITapGestureRecognizer(target:self ,action:Selector("faceImageTapped:"))
        self.faceImage.addGestureRecognizer(clickFaceImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Tap Gesture Recognizer Methods
    
    func gitImageTapped(img: AnyObject)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/luiscampani")!)
    }
    
    func linkedinImageTapped(img: AnyObject)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://br.linkedin.com/in/luisfilipecampani")!)
    }
    
    func faceImageTapped(img: AnyObject)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/luisfilipe.campani")!)
    }

}
