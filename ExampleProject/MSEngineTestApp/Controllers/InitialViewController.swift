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
    private var viewToPush: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myNameLabel?.alpha = 0.0
        self.createdByLabel?.alpha = 0.0
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        self.viewToPush = storyBoard.instantiateViewController(withIdentifier: "RenderViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.5, options: [], animations: {
            self.createdByLabel?.alpha = 1.0
        })
        UIView.animate(withDuration: 2.0, delay: 0.8, options: [], animations: {
            self.myNameLabel?.alpha = 1.0
        }, completion: { (Bool) in
            self.goToRenderView()
        })
    }
    
    private func goToRenderView() {
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if let dest =  self.viewToPush {
                UIView.animate(withDuration: 2.0, delay: 0.5, options: [], animations: {
                    self.myNameLabel?.alpha = 0.0
                })
                UIView.animate(withDuration: 2.0, delay: 0.8, options: [], animations: {
                    self.createdByLabel?.alpha = 0.0
                } , completion: { (Bool) in
                    self.present(dest, animated: true, completion: nil)
                })
            }
        }
    }
}
