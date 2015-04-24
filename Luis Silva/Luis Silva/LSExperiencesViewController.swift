//
//  LSExperiencesViewController.swift
//  Luis Silva
//
//  Created by Luis Filipe Campani on 4/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

import UIKit

class LSExperiencesViewController: UIViewController {

    @IBOutlet weak var firstExperienceLabel: UILabel!
    @IBOutlet weak var firstExperienceDescriptionLabel: UILabel!
    @IBOutlet weak var firstExperienceDurationLabel: UILabel!
    
    @IBOutlet weak var secondExperienceLabel: UILabel!
    @IBOutlet weak var secondExperienceDescriptionLabel: UILabel!
    @IBOutlet weak var secondExperienceDurationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
