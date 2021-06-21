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
    @IBOutlet weak var ReproducirBoton: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (snap.descrip == "") {
            lblMensaje.text = "Mensaje: Sin Descripcion 😒"
        }else{
            lblMensaje.text = "Mensaje: " + snap.descrip
        }
        if (snap.TypeData == "mp3") {
            imageView.isHidden = true
        }else{
            ReproducirBoton.isHidden = true
            lblTimer.isHidden = true
            imageView.sd_setImage(with: URL(string: snap.dataURL), completed: nil)
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("usuarios").child((Auth.auth().currentUser?.uid)!).child("snaps").removeValue()
        Storage.storage().reference().child("imagenes").child("\(snap.dataID).jpg").delete
            { (error) in
            print("Se elimino la imagen correctamente")
        }
    }

    @IBAction func ReproducirTapped(_ sender: Any) {
    }
}
