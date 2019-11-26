//
//  ThemesViewController.swift
//  Concentration
//
//  Created by AHMED GAMAL  on 9/3/19.
//  Copyright © 2019 AHMED GAMAL . All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, UISplitViewControllerDelegate {

    let themes = ["Sports" : "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓🥊🏑" ,
                  "Faces"  : "😀😂😅🤣☺️😊😇😉😍🥰😘🤪😎",
                  "Animals" : "🐶🐱🦊🐰🐹🐼🐨🐸🙉🐤🐥🐧🦐"
    ]
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choose theme"{
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName]{
                 if let cvc = segue.destination as? concentrationViewController{
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if  let cvc = splitViewDetailCOncentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName]{
            cvc.theme = theme
        }
        }
        else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle , let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        
        else{
            performSegue(withIdentifier: "choose theme", sender: sender)
        }
        
    }
    
    
    var splitViewDetailCOncentrationViewController : concentrationViewController?{
        return splitViewController?.viewControllers.last as? concentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController : concentrationViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? concentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false//false means i say to system i didnt collapsed so you should do it
    }
 

}
