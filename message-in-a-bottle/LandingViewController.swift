//
//  LandingViewController.swift
//  message-in-a-bottle
//
//  Created by Dave Neff on 11/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class LandingViewController: UIViewController {

    @IBOutlet weak var bottlesButton: UIButton!
    @IBOutlet weak var oceansButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    
    var reframeView = UIView()
    
    var bottlesLabel = UILabel()
    var bottlesSublabel = UILabel()
    var oceansLabel = UILabel()
    var oceansSublabel = UILabel()
    var chatLabel = UILabel()
    var chatSublabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        // Do any additional setup after loading the view.
    }

    func setUpViews() {

        
        self.view.backgroundColor = UIColor.themeTealBlue
        self.view.addSubview(reframeView)
        reframeView.frame = CGRect(x:0,y:self.view.frame.height * 0.1,width: self.view.frame.width, height: self.view.frame.height * 0.9)
        reframeView.addSubview(bottlesButton)
        reframeView.addSubview(oceansButton)
        reframeView.addSubview(chatButton)
        
        
        bottlesButton.frame = CGRect(x: 0, y: 0, width: reframeView.frame.width, height: reframeView.frame.height * 1/3)
        bottlesButton.backgroundColor = UIColor.themeTealBlue
        bottlesButton.addSubview(bottlesLabel)
        bottlesLabel.frame = CGRect(x: 0, y: 0, width: bottlesButton.frame.width, height: bottlesButton.frame.height * 0.75)
        bottlesLabel.text = "Bottles"
        bottlesLabel.textAlignment = .center
        bottlesLabel.font = UIFont(name: "HelveticaNeue-Light", size: 60)
        
        bottlesButton.addSubview(bottlesSublabel)
        bottlesSublabel.frame = CGRect(x: 0, y: bottlesButton.frame.height * 0.55, width: bottlesButton.frame.width, height: bottlesButton.frame.height * 0.2)
        bottlesSublabel.text = "See the bottles you've sent,\nor send out a new one"
        bottlesSublabel.textAlignment = .center
        bottlesSublabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        bottlesSublabel.numberOfLines = 2
        
        
        oceansButton.frame = CGRect(x: 0, y: reframeView.frame.height * 1/3, width: reframeView.frame.width, height: reframeView.frame.height * 1/3)
        oceansButton.backgroundColor = UIColor.themeMedBlue
        oceansButton.addSubview(oceansLabel)
        oceansLabel.frame = CGRect(x: 0, y: 0, width: bottlesButton.frame.width, height: bottlesButton.frame.height * 0.75)
        oceansLabel.text = "Oceans"
        oceansLabel.textAlignment = .center
        oceansLabel.font = UIFont(name: "HelveticaNeue-Light", size: 60)
        
        oceansButton.addSubview(oceansSublabel)
        oceansSublabel.frame = CGRect(x: 0, y: oceansButton.frame.height * 0.55, width: oceansButton.frame.width, height: oceansButton.frame.height * 0.2)
        oceansSublabel.text = "View all of the oceans avaiable,\nor answer a message thrown into one"
        oceansSublabel.textAlignment = .center
        oceansSublabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        oceansSublabel.numberOfLines = 2
        
        chatButton.frame = CGRect(x: 0, y: reframeView.frame.height * 2/3, width: reframeView.frame.width, height: reframeView.frame.height * 1/3)
        chatButton.backgroundColor = UIColor.themeSand
        chatButton.addSubview(chatLabel)
        chatLabel.frame = CGRect(x: 0, y: 0, width: bottlesButton.frame.width, height: bottlesButton.frame.height * 0.75)
        chatLabel.text = "Chats"
        chatLabel.textAlignment = .center
        chatLabel.font = UIFont(name: "HelveticaNeue-Light", size: 60)
        
        chatButton.addSubview(chatSublabel)
        chatSublabel.frame = CGRect(x: 0, y: chatButton.frame.height * 0.55, width: chatButton.frame.width, height: chatButton.frame.height * 0.2)
        chatSublabel.text = "Chat with someone you've been connected with\nand get to networking!"
        chatSublabel.textAlignment = .center
        chatSublabel.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        chatSublabel.numberOfLines = 2
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print(error)
        }
        
        if let storyboard = self.storyboard {
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginVC, animated: false, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    

}
