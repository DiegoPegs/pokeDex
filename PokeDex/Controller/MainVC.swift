//
//  MainVC.swift
//  PokeDex
//
//  Created by Compila  on 05/10/16.
//  Copyright © 2016 Pegs. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var filteredPokemons = [Pokemon]()
    var isInSearchMode = false
    
    
    override func viewDidLoad() {
        self.collection.delegate = self
        self.collection.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isInSearchMode {
            let pokemon = filteredPokemons[indexPath.row]
            performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
        }else {
            let pokemon = pokemons[indexPath.row]
            performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
        }
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for elem in rows {
                let pokeId = Int(elem["id"]!)!
                let name = elem["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                self.pokemons.append(poke)
            }
        }catch{
            
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            if isInSearchMode {
                let pokemon = self.filteredPokemons[indexPath.row]
                cell.configureCell(pokemon)
            }else {
                let pokemon = self.pokemons[indexPath.row]
                cell.configureCell(pokemon)
            }
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isInSearchMode {
            return self.filteredPokemons.count
        }
        return self.pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
           isInSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }else {
            isInSearchMode = true
            let lower = searchBar.text!.lowercased()
            self.filteredPokemons = self.pokemons.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData()
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        }else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let pokemon = sender as? Pokemon {
                if let vc = segue.destination as? PokemonDetailVC {
                    vc.pokemon = pokemon
                }
            }
        }
    }

    


}

