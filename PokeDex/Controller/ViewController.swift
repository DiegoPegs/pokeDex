//
//  ViewController.swift
//  PokeDex
//
//  Created by Compila  on 05/10/16.
//  Copyright © 2016 Pegs. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    var pokemons = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        self.collection.delegate = self
        self.collection.dataSource = self
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
            let pokemon = self.pokemons[indexPath.row]
            cell.configureCell(pokemon)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
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
    
    


}

