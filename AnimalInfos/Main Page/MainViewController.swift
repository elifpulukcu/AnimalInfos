//
//  MainViewController.swift
//  AnimalInfos
//
//  Created by Elif Pulukçu on 16.07.2023.
//

import UIKit
import AVKit
import AVFoundation

struct AnimalViewData {
    let view: AView
    let wikiLink: String
    let videoName: String
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var cheetahView: AView!
    @IBOutlet weak var giraffeView: AView!
    @IBOutlet weak var gorillaView: AView!
    @IBOutlet weak var hippoView: AView!
    @IBOutlet weak var lionView: AView!
    @IBOutlet weak var zebraView: AView!
    @IBOutlet weak var ostrichView: AView!
    @IBOutlet weak var elephantView: AView!
    
    var animalViews: [AnimalViewData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MEET THE ANIMALS"
        setupMyViews()
    }
    
    private func setupMyViews() {
        animalViews = [
            AnimalViewData(view: cheetahView, wikiLink: "https://en.wikipedia.org/wiki/Cheetah", videoName: "cheetah"),
            AnimalViewData(view: giraffeView, wikiLink: "https://en.wikipedia.org/wiki/Giraffe", videoName: "giraffe"),
            AnimalViewData(view: gorillaView, wikiLink: "https://en.wikipedia.org/wiki/Gorilla", videoName: "gorilla"),
            AnimalViewData(view: hippoView, wikiLink: "https://en.wikipedia.org/wiki/Hippopotamus", videoName: "hippo"),
            AnimalViewData(view: lionView, wikiLink: "https://en.wikipedia.org/wiki/Lion", videoName: "lion"),
            AnimalViewData(view: zebraView, wikiLink: "https://en.wikipedia.org/wiki/Zebra", videoName: "zebra"),
            AnimalViewData(view: ostrichView, wikiLink: "https://en.wikipedia.org/wiki/Common_ostrich", videoName: "ostrich"),
            AnimalViewData(view: elephantView, wikiLink: "https://en.wikipedia.org/wiki/Elephant", videoName: "elephant")
        ]
        
        for animal in animalViews {
            animal.view.webLink = animal.wikiLink
            animal.view.goToLinkAction = routeWebVC()
            animal.view.goToVideoAction = {
                self.playVideo(animal.videoName)
            }
        }
    }
    
    func routeWebVC() -> (String) -> () {
        return { urlString in
            let storyboard = UIStoryboard(name: "WebViewController", bundle: nil)
            if let webVC = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                webVC.urlString = urlString
                self.navigationController?.pushViewController(webVC, animated: true)
            }
        }
    }
    
    func playVideo(_ videoName: String) {
        if let path = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerControl = AVPlayerViewController()
            playerControl.player = player
            
            self.present(playerControl, animated: true) {
                player.play()
            }
        }
    }
}
