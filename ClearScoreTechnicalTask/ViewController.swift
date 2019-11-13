//
//  ViewController.swift
//  ClearScoreTechnicalTask
//
//  Created by Jack Sherwood on 07/11/2019.
//  Copyright © 2019 Jack Sherwood. All rights reserved.
//

import UIKit

var creditScore: Int?
var internetConnection: Bool?

let circleLoader = LoadingCircle()

class ViewController: UIViewController {
    
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var popOverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircle()
        internetConnection = checkConnection()
        
        //If there is Internet then parse the JSONData from API
        // If not then load most recent credit score from Realm file
        switch internetConnection {
        case true:
            setupWithConnection()
        default:
            print("No Internet Connection")
            self.view.addSubview(popOverView)
            popOverView.center = self.view.center
            
        }
    }
    
    
    func setupWithConnection() {
        let semaphore = DispatchSemaphore(value: 0)
        let JSONParser = JSONParsing()
        JSONParser.parseJSON{ (data: Account, score: Int) in
            creditScore = score
            semaphore.signal()
        }
        semaphore.wait()
        circleLoader.loadingAnimation(score: creditScore ?? 0)
        scoreLabel.text = String(creditScore ?? 0)

    }
    
    
    
    func setupCircle() {
        circleLoader.createLoadingCircle(view: mainView) { (shape: CAShapeLayer, underTrack: CAShapeLayer) in
            view.layer.addSublayer(underTrack)
            view.layer.addSublayer(shape)
            view.addSubview(scoreLabel)
            view.addSubview(creditLabel)
            
            let viewCenter = view.center
            creditLabel.center = CGPoint(x: viewCenter.x, y: viewCenter.y - 75)
            scoreLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            scoreLabel.center = view.center
            print("CircleLoaded")
        }
    }
    
    func checkConnection() -> Bool {
        if ConnectionTest.isConnectedToNetwork() == true {
            print("Internet Connection Available")
            return true
        }
        else {
            print("No Connection Available")
            return false
        }
    }

}
