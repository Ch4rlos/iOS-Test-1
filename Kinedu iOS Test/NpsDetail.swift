//
//  NpsDetail.swift
//  Kinedu iOS Test
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 Appsodi. All rights reserved.
//

import UIKit
import Prestyler

class userNote: UICollectionViewCell{
    @IBOutlet weak var babyImage: UIImageView!
    @IBOutlet weak var labelNumber: UILabel!
}

class NpsDetail: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var npsDetail : [NPS]?
    var versionTitle : String?
    
    @IBOutlet weak var gradesCollection: UICollectionView!
    
    @IBOutlet weak var freemiumUsers: UILabel!
    @IBOutlet weak var premiumUsers: UILabel!
    @IBOutlet weak var viewDetail: UIView!
    
    
    @IBOutlet weak var message: UILabel!
    
    let collectionArray = [CollectionMenu(babyImage: "baby_0", number: 0),CollectionMenu(babyImage: "baby_1", number: 1),CollectionMenu(babyImage: "baby_2", number: 2),CollectionMenu(babyImage: "baby_3", number: 3),CollectionMenu(babyImage: "baby_4", number: 4),CollectionMenu(babyImage: "baby_5", number: 5),CollectionMenu(babyImage: "baby_6", number: 6),CollectionMenu(babyImage: "baby_7", number: 7),CollectionMenu(babyImage: "baby_8", number: 8),CollectionMenu(babyImage: "baby_9", number: 9),CollectionMenu(babyImage: "baby_10", number: 10)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NPS Detail \(versionTitle!)"
        // Do any additional setup after loading the view.
        var free = 0
        var premium = 0
        guard npsDetail != nil else {return}
        for nps in npsDetail!{
            let version = nps.user_plan!
            if version == "freemium" {
                free += 1
            } else if version == "premium" {
                premium += 1
            }
        }
        freemiumUsers.text = "\(free)"
        premiumUsers.text = "\(premium)"
        message.text = "Choose an Score to watch detail"
        
        viewDetail.layer.shadowOpacity = 0.2
        viewDetail.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewDetail.layer.shadowRadius = 0.30
        viewDetail.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grade", for: indexPath) as! userNote
        
        let arrayData = self.collectionArray[indexPath.row]
        
        cell.labelNumber.text = "\(String(describing: arrayData.number!))"
        cell.babyImage.image = UIImage(named: arrayData.babyImage!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width  = (view.frame.width/4)
        let height  = (view.frame.height/5)
        print (width)
        print (height)
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredNames = npsDetail!.filter( {$0.nps! == indexPath.row })
        let totalPeople = filteredNames.count
        
        // Create dictionary to map value to count
        var counts = [Int: Int]()
        
        // Count the values with using forEach
        filteredNames.forEach { counts[$0.activity_views!] = (counts[$0.activity_views!] ?? 0) + 1 }
        
        // Find the most frequent value and its count with max(by:)
        if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
            print("\(value) occurs \(count) times")
            print(totalPeople)
            print(count)
            let percent = Double(count)/Double(totalPeople)
            let total = percent*100
            
            let doubleStr = String(format: "%.0f", total)
            
            Prestyler.defineRule("<2>",  UIColor.cyan, Prestyle.bold)
            Prestyler.defineRule("<1>",  UIColor.green, Prestyle.bold)
            self.message.attributedText = "<1>\(doubleStr)%<1> of the user that answered \(indexPath.row) in thei NPS score saw <2>\(value) activities<2> ".prestyled()
        }
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
