//
//  ViewController.swift
//  hangmoth
//
//  Created by Fruit Dragon on 3/27/24.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords: [String] = ["ladybug", "black cat", "butterfly", "peacock", "fox", "turtle", "bee", "snake", "tiger", "goat", "pig", "rooster", "monkey", "rabbit", "bunny", "dog", "horse", "mouse", "rat", "ox", "dragon", "eagle"]
    var dictOfWords: [String: [String]] = [
        "kwami names":["tikki", "plagg", "nooroo", "duusu", "trixx", "wayzz", "pollen", "sass", "roaar", "ziggy", "daizzi", "orikko", "xuppu", "fluff", "barkk", "kaalki", "mullo", "stompp", "longg", "liiri", "gimmi"],
        "power names":["miracle cure", "lucky charm", "cataclysm", "akuma", "kamiko", "sentibeing", "sentimonster", "mirage", "shellter", "venom", "second chance", "clout", "genesis", "gift", "sublimation", "uproar", "burrow", "fetch", "voyage", "multitude", "resistance", "wind dragon", "water dragon", "storm dragon", "liberation", "wish"],
        "kwami domains":["creation", "destruction", "transmission", "emotion", "illusion", "protection", "action", "subjection", "subjugation", "intuition", "elation", "passion", "jubilation", "pretension", "derision", "evolution", "adoration", "migration", "multiplication", "determination", "perfection", "freedom", "reality"],
        "transformed holders":["ladybug", "scarabella", "shadybug", "toxinelle", "claw noir", "griffe noir", "chat noir", "lady noire", "kitty noire", "monarch", "hawk moth", "mayura", "argos", "rena rouge", "rena furtive", "carapace", "vesperia", "viperion", "purple tigress", "caprikid", "pigella", "rooster bold", "king monkey", "bunnyx", "traquemoiselle", "miss hound", "pegasus", "polymouse", "multimouse", "minotaurox", "ryūko", "eagle", "ladydragon"],
        "weapons":["yo-yo", "baton", "staff", "stick", "cane", "fan", "flute", "shield", "trompo", "top", "lyre", "bolas", "paintbrush", "tambourine", "pen", "bō", "umbrella", "ball", "horseshoe", "jumprope", "sledgehammer", "sword", "bullroar", "parasol"],
        "animal counterparts":["ladybug", "black cat", "butterfly", "peacock", "fox", "turtle", "bee", "snake", "tiger", "goat", "pig", "rooster", "monkey", "rabbit", "bunny", "dog", "horse", "mouse", "rat", "ox", "dragon", "eagle"],
        "jewelry forms":["earrings", "ring", "brooch", "necklace", "pendant", "foxtail", "bracelet", "comb", "ouroboros", "hairclips", "anklet", "circlet", "coronet", "pocketwatch", "collar", "sunglasses", "coin", "choker", "talon"],
        "general":["miraculous", "mage", "miracle", "guardian", "temple", "quantic", "kwami", "box", "luck", "lucky"],
        "akuma names":["glaciator", "troublemaker", "weredad", "puppeteer", "catalyst", "volpina", "chameleon", "hoaxer", "stormy weather", "monsieur pigeon", "timebreaker", "copycat", "chat blanc", "pharaoh", "lady wifi", "bubbler", "rogercop", "horrificator", "mime", "evillustrator", "pixelator", "sandboy", "animan", "darkblade", "gamer", "reflekta", "antibug", "stoneheart", "collector", "gigantitan", "befana", "riposte", "gorizilla", "sapotis", "robustus", "syren", "zombizou", "reverser", "frightningale", "frozer", "anansi", "maletictator", "queen wasp", "miracle queen", "queen mayor", "queen banana", "animaestro", "bakerix", "backwarder", "reflekdoll", "silencer", "onichan", "ikari gozen", "miraculer", "sole crusher", "oblivio", "desperada", "christmaster", "princess fragrance", "startrain", "kwamibuster", "feast", "timetagger", "truth", "lies", "psychomedian", "guiltrip", "crocoduel", "optigami", "sentibubbler", "hacksan", "rocketear", "wishmaker", "simpleman", "qilin", "ephemeral", "penalteam", "risk", "strikeback", "safari"],
        "civilian holders":["marinette", "adrien", "gabriel", "nathalie", "félix", "alya", "lila", "nino", "zoé", "chloé", "luka", "juleka", "nathaniel", "rose", "marc", "kim", "alix", "sabrina", "max", "mylène", "kagami", "jess", "cerise", "iris", "fei"]
    ]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newGameButton.isEnabled = true
            updateUI()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newGameButton.isEnabled = true
            updateUILost()
        }
    }
    
    var currentGame: Game!
    
    var newWordCategory: String = ""
    
    var usedWords = Set<String>()
    
    
    @IBOutlet var roomImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet var category: UILabel!
    
    @IBOutlet var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.isEnabled = false
        newRound()
        
    }
    
    func newRound() {
        
        
        if !listOfWords.isEmpty {
            
            // Select a random key
            let randomKeyIndex = Int.random(in: 0..<dictOfWords.count)
            let randomKey = Array(dictOfWords.keys)[randomKeyIndex]

            // Select a random value from the list associated with the random key
            let randomValueIndex = Int.random(in: 0..<dictOfWords[randomKey]!.count)
            let randomValue = dictOfWords[randomKey]![randomValueIndex]
            
            let newWord = randomValue
            newWordCategory = randomKey
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        else {
            updateUI()
            enableLetterButtons(false)
        }
        
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        newRound()
    }
    
    
    func enableLetterButtons (_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        category.text = "Category: \(newWordCategory)"
        roomImageView.image = UIImage(named: "kwami \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateUILost() {
        var letters = [String]()
        for letter in currentGame.word {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        category.text = "Category: \(newWordCategory)"
        roomImageView.image = UIImage(named: "kwami \(currentGame.incorrectMovesRemaining)")
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        if (newGameButton.isEnabled == false) {
            sender.isEnabled = false
            let letterString = sender.configuration!.title!
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateGameState()
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
}
