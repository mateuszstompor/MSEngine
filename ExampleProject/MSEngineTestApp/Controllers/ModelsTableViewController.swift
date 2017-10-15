//
//  MenuViewController.swift
//  MSEngineTestApp
//
//  Created by Mateusz Stompór on 14/10/2017.
//  Copyright © 2017 Mateusz Stompór. All rights reserved.
//


import UIKit

class ModelsTableViewController: UITableViewController {
    
    var lightSources: [MSPositionedLight?]? = MSEngine.getInstance()?.getPointLights()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PointLightTableViewCell") as? PointLightTableViewCell {
            if let positionedLight = lightSources?[indexPath.row] {
                let light = positionedLight.getLight()!
                let modelPosition = positionedLight.getTransformation()
                cell.isOn = light.isOn()
                cell.position = CIVector(x: CGFloat(modelPosition?.position().value(at: 0) ?? 0.0), y: CGFloat(modelPosition?.position().value(at: 1) ?? 0.0), z: CGFloat(modelPosition?.position().value(at: 1) ?? 0.0))
                cell.lightPower = light.getPower()
                cell.lightWasSwitchedBlock = { [weak self] (cell: PointLightTableViewCell, isOn: Bool) in
                    if let indexPath = self?.tableView.indexPath(for: cell) {
                        self?.lightSources?[indexPath.row]?.getLight()?.lights(isOn)
                    }
                    
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pointLightsArray = self.lightSources {
            return pointLightsArray.count
        } else {
            return 0
        }
    }
}
