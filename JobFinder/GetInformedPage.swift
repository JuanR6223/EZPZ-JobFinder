//
//  Involved_screen.swift
//  JobFinder
//
//  Created by Apple on 7/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SafariServices

class GetInformedPage: UIViewController {

    @IBOutlet weak var organizationCollectionView: UICollectionView!
    
    var organizations = ["AfterSchoolMatters", "CatholicCharities", "JobCorps", "AdlerPlanetarium", "AlternativeInc", "ChicagoYouthCenters", "AmeriCorps", "ChicagoYouthProgramsInc"]
    
    var AboutUsLink = ["https://www.afterschoolmatters.org/about-us/", "https://www.catholiccharities.net/AboutUs.aspx", "https://www.dol.gov/agencies/eta/about/mission", "https://www.adlerplanetarium.org/explore/about-us/adler-mission/", "https://www.alternativesyouth.org/about/", "https://www.chicagoyouthcenters.org/mission", "https://americorps.gov/about", "https://chicagoyouthprograms.org/"]
    var AboutUsText = ["After School Matters provides Chicago teens the opportunity to explore their passions and develop their talents through world-class after-school and summer programs across Chicago.", "Catholic Charities fulfills the Church's role in the mission of charity to anyone in need by providing compassionate, competent and professional services that strengthen and support individuals, families and communities based on the value and dignity of human life.", "The mission of the Employment and Training Administration is to contribute to the more efficient functioning of the U.S. labor market by providing high-quality job training, employment, labor market information, and income maintenance services primarily through state and local workforce development systems.", "The Adler connects people, communities, and institutions to one another through the wonder of space science so we can explore our universe together and use our collective knowledge and skills to create a better world for everyone.", "Alternatives, Inc. supports and empowers Chicago youth to build safer and more vibrant communities through a combination of youth development programs and behavioral health services. Alternatives is a comprehensive, multi-cultural youth development organization that operates as a support system for Chicago’s youth and their families.", "Chicago Youth Centers’ mission is to invest in youth in under-served communities to help them discover and realize their full potential.", "For decades, we have worked to make service to others an indispensable part of the American experience. Through our nation's most trying times, AmeriCorps has come together to help those in need.", "Chicago Youth Programs believes in the pursuit of equity and access on behalf of each of our youth. We are reminded everyday how vital it is for young people of color to be allowed to participate and have learned that this participation must come in the form of equitable access to:  Quality education, comprehensive healthcare, skill development, and career opportunity."]
       
    var ApplicationPeriodSpringText = ["Jan 18 - Mar 26", "Year Round", "Always Avaliable", "No Spring Program Offered", "Always Available", "Always Available", "Always Available", "Always Available"]
       
    var ApplicationPeriodSummerText = ["Opens Mid-March", "Year Round", "Application Always Avaliable", "Summer Program App Opens in Spring", "Always Available", "Always Available", "Always Available", "Always Available"]
       
    var ApplicationPeriodFallText = ["Opens Late November", "Year Round", "Always Avaliable", "No Fall Program Offered", "Always Available", "Always Available", "Always Available", "Always Available"]
    
    var SpringAplicationUrlText = ["https://www.afterschoolmatters.org/teens/apply/", "https://www.ccofchicagovolunteer.com/", "https://www.jobcorps.gov/train", "https://www.adlerplanetarium.org/learn/teens/teen-opportunities/", "https://www.alternativesyouth.org/get-involved/volunteer/", "https://www.chicagoyouthcenters.org/volunteer", "https://www.nationalservice.gov/programs/americorps/join-americorps", "https://chicagoyouthprograms.org/external-engagement/"]
    
    var SummerApplicationUrlText = ["https://www.afterschoolmatters.org/teens/apply/", "https://www.ccofchicagovolunteer.com/", "https://www.jobcorps.gov/train", "https://www.adlerplanetarium.org/learn/teens/teen-opportunities/", "https://www.alternativesyouth.org/get-involved/volunteer/", "https://www.chicagoyouthcenters.org/volunteer", "https://www.nationalservice.gov/programs/americorps/join-americorps", "https://chicagoyouthprograms.org/external-engagement/"]
    
    var FallApplicationUrlText = ["https://www.afterschoolmatters.org/teens/apply/", "https://www.ccofchicagovolunteer.com/", "https://www.jobcorps.gov/train", "https://www.adlerplanetarium.org/learn/teens/teen-opportunities/", "https://www.alternativesyouth.org/get-involved/volunteer/", "https://www.chicagoyouthcenters.org/volunteer", "https://www.nationalservice.gov/programs/americorps/join-americorps", "https://chicagoyouthprograms.org/external-engagement/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //organizations = fetchData()
        
        organizationCollectionView.delegate = self
        organizationCollectionView.dataSource = self
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "programsSegue" {
//            if let dest = segue.destination as? AfterSchoolMattersTableViewController {
//                if let index = organizationCollectionView.indexPathsForSelectedItems?.first {
//                    dest.org = organizations[index.row].Orgimage
//                    print(index.row)
//                    print(organizations[index.row])
//                }
//            }
//        }
//    }
}

//Setting Up CollectionView

extension GetInformedPage: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "organizationsCell", for: indexPath) as! OrganizationsCollectionViewCell
            let organization = organizations[indexPath.row]
            cell.organizationImageView.image = UIImage(named: organization)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return organizations.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! OrganizationsDetailTableViewController
        if let indexPaths = organizationCollectionView.indexPathsForSelectedItems {
            if let indexPath = indexPaths.first {
                dvc.org = organizations[indexPath.row]
                dvc.aboutUs = AboutUsText[indexPath.row]
                dvc.aboutUsURL = AboutUsLink[indexPath.row]
                dvc.springApplication = ApplicationPeriodSpringText[indexPath.row]
                dvc.summerApplication = ApplicationPeriodSummerText[indexPath.row]
                dvc.fallApplication = ApplicationPeriodFallText[indexPath.row]
                dvc.springURL = SpringAplicationUrlText[indexPath.row]
                dvc.summerURL = SummerApplicationUrlText[indexPath.row]
                dvc.fallURL = FallApplicationUrlText[indexPath.row]
            }
        }
    }
}


extension GetInformedPage: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 136 , height: 136)
    }
}


//extension GetInformedPage {
//
//    func fetchData() -> [OrganizationClass] {
//
//        let Organization1 = OrganizationClass(image: OrganizationsList.org1!, title: "AfterSchoolMatters")
//        let Organization2 = OrganizationClass(image: OrganizationsList.org2!, title: "CatholicCharities")
//        let Organization3 = OrganizationClass(image: OrganizationsList.org3!, title: "JorbCorps")
//        let Organization4 = OrganizationClass(image: OrganizationsList.org4!, title: "AdlerPlanetarium")
//        let Organization5 = OrganizationClass(image: OrganizationsList.org5!, title: "AlternativeInc")
//        let Organization6 = OrganizationClass(image: OrganizationsList.org6!, title: "ChicagoYouthcenters")
//        let Organization7 = OrganizationClass(image: OrganizationsList.org7!, title: "AmeriCorps")
//        let Organization8 = OrganizationClass(image: OrganizationsList.org8!, title: "ChicagoYouthProgramsInc")
//
//        return [Organization1, Organization2, Organization3, Organization4, Organization5, Organization6, Organization7, Organization8]
//    }
//}
