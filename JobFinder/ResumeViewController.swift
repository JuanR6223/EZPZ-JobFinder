//
//  ResumeViewController.swift
//  JobFinder
//
//  Created by Student on 12/15/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SafariServices

class ResumeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func howToResumeButtonPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://resumegenius.com/blog/resume-help/how-to-write-a-resume")!)
        present(vc, animated: true)
}
    @IBAction func hsStudentTemplateButtonPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.thebalancecareers.com/high-school-resume-template-2063264")!)
        present(vc, animated: true)
         }
    
    @IBAction func hsWorkbootButtonPressed(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "http://www.bths.edu/intern/DOCS/Preparing_a_HS_Resume.pdf")!)
        present(vc, animated: true)
    }
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
