//
//  GameScene.swift
//  FI2
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
	
	
	var levelCLicked = 0
	
	
	
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
	
	//	func wePressedSomethingOnTheHomePage(touches: Set<UITouch>, withEvent event: UIEvent?){
	//
	//	}
	
	func weAreOnThePlayGamePage(){
		
		print("we are on the \(gameState) page")
		////testing level
		
		//testLevel()
		
		loadGameLevelSelected()
		
		
		addChild(pauseButton)
		print("pauseButton is created")
	}
	
	//	func wePressedSomethingOnThePlayGamePage(touches: Set<UITouch>, withEvent event: UIEvent?){
	//
	//	}
	
	func weAreOntheCheckingWinOrLosePage(){
		print("we are on the \(gameState) page")
		// bitmap - - - check if pixles = next to you - - - check if center pixel is part of outer pixel group
		//pixels must be x in a row to count (light = x by x dimensions)
		//play animation of light moving outward - - - following pixels
		//		if winState{
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
	
	//	func wePressedSomethingOnTheCheckingLevelsPage(touches: Set<UITouch>, withEvent event: UIEvent?){
	//
	//	}
	
	func weAreOnTheGameOverPage(){
		print("we are on the \(gameState) page")
		
		addChild(playButton)
		print("playButton is created")
		
		addChild(homeButton)
		print("homeButton is created")
		
		addChild(levelButton)
		print("levelsButton is created")
	}
	
	//	func wePressedSomethingOnTheGameOverPage(touches: Set<UITouch>, withEvent event: UIEvent?){
	//
	//	}
	
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
	}
	
	//	func wePressedSomethingOnThePausePage(touches: Set<UITouch>, withEvent event: UIEvent?){
	//
	//	}
	
	/////////////////////////////////////////////////////////////////////////////////
	///////////////////////////  helper functions ///////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	
	func quitCurrentLevel(){
		circleOne.removeFromParent()
		circleTwo.removeFromParent()
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
	}
	
	func loadGameLevelSelected(){
		//remember--
		//rRings is the configuration of the rings
		//rSpeed = duration
		// rNibs = ///NOT USED YET// (sets configuration of the nibs)
		// rDegrees = the counter used to define win scene (from 0 +)
		// rMove = if the direction should be
		//var infoForLevels = [[(rRings: Int, rSpeed: Int, rNibs: Int, rDegrees: Int, rMove: Int)]] ---- array of array of tuple of ints
		
		
		var infoForLevels = [[[0, 60, 0, 0, 1], [0, 4, 0, 0, 1]], [[0, 7, 0, 0, 1], [0, 6, 0, 0, 1], [0, 5, 0, 0, 1]]]
		let arrayOfCircleImages = ["blackRingSetOne", "blackRingSetTwo", "blackRingSetThree", "blackRingSetFour", "blackRingSetFive"]
		let arrayOfNibImages = ["redSquareTestTwo", "redSquareTestTwo", "redSquareTestTwo", "redSquareTestTwo", "RedSquareTestTwo"]
		let arrayOfLevelToPlay = levelCLicked - 1
		
		
		for circleNumber in 0...infoForLevels[arrayOfLevelToPlay].count {
			var rSpeedIs = 2.0
			var rDegreeIs = 0
			
			//assign variable the same # as the array's #
			rSpeedIs = infoForLevels[arrayOfLevelToPlay][circleNumber][1]
			//assign textures to circle and nib
			var theCircle = SKSpriteNode(texture: SKTexture(imageNamed: arrayOfCircleImages[arrayOfLevelToPlay][circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
			var theNib = SKSpriteNode(texture: SKTexture(imageNamed:arrayOfNibImages[circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
			
			addChild(theCircle)
			theCircle.position.x = view!.frame.width / 2
			theCircle.position.y = view!.frame.height / 2
			///////////////////////////////////////////////////////////////
			/////////////  NIB ROTATION AND DUPLICATION NEEDED  ///////////////////
			///////////////////////////////////////////////////////////////
			addChild(theNib)
			theCircle.position.x = view!.frame.width / 2
			theCircle.position.y = view!.frame.height / 2
			
	
			let rotate = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: rSpeedIs)
			let updateNibRotation = SKAction.repeatActionForever(rotate)
			//adding rDegrees incrementally
			let updateCircleRotation = SKAction.runBlock{
				rDegreeIs += 1
				SKAction.repeatActionForever(rotate)
			}
			
			theCircle.runAction(updateCircleRotation)
			theNib.runAction(updateNibRotation)
		}
		//////////////////////////////////////////////////////////////
		//assign array's # from variable
		//infoForLevels[/*levels*/][/*circles*/][/*rDegrees*/ 3] = rDegreeIs
		//CALL WHEN STOPPED
		///////////////////////////////////////////////////////////////
		
		//old test code do no delete
		//print(arrayOfCircleImages[0])
		//print(infoForLevels[0][0][1])
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
					
					circleOne.removeAllActions()
					circleTwo.removeAllActions()
					backgroundSFX.volume = 0.2
					print("game has been paused")
					
					pauseButton.removeFromParent()
					print("pauseButton is removed")
					
					gameState = .Pause
					runCheckState()
					
				}else{
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
					
					circleOne.runAction(rotateForever)
					circleTwo.runAction(rotatecircleTwoForever)
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
		//
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