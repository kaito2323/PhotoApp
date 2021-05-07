//
//  ViewController.swift
//  PhotoApp
//
//  Created by kaito12 on 2021/04/30.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet weak var TextField: UITextField!
    
    var textBox = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func Search(_ sender: Any) {
        
        textBox = TextField.text!
        
       performSegue(withIdentifier: "CollectionVC", sender: nil)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let collectionVC = segue.destination as? CollectionViewController
        
        collectionVC?.KeyWord = textBox
        
        TextField.text = ""
        
    }
    
    
}

