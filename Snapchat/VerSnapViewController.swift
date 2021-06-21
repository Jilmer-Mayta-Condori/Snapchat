//
//  VerSnapViewController.swift
//  Snapchat
//
//  Created by Jilmer Mayta on 6/20/21.
//  Copyright © 2021 Jilmer Mayta. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class VerSnapViewController: UIViewController {

    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMensaje.text = "Mensaje: " + snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imagenURL), completed: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").removeValue()
        Storage.storage().reference().child("imagenes").child("\(snap.imagenID).jpg").delete
            { (error) in
            print("Se elimino la imagen correctamente")
        }
    }

}
