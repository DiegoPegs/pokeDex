//
//  PokeCell.swift
//  PokeDex
//
//  Created by Compila  on 05/10/16.
//  Copyright © 2016 Pegs. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PokeCell: UICollectionViewCell {

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        nameLbl.text = self.pokemon.name.capitalized
    }
}
