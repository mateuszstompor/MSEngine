//
//  InitialViewController.swift
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 12/09/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var createdByLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myNameLabel?.alpha = 0.0
        self.createdByLabel?.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, animations: {
            self.myNameLabel?.alpha = 1.0
            self.createdByLabel?.alpha = 1.0
        }, completion: { (Bool) in
            self.goToRenderView()
        })
    }
    
    private func goToRenderView() {
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let dest = storyboard.instantiateViewController(withIdentifier: "RenderViewController") as? RenderViewController {
                UIView.animate(withDuration: 2.0, animations: {
                    self.myNameLabel?.alpha = 0.0
                    self.createdByLabel?.alpha = 0.0
                }, completion: { (Bool) in
                    self.navigationController?.pushViewController(dest, animated: true)
                })
            }
        }
    }
}
