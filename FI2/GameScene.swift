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
	
	var counter = 0
	var numRingCounterForLevel = 0
	var circleOneIsSpinning = true
	var circleTwoIsSpinning = true
	var theCircleIsSpinning = true
	
	var levelClicked = 2
	
	var circleOne: SKSpriteNode!
	var circleTwo: SKSpriteNode!
	var theCircle: SKSpriteNode!
	
	var rotateForever: SKAction!
	var rotatecircleTwoForever: SKAction!
	
	var loaderScreen: SKSpriteNode!
	
	var backgroundSFX: AVAudioPlayer!
	let clickSound = SKAction.playSoundFileNamed("lockMeTwo", waitForCompletion: false)
	
	let pauseButton = SKSpriteNode(color: UIColor.orangeColor(), size: CGSize(width: 35, height: 35))
	let homeButton = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 35, height: 35))
	let playButton = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: 35, height: 35))
	let levelButton = SKSpriteNode(color: UIColor.yellowColor(), size: CGSize(width: 35, height: 35))
	
	
	let arrayOfCircleImages = ["blackRingSetOne", "blackRingSetTwo", "blackRingSetThree", "blackRingSetFour", "blackRingSetFive"]
	let arrayOfNibImages = ["blackNibSetOne", "blackNibSetTwo", "blackNibSetThree", "blackNibSetFour", "blackNibSetFive"]
	
	var RotationDict = [String: Int]()
	
	var gameState: GameSceneState = .Home
	
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////// basic functions start here //////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	
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
	
	func loadGameLevelSelected(){
		let arrayOfLevelToPlay = Levels.infoForLevels[levelClicked]
		//print("\(arrayOfLevelToPlay) is the different circles (with their perameters) for this level")
		let numRingCounterForLevel = arrayOfLevelToPlay.count - 1
		
		for circleNumber in 0...numRingCounterForLevel {
			let arrayOfCircleToCreate = arrayOfLevelToPlay[circleNumber]
			//print("\(arrayOfCircleToCreate) is the perameters for the circle # \(circleNumber) being created")
			let currentCircleNum = "currentCircleNum_\(circleNumber)"
			//print("\(label)!")
			
			let rSpeedIs = arrayOfCircleToCreate.sSpeed
			let rSpeed = Double(rSpeedIs)
			let rotate = SKAction.rotateByAngle(CGFloat(M_PI) / 6, duration: rSpeed / 6)
			let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI) / -6, duration: rSpeed / 6)
			
			let theCircle = SKSpriteNode(texture: SKTexture(imageNamed: arrayOfCircleImages[circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
			let theNib = SKSpriteNode(texture: SKTexture(imageNamed:arrayOfNibImages[circleNumber]), color: UIColor.blueColor(), size: CGSize(width: 400, height: 400))
			
			if RotationDict[currentCircleNum] != nil{
				RotationDict[currentCircleNum]! += 1
			}else{
				RotationDict[currentCircleNum] = 0
			}
			
			let sprite = theCircle.copy() as! SKSpriteNode
			sprite.name = "theCircle\(circleNumber)"
			print("its name is \(sprite.name)")
			
			self.addChild(sprite)
			
			sprite.position.x = self.frame.width / 2
			sprite.position.y = self.frame.height / 2
			
			///////////////////////////////////////////
			//  NIB ROTATION AND DUPLICATION NEEDED  //
			///////////////////////////////////////////
			
			sprite.addChild(theNib)
			theNib.position.x = sprite.frame.width / 2
			theNib.position.y = sprite.frame.height / 2
			theNib.anchorPoint = CGPointMake(1.0,1.0)
			
			let updateDegreeCounter = SKAction.runBlock{
				self.incrementCircle(currentCircleNum)
			}
			let seqOne = SKAction.sequence([rotate, updateDegreeCounter])
			let repeatLoopOne = SKAction.repeatActionForever(seqOne)
			let seqTwo = SKAction.sequence([rotateBack, updateDegreeCounter])
			let repeatLoopTwo = SKAction.repeatActionForever(seqTwo)
			
			if arrayOfCircleToCreate.sMoves == 1{
				sprite.runAction(repeatLoopOne)
			}else{
				
				sprite.runAction(repeatLoopTwo)
			}
		}
	}
	
	func checkWinOrLose(){
		
		//      for circle in 0...circles{
		//      print("degrees = \(sDegrees) for circle \(circle + 1)")
		//
		//      if winState{
		//              gameState = .CheckingLevels
		//          }else{
		//              gameState = .GameOver
		//      }
	}
	
	///////////////////////////////////////////////////////////////////////////
	//////////////////////  what to do per gamestate.......  //////////////////
	///////////////////////////////////////////////////////////////////////////
	
	func weAreOnTheHomePage(){
		print("we are on the \(gameState) page")
		addChild(levelButton)
		//print("level Button created")
	}
	
	func weAreLeavingTheHomePage(){
		levelButton.removeFromParent()
	}
	
	func weAreOnThePlayGamePage(){
		print("we are on the \(gameState) page")
		
		//testLevel()
		loadGameLevelSelected()
		
		addChild(pauseButton)
	}
	
	func weAreLeavingThePlayGamePage(){
		pauseButton.removeFromParent()
	}
	
	func weAreOnTheCheckingLevelsPage(){
		print("we are on the \(gameState) page")
		
		addChild(homeButton)
		addChild(playButton)
	}
	
	func weAreLeavingtheCheckingLevelsPage(){
		homeButton.removeFromParent()
		playButton.removeFromParent()
	}
	
	func weAreOnTheGameOverPage(){
		print("we are on the \(gameState) page")
		
		addChild(playButton)
		addChild(homeButton)
		addChild(levelButton)
	}
	
	func weAreLeavingTheGameOverPage(){
		playButton.removeFromParent()
		levelButton.removeFromParent()
		homeButton.removeFromParent()
	}
	
	func weAreOnThePausePage(){
		print("we are on the \(gameState) page")
		
		loaderScreen = SKSpriteNode(color: UIColor.whiteColor().colorWithAlphaComponent(0.5), size: CGSize(width: view!.frame.width, height: view!.frame.height))
		loaderScreen.position.x = view!.frame.width / 2
		loaderScreen.position.y = view!.frame.height / 2
		addChild(loaderScreen)
		
		addChild(playButton)
		addChild(levelButton)
		addChild(homeButton)
		
		//////////////////////////////////////////
		// data needed to also check win state  //
		//////////////////////////////////////////
		
		print(RotationDict)
	}
	
	func weAreLeavingThePausePage(){
		homeButton.removeFromParent()
		playButton.removeFromParent()
		levelButton.removeFromParent()
	}
	
	func weAreOntheCheckingWinOrLosePage(){
		print("we are on the \(gameState) page")
		
		checkWinOrLose()
	}
	
	////////////////////////////////////////////////////////////////////////////////
	///////////////////////////  test functions ////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	
	func testLevel(){
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
	
	func testTouch(){
		//////////
		let touch = 1
		//////////
		
		if touch != pauseButton && counter < 1 && counter >= 0 {
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
	}
	
	////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////  helper functions ///////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////
	
	func quitCurrentLevel(){
		
		///////////////////////////////////////
		// deletion ring/nib rotation needed //
		///////////////////////////////////////
		
		//circleOne.removeFromParent()
		//circleTwo.removeFromParent()
		counter = 0
		resetValues()
		print("game progress deleted")
	}
	
	func audioSetUp(){
		let path = NSBundle.mainBundle().pathForResource("fromInside", ofType:".caf")!
		let url = NSURL(fileURLWithPath: path)
		do {
			let sound = try AVAudioPlayer(contentsOfURL: url)
			backgroundSFX = sound
			sound.play()
		} catch {
			print("failedtoload")
		}
		backgroundSFX.numberOfLoops = -1
		backgroundSFX.volume = 1.0
	}
	
	func resetValues(){
		//for when we exit out of a playing game
		backgroundSFX.volume = 1.0
		loaderScreen.removeFromParent()
		print("values are reset")
	}
	
	func incrementCircle(currentCircleNum : String) {
		if let v = RotationDict[currentCircleNum] {
			RotationDict[currentCircleNum]! += 1
		} else {
			RotationDict[currentCircleNum] = 1
		}
		//print("\(currentCircleNum) and \n \(RotationDict)")
	}
	
	func NeverRunThis(){
		//
	}
	
	////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////// user touch functions ////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		/* Called when a touch begins */
		
		if gameState == .Home{
			
			for touch: AnyObject in touches {
				let location = touch.locationInNode(self)
				if levelButton.containsPoint(location) {
					
					weAreLeavingTheHomePage()
					
					gameState = .CheckingLevels
					runCheckState()
				}
			}
		}
		if gameState == .PlayGame{
			
			for touch: AnyObject in touches {
				let location = touch.locationInNode(self)
				if pauseButton.containsPoint(location) {
					// print("pause button tapped!")
					
					/////////////////////////////////////////
					//  pause of ring/nib rotation needed  //
					/////////////////////////////////////////
					
					
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
					
					weAreLeavingThePlayGamePage()
					
					gameState = .Pause
					runCheckState()
					
				}else{
					self.runAction(clickSound)
					
					// testTouch()
					
					let positionInScene = touch.locationInNode(self)
					let touchedNode = self.nodeAtPoint(positionInScene)
					
					
					if let name = touchedNode.name
					{
						if name == Optional("theCircle1")
						{
							print("Touched")
						}
					}
					/////////
					
				}
			}
		}
		else if gameState == .CheckingWinOrLose {
			return
		}
		else if gameState == .GameOver {
			
			for touch: AnyObject in touches {
				let location = touch.locationInNode(self)
				if homeButton.containsPoint(location) {
					
					weAreLeavingTheGameOverPage()
					
					gameState = .Home
					runCheckState()
					
				}else if levelButton.containsPoint(location) {
					
					weAreLeavingTheGameOverPage()
					
					gameState = .CheckingLevels
					runCheckState()
					
				} else if playButton.containsPoint(location) {
					
					weAreLeavingTheGameOverPage()
					
					gameState = .PlayGame
					runCheckState()
				}
			}
		}
		else if gameState == .CheckingLevels{
			
			for touch: AnyObject in touches {
				let location = touch.locationInNode(self)
				if homeButton.containsPoint(location) {
					
					weAreLeavingtheCheckingLevelsPage()
					
					gameState = .Home
					runCheckState()
					
				}else if playButton.containsPoint(location) {
					
					weAreLeavingtheCheckingLevelsPage()
					
					gameState = .PlayGame
					runCheckState()
				}
			}
		}
		else if gameState == .Pause{
			
			//fix bug with circleOne stopping--pause--circleOne moving again
			for touch: AnyObject in touches {
				let location = touch.locationInNode(self)
				if playButton.containsPoint(location) {
					
					////////////////////////////////////////////
					//  un-pause of ring/nib rotation needed  //
					////////////////////////////////////////////
					
					// circleOne.runAction(rotateForever)
					// circleTwo.runAction(rotatecircleTwoForever)
					counter = 0
					
					addChild(pauseButton)
					print("game has become un-paused")
					
					weAreLeavingThePausePage()
					
					resetValues()
					
					gameState = .PlayGame
					runCheckState()
					
				}else if homeButton.containsPoint(location) {
					
					weAreLeavingThePausePage()
					
					quitCurrentLevel()
					
					gameState = .Home
					runCheckState()
					
				}else if levelButton.containsPoint(location) {
					
					weAreLeavingThePausePage()
					
					quitCurrentLevel()
					
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
	
	///////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////// Update Functions ////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////
	
	override func update(currentTime: CFTimeInterval) {
		/* Called before each frame is rendered */
		
	}
	
}