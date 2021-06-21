//
//  AudioViewController.swift
//  Snapchat
//
//  Created by Jilmer Mayta on 6/21/21.
//  Copyright © 2021 Jilmer Mayta. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class AudioViewController: UIViewController {

    @IBOutlet weak var grabarAudioBoton: UIButton!
    @IBOutlet weak var reproducirAudioBoton: UIButton!
    @IBOutlet weak var mensajeTextField: UITextField!
    @IBOutlet weak var agregarBoton: UIButton!
    
    var grabarAudio:AVAudioRecorder?
    var reproducirAudio: AVAudioPlayer?
    var audioURL:URL?
    var audioID = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGrabacion()
        reproducirAudioBoton.isEnabled = false
        agregarBoton.isEnabled = false
    }

    @IBAction func GrabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording{
            grabarAudio?.stop()
            grabarAudioBoton.setTitle("  GRABAR   ", for: .normal)
            reproducirAudioBoton.isEnabled = true
            agregarBoton.isEnabled = true
    
        }else{
            grabarAudio?.record()
            grabarAudioBoton.setTitle("  DETENER ", for: .normal)
            reproducirAudioBoton.isEnabled = false
            agregarBoton.isEnabled = false
        }
    }
    @IBAction func ReproducirTapped(_ sender: Any) {
        do {
            try reproducirAudio = AVAudioPlayer(contentsOf: audioURL!)
            reproducirAudio!.play()
            print("Reproduciendo")
        } catch {}
    }
    @IBAction func AgregarTapped(_ sender: Any) {
        self.agregarBoton.isEnabled = false
        let imagenesFolder = Storage.storage().reference().child("audio")
        let audioData = NSData(contentsOf: audioURL!)! as Data
        let cargarImagen = imagenesFolder.child("\(audioID).jpg")
            cargarImagen.putData(audioData, metadata: nil) { (metadata, error) in
            if error != nil {
                self.mostrarAlert(titulo: "Error", mensaje: "Se produjo un error al subir la imagen. Verifique su conexion a internet y vuelva a intentarlo.", accion: "Aceptar")
                self.agregarBoton.isEnabled = true
                print("Ocurrio un error al subir imagen: \(error!) ")
            }else{
                cargarImagen.downloadURL(completion: { (url, error) in
                    guard let enlaceURL = url else{ self.mostrarAlert(titulo: "Error", mensaje: "Se produjo un error al obtener informacion de la imagen.", accion: "Cancelar")
                        self.agregarBoton.isEnabled = true
                        print("Ocurrio en error al obtener informaciond de imagen \(error!)")
                        return
                    }
                    self.performSegue(withIdentifier: "mostrarElegirUsuarios", sender: url?.absoluteString)
                })
            }
        }
        //
        //        let alertaCarga = UIAlertController(title: "Cargando Imagen....", message: "0%", preferredStyle: .alert)
        //        let progresoCarga : UIProgressView = UIProgressView(progressViewStyle: .default )
        //        cargarImagen.observe(.progress) {(snapshot) in
        //            let porcentaje = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
        //            print(porcentaje)
        //            progresoCarga.setProgress(Float(porcentaje), animated: true)
        //            progresoCarga.frame = CGRect(x:10, y:70, width: 250, height: 0)
        //            alertaCarga.message = String(round(porcentaje * 100.0)) + " %"
        //            if porcentaje >= 1.0 {
        //                alertaCarga.dismiss(animated: true, completion: nil)
        //            }
        //        }
        //        let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        //        alertaCarga.addAction(btnOK)
        //        alertaCarga.view.addSubview(progresoCarga)
        //        present(alertaCarga, animated: true, completion: nil)
        //
    }
    
    func configurarGrabacion(){
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponent = [basePath, "audio.mp4"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponent)!
            
            
            print("************************")
            print(audioURL!)
            print("************************")
            
            var settings: [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            grabarAudio = try AVAudioRecorder(url: audioURL!, settings: settings)
            grabarAudio!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func mostrarAlert(titulo:String, mensaje:String, accion:String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnCANCELOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnCANCELOK)
        present(alerta, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
        siguienteVC.audioURL = sender as! String
        siguienteVC.descrip = mensajeTextField.text!
        siguienteVC.audioID = audioID
    }
}
