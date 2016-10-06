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
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var pokedexIDLbl: UILabel!
    @IBOutlet var baseAtackLbl: UILabel!
    @IBOutlet var evoLbl: UILabel!
    @IBOutlet weak var currentImg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        mainImg.image = img
        currentImg.image = img
        pokedexIDLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            //wherever we write will only be called after the network call is complete!
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        self.weightLbl.text = pokemon.weight
        self.heightLbl.text = pokemon.height
        self.defenseLbl.text = pokemon.defense
        self.baseAtackLbl.text = pokemon.attack
        self.typeLbl.text = pokemon.type
        self.descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" {
            evoLbl.text = "No Evolutions"
            nextImg.isHidden = true
        }else {
            nextImg.image = UIImage(named: pokemon.nextEvolutionID)
            nextImg.isHidden = false
            
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLvl)"
            evoLbl.text = str
        }
    }

    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }


}
