//
//  GameScene.swift
//  FI3
//
//  Created by Kai Drayton-Yee on 7/18/16.
//  Copyright (c) 2016 Kai Drayton-Yee. All rights reserved.
//

import SpriteKit
import AVFoundation

/////////////////////////// START! ///////////////////////////

enum GameSceneState {
    case PlayGame, CheckingWinOrLose, GameOver, CheckingLevels, Pause, Home
}

class GameScene: SKScene {
    
    //defining variables
    var counter = 0
    var circleOneIsSpinning = true
    var circleTwoIsSpinning = true
    var theCircleIsSpinning = true
    
    var levelClicked = 4
    var numRingCounterForLevel = 0
    
    
    //defining the objects
    var circleOne: SKSpriteNode!
    var circleTwo: SKSpriteNode!
    var theCircle: SKSpriteNode!
    
    //defining SKActions
    var rotateForever: SKAction!
    var rotatecircleTwoForever: SKAction!
    
    //defining the effects
    var loaderScreen: SKSpriteNode!
    
    //defining the sounds
    var backgroundSFX: AVAudioPlayer!
    let clickSound = SKAction.playSoundFileNamed("lockMeTwo", waitForCompletion: false)
    
    //defining the buttons
    let pauseButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSize(width: 35, height: 35))
    let homeButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 35, height: 35))
    let playButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 35, height: 35))
    let levelButton = SKSpriteNode(color: UIColor.yellowColor(), size: CGSize(width: 35, height: 35))
    
    
    let arrayOfCircleImages = ["blackRingSetOne", "blackRingSetTwo", "blackRingSetThree", "blackRingSetFour", "blackRingSetFive"]
    let arrayOfNibImages = ["blackNibSetOne", "blackNibSetTwo", "blackNibSetThree", "blackNibSetFour", "blackNibSetFive"]
    
    //defining setup protocal
    var gameState: GameSceneState = .Home
    
    /////////////////////////// functions start here ///////////////////////////
    
    func runCheckState() {
        print("weAreHere")
        switch gameState {
        case .Home:
            weAreOnTheHomePage()
        case .PlayGame:
            weAreOnThePlayGamePage()
        case .CheckingWinOrLose:
            weAreOntheCheckingWinOrLosePage()
        case .GameOver:
            weAreOnTheGameOverPage()
        case .CheckingLevels:
            weAreOnTheCheckingLevelsPage()
        case .Pause:
            weAreOnThePausePage()
        }
    }
    
    override func didMoveToView(view: SKView) {
        print("startup")
        
        audioSetUp()
        
        //button location setup
        levelButton.position.x = view.frame.width / 2
        levelButton.position.y = view.frame.height * (1 / 8)
        pauseButton.position.x = view.frame.width * (7 / 8)
        pauseButton.position.y = view.frame.height * (7 / 8)
        playButton.position.x = view.frame.width / 2
        playButton.position.y = view.frame.height / 2
        homeButton.position.x = view.frame.width / 8
        homeButton.position.y = view.frame.height * (1 / 8)
        
        runCheckState()
    }
    
    func weAreOnTheHomePage(){
        print("we are on the \(gameState) page")
        addChild(levelButton)
        print("level Button created")
    }
    
    func weAreOnThePlayGamePage(){
        
        print("we are on the \(gameState) page")
        
        //testLevel()
        
        loadGameLevelSelected()
        
        
        addChild(pauseButton)
        print("pauseButton is created")
    }
    
    func weAreOntheCheckingWinOrLosePage(){
        print("we are on the \(gameState) page")
       // for circle in 0...circles{
      //  print("degrees = \(sDegrees) for circle \(circle + 1)")
        
        //if winState{
        //			gameState = .CheckingLevels
        //		}else{
        //			gameState = .GameOver
        //		}
    }
    
    func weAreOnTheCheckingLevelsPage(){
        print("we are on the \(gameState) page")
        
        addChild(homeButton)
        print("homeButton is created")
        
        addChild(playButton)
        print("playButton is created")
    }
  
    func weAreOnTheGameOverPage(){
        print("we are on the \(gameState) page")
        
        addChild(playButton)
        print("playButton is created")
        
        addChild(homeButton)
        print("homeButton is created")
        
        addChild(levelButton)
        print("levelsButton is created")
    }
    
    func weAreOnThePausePage(){
        print("we are on the \(gameState) page")
        
        loaderScreen = SKSpriteNode(color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: CGSize(width: view!.frame.width, height: view!.frame.height))
        loaderScreen.position.x = view!.frame.width / 2
        loaderScreen.position.y = view!.frame.height / 2
        addChild(loaderScreen)
        
        addChild(playButton)
        print("playButton is created")
        
        addChild(levelButton)
        print("levelsButton is created")
        
        addChild(homeButton)
        print("homeButton is created")
        
        
        
        /////////////////////////////////////////////////////////////////////////////////
        //////////////////  actual data needed to check win state  ///////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        let arrayOfLevelToPlay = Levels.infoForLevels[levelClicked]
        for circleInfoToPrint in 0...arrayOfLevelToPlay.count - 1{
            let arrayOfCircleToPrint = arrayOfLevelToPlay[circleInfoToPrint]
            let rDegreesIs = arrayOfCircleToPrint.sDegrees
            print("\(rDegreesIs) is the counter for level \(levelClicked) on the \(circleInfoToPrint) numbered ring.")
        }
        
        
//
//        print("\(RotationDictionary.tDegrees["blackRingSetOne"])")
//        var rDegrees = 0
//
//        RotationDictionary.tDegrees["blackRingSetOne"] = (asdfasdf)
//
//
//        var namesOfIntegers = [Int: String]()
//        // namesOfIntegers is an empty [Int: String] dictionary
//        namesOfIntegers[16] = "sixteen"
//        // namesOfIntegers now contains 1 key-value pair
//        namesOfIntegers = [:]
//        // namesOfIntegers is once again an empty dictionary of type [Int: String]
//        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//        airports["LHR"] = "London Heathrow"
//        // the value for "LHR" has been changed to "London Heathrow"
        
       
        
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////  helper functions ///////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    func quitCurrentLevel(){
        
        ///////////////////////////////////////////////////////////////
        /////////////  deletion ring/nib rotation needed  ///////////////////
        ///////////////////////////////////////////////////////////////
        //circleOne.removeFromParent()
        //circleTwo.removeFromParent()
        counter = 0
        print("game progress deleted")
    }
    
    func audioSetUp(){
        print("audio is setup and playing")
        let path = NSBundle.mainBundle().pathForResource("fromInside", ofType:".caf")!
        let url = NSURL(fileURLWithPath: path)
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            backgroundSFX = sound
            sound.play()
        } catch {
            // couldn't load file :(
        }
        backgroundSFX.numberOfLoops = -1
        backgroundSFX.volume = 1.0
    }
    
    func testLevel(){
        //originally in play game
        let rotate = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: 6)
        rotateForever = SKAction.repeatActionForever(rotate)
        let rotatecircleTwo = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: 4)
        rotatecircleTwoForever = SKAction.repeatActionForever(rotatecircleTwo)
        
        circleOne = SKSpriteNode(texture: SKTexture(imageNamed:"blackRingSetOne"), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
        addChild(circleOne)
        circleOne.position.x = view!.frame.width / 2
        circleOne.position.y = view!.frame.height / 2
        circleOne.runAction(rotateForever)
        
        circleTwo = SKSpriteNode(texture: SKTexture(imageNamed:"blackRingSetTwo"), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
        addChild(circleTwo)
        circleTwo.position.x = view!.frame.width / 2
        circleTwo.position.y = view!.frame.height / 2
        circleTwo.runAction(rotatecircleTwoForever)
        print("both the circleOne and the circleTwo have started moving")
        
        let nibOne = SKSpriteNode(texture: SKTexture(imageNamed:"blackNibSetFive"), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
        let nibTwo = SKSpriteNode(texture: SKTexture(imageNamed:"blackNibSetFour"), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
        
        circleOne.addChild(nibOne)
        nibOne.anchorPoint = CGPointMake(1.0,1.0)
        nibOne.position.x = circleOne.frame.width / 2
        nibOne.position.y = circleOne.frame.height / 2
        
        circleTwo.addChild(nibTwo)
        nibTwo.anchorPoint = CGPointMake(1.0,1.0)
        nibTwo.position.x = circleTwo.frame.width / 2
        nibTwo.position.y = circleTwo.frame.height / 2
    }
    
    func loadGameLevelSelected(){
        let arrayOfLevelToPlay = Levels.infoForLevels[levelClicked]
        print("\(arrayOfLevelToPlay) is the different circles (with their perameters) for this level")
        let numRingCounterForLevel = arrayOfLevelToPlay.count - 1
        
        for circleNumber in 0...arrayOfLevelToPlay.count - 1 {
            let arrayOfCircleToCreate = arrayOfLevelToPlay[circleNumber]
            print("\(arrayOfCircleToCreate) is the perameters for the circle being created")
            
            let rSpeedIs = arrayOfCircleToCreate.sSpeed
             let rSpeed = Double(rSpeedIs)
            //let rSpeed = 6.0
            let rotate = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: rSpeed)
            let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI) * -2, duration: rSpeed)
            
            let theCircle = SKSpriteNode(texture: SKTexture(imageNamed: arrayOfCircleImages[circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
            
            let theNib = SKSpriteNode(texture: SKTexture(imageNamed:arrayOfNibImages[circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
            
            addChild(theCircle)
            theCircle.position.x = self.frame.width / 2
            theCircle.position.y = self.frame.height / 2
            ///////////////////////////////////////////////////////////////
            /////////////  NIB ROTATION AND DUPLICATION NEEDED  ///////////////////
            ///////////////////////////////////////////////////////////////
            
            
            
            
               // var shape = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 20, height: 20))
                //for (var i=0 ; i<10 ; i++)
                //{
                  //  var sprite = shape.copy() as SKSpriteNode
                  //  sprite.name = "shape\(i)"
                  //  sprite.position = CGPointMake(20 + CGFloat(i*30) , CGRectGetMidY(self.frame) )
                 //   self.addChild(sprite)
               // }
                
                
            
            
            
            
            
            
            
            
            
            theCircle.addChild(theNib)
            theNib.position.x = theCircle.frame.width / 2
            theNib.position.y = theCircle.frame.height / 2
            theNib.anchorPoint = CGPointMake(1.0,1.0)
           
            let updateDegreeCounter = SKAction.runBlock{
             /////////////////////////////////////////////////////////////// += 1
            }
            let seqOne = SKAction.sequence([rotate, updateDegreeCounter])
            let repeatLoopOne = SKAction.repeatActionForever(seqOne)
            let seqTwo = SKAction.sequence([rotateBack, updateDegreeCounter])
            let repeatLoopTwo = SKAction.repeatActionForever(seqTwo)
            
            if arrayOfCircleToCreate.sMoves == 1{
                theCircle.runAction(repeatLoopOne)
            }else{
                
                theCircle.runAction(repeatLoopTwo)
            }
            
            //////////////////////////////////////////////////////////////
            //assign array's # from variable
            //infoForLevels[/*levels*/][/*circles*/][/*rDegrees*/ 3] = rDegreeIs
            //CALL WHEN STOPPED (stopping code)
            ///////////////////////////////////////////////////////////////
        }
    }
    func NeverRunThis(){
        //
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    /////////////////////////// user control functions ///////////////////////////
    /////////////////////////////////////////////////////////////////////////////////
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if gameState == .Home{
            //wePressedSomethingOnTheHomePage(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
            
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if levelButton.containsPoint(location) {
                    print("level button tapped!")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    gameState = .CheckingLevels
                    runCheckState()
                }
            }
        }
        if gameState == .PlayGame{
            //wePressedSomethingOnThePlayGamePage(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
            
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if pauseButton.containsPoint(location) {
                    print("pause button tapped!")
                    ///////////////////////////////////////////////////////////////
                    /////////////  pause of ring/nib rotation needed  ///////////////////
                    ///////////////////////////////////////////////////////////////
//
//                    if numRingCounterForLevel >= 0{
//                        theCircle.removeAllActions()
//                    } if numRingCounterForLevel >= 1{
//
//                    } if numRingCounterForLevel >= 2{
//
//                    } if numRingCounterForLevel == 3{
//
//                    } if numRingCounterForLevel == 4{
//
//                    }else{
//
//                    }
					
                    //circleOne.removeAllActions()
                    //circleTwo.removeAllActions()
                    backgroundSFX.volume = 0.2
                    print("game has been paused and current rotations equal ************** ")
                    
                    pauseButton.removeFromParent()
                    print("pauseButton is removed")
                    
                    gameState = .Pause
                    runCheckState()
                    
                }else{
                    self.runAction(clickSound)
    
                    ///////////// put game touch code here
                    
                    
                }
                /*
                 else if counter < 1 && counter >= 0 {
                 circleOne.removeAllActions()
                 counter += 1
                 self.runAction(clickSound)
                 circleOneIsSpinning = false
                 print("the circleOne has stopped moving and the counter's count is \(counter)")
                 
                 }else if counter < 2 && counter >= 1 {
                 circleTwo.removeAllActions()
                 counter += 1
                 self.runAction(clickSound)
                 circleTwoIsSpinning = false
                 print("the circleTwo has stopped moving and the counter's count is \(counter)")
                 
                 }else if counter < 3 &&  counter >= 2 && circleTwoIsSpinning == false && circleOneIsSpinning == false{
                 
                 print("check win/lose states here")
                 //if state = playgame and #of rings/#of rings (all) are stopped proceed to chekingwinorlose
                 //if state = checkingwinorlose call checkwinorlose function
                 
                 counter = 0
                 
                 
                 circleOne.runAction(rotateForever)
                 circleTwo.runAction(rotatecircleTwoForever)
                 print("both the circleOne and the circleTwo have started moving again and the counter's count is \(counter)")
                 }
                 */
            }
        }
        else if gameState == .CheckingWinOrLose {
            return
        }
        else if gameState == .GameOver {
            //wePressedSomethingOnTheGameOverPage(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
            
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if homeButton.containsPoint(location) {
                    print("home button tapped!")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    gameState = .Home
                    runCheckState()
                    
                }else if levelButton.containsPoint(location) {
                    print("level button tapped!")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    gameState = .CheckingLevels
                    runCheckState()
                    
                } else if playButton.containsPoint(location) {
                    print("play button tapped!")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    gameState = .PlayGame
                    runCheckState()
                }
            }
        }
        else if gameState == .CheckingLevels{
            //wePressedSomethingOnTheCheckingLevelsPage(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
            
            
            /////////////////////////////
            
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if homeButton.containsPoint(location) {
                    print("home button tapped!")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    gameState = .Home
                    runCheckState()
                    
                }else if playButton.containsPoint(location) {
                    print("play button tapped!")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    gameState = .PlayGame
                    runCheckState()
                }
            }
        }
        else if gameState == .Pause{
            //wePressedSomethingOnThePausePage(<#T##touches: Set<UITouch>##Set<UITouch>#>, withEvent: <#T##UIEvent?#>)
            
            //fix bug with circleOne stopping--pause--circleOne moving again
            
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                if playButton.containsPoint(location) {
                    print("play button tapped!")
                    
                    ///////////////////////////////////////////////////////////////
                    /////////////  un-pause of ring/nib rotation needed  ///////////////////
                    ///////////////////////////////////////////////////////////////
                   // circleOne.runAction(rotateForever)
                   // circleTwo.runAction(rotatecircleTwoForever)
                    counter = 0
                    
                    addChild(pauseButton)
                    backgroundSFX.volume = 1.0
                    loaderScreen.removeFromParent()
                    print("game has become un-paused & volume/pauseButton re-added")
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    gameState = .PlayGame
                    //runCheckState()
                    
                }else if homeButton.containsPoint(location) {
                    print("home button tapped!")
                    
                    quitCurrentLevel()
                    
                    homeButton.removeFromParent()
                    print("HomeButton is removed")
                    
                    playButton.removeFromParent()
                    print("playButton is removed")
                    
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    backgroundSFX.volume = 1.0
                    loaderScreen.removeFromParent()
                    print("reset values")
                    
                    gameState = .Home
                    
                    runCheckState()
                    
                }else if levelButton.containsPoint(location) {
                    print("level button tapped!")
                    
                    quitCurrentLevel()
                    
                    homeButton.removeFromParent()
                    
                    print("HomeButton is removed")
                    playButton.removeFromParent()
                    
                    print("playButton is removed")
                    levelButton.removeFromParent()
                    print("levelButton is removed")
                    
                    backgroundSFX.volume = 1.0
                    loaderScreen.removeFromParent()
                    print("reset values")
                    
                    gameState = .CheckingLevels
                    runCheckState()
                }
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        //
    }
    
    /////////////////////////// Update Function ///////////////////////////
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
}