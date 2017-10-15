//
//  MenuTableViewCell.swift
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 14/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//

import UIKit

class PointLightTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate var lightAppearanceImageView: UIImageView?
    @IBOutlet fileprivate var lightPositionLabel: UILabel?
    @IBOutlet fileprivate var lightPowerLabel: UILabel?
    @IBOutlet fileprivate var lightPowerSwitch: UISwitch?
    
    
    var lightWasSwitchedBlock: ((PointLightTableViewCell, Bool) -> Void)?
    var lightColor: UIColor? {
        didSet {
            self.lightAppearanceImageView?.backgroundColor = self.lightColor ?? UIColor.black
        }
    }
    var lightPower: Float? {
        didSet {
            self.lightPowerLabel?.text = "power: \(String(describing: self.lightPower))"
        }
    }
    var position: CIVector? {
        didSet {
            self.lightPositionLabel?.text = "x: \(String(describing: self.position?.x)) y: \(String(describing: self.position?.y)) z: \(String(describing: self.position?.z))"
        }
    }
    var isOn: Bool? {
        didSet {
            if isOn != nil {
                self.lightPowerSwitch?.isHidden = false
                self.lightPowerSwitch?.isOn = isOn!
            } else {
                self.lightPowerSwitch?.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lightAppearanceImageView?.layer.cornerRadius = 10
        self.lightAppearanceImageView?.layer.borderColor = UIColor.black.cgColor
        self.lightAppearanceImageView?.layer.borderWidth = 1.0
        self.lightAppearanceImageView?.layer.masksToBounds = true
        self.clean()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.clean()
    }
    
    private func clean() {
        self.lightPositionLabel?.text = ""
        self.lightPowerLabel?.text = ""
        self.lightPowerSwitch?.isHidden = true
    }

    @IBAction func switchWasSwitched(_ sender: UISwitch) {
        self.isOn = sender.isOn
        self.lightWasSwitchedBlock?(self,sender.isOn)
    }
}
