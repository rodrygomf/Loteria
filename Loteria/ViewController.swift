//
//  ViewController.swift
//  Loteria
//
//  Created by Rodrigo Figueiredo on 16/05/19.
//  Copyright © 2019 Rodrigo Figueiredo. All rights reserved.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {
    // Propriedades
    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)
    }
    
    func showNumbers(for type: GameType) {
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megasena:
                game = 6>-<60
                balls.last?.isHidden = false
            case .quina:
                game = 5>-<80
                balls.last?.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
            case 0:
                showNumbers(for: .megasena)
            default:
                showNumbers(for: .quina)
        }
    }

}

