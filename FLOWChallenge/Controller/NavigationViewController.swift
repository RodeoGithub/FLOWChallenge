//
//  ViewController.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 14/09/2022.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.title = "FLOW Clima Challenge"
        
        let barButtonMenu = UIMenu(title: "Preferences", image: UIImage(systemName: "list.dash"), children:
                                    [UIAction(title: NSLocalizedString("Copy", comment: ""), image: UIImage(systemName: "doc.on.doc"), handler: { (_) in
                                    }),
                                     UIAction(title: NSLocalizedString("Rename", comment: ""), image: UIImage(systemName: "pencil"), handler: { (_) in
                                     }),
                                     UIAction(title: NSLocalizedString("Duplicate", comment: ""), image: UIImage(systemName: "plus.square.on.square"), handler: { (_) in
                                     }),
                                     UIAction(title: NSLocalizedString("Move", comment: ""), image: UIImage(systemName: "folder"), handler: { (_) in
                                     })])
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Preferences", image: nil, primaryAction: nil, menu: barButtonMenu)]
    }
}

