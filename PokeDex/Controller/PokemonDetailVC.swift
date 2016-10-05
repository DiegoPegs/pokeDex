//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Diego Cunha on 05/10/16.
//  Copyright © 2016 Pegs. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet var pokemonName: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = pokemon.name as? String{
            pokemonName.text = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
