//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Jilmer Mayta on 6/18/21.
//  Copyright © 2021 Jilmer Mayta. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
