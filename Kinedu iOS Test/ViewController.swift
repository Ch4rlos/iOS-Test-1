//
//  ViewController.swift
//  Kinedu iOS Test
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 Appsodi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var nps : [NPS]?
    var userTypeOne : [NPS] = []
    var userTypeTwo : [NPS] = []
    var userTypeThree : [NPS] = []
    
    @IBOutlet weak var appVersionControl: UISegmentedControl!
    
    @IBOutlet weak var freemiumUserCounter: UILabel!
    @IBOutlet weak var freemiumUserData: UILabel!
    
    @IBOutlet weak var premiumUserCounter: UILabel!
    @IBOutlet weak var premiumUserData: UILabel!
    
    @IBAction func versionControll(_ sender: Any) {
        var npsScore : [NPS] = []
        
        switch appVersionControl.selectedSegmentIndex {
        case 0:
            npsScore = self.userTypeOne
        case 1:
            npsScore = self.userTypeTwo
        case 2:
            npsScore = self.userTypeThree
        default:
            break;
        }
        changeLabels(array: npsScore)
    }
    
    func changeLabels(array: [NPS]?){
        var free = 0
        var premium = 0
        
        for nps in array!{
            let version = nps.user_plan!
            if version == "freemium" {
                free += 1
            } else if version == "premium" {
                premium += 1
            }
        }
        
        self.freemiumUserCounter.text = "\(free)"
        self.freemiumUserData.text = "Out of \(array!.count)"
        
        self.premiumUserCounter.text = "\(premium)"
        self.premiumUserData.text = "Out of \(array!.count)"
    }
    
    @IBAction func seeMoreActionButton(_ sender: Any) {
        performSegue(withIdentifier: "more", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "more"{
            let vc = segue.destination as! NpsDetail
            
            switch appVersionControl.selectedSegmentIndex {
            case 0:
                vc.npsDetail = self.userTypeOne
                vc.versionTitle = appVersionControl.titleForSegment(at: 0)
            case 1:
                vc.npsDetail = self.userTypeTwo
                vc.versionTitle = appVersionControl.titleForSegment(at: 0)
            case 2:
                vc.npsDetail = self.userTypeThree
                vc.versionTitle = appVersionControl.titleForSegment(at: 0)
            default:
                print("choose a valid option")
            }

        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Kinedu NPS Score"
        getNpsData()
    }
    
    func getNpsData(){
        ApiCalls.sharedInstance.getNpsData() { (result) in
            switch result {
            case .success(let response):
                self.nps = response
                
                if var data = self.nps {
                    for i in 0...data.count-1{
                        let version = data[i].build?.version
                        switch version {
                        case "3.1.12":
                            self.userTypeOne += [data[i]]
                        case "3.2.1":
                            self.userTypeTwo += [data[i]]
                        case "3.2.2":
                            self.userTypeThree += [data[i]]
                        default:
                            print("default")
                        }
                    }
                }
                
                self.changeLabels(array: self.userTypeOne)
                
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

