﻿//Issue is with the enter frame + enemiesLeft, as it quickly goes through the end of each level without pause, skipping waves 2 - 6.//Directions screen (Done)//win/lose? (Close Enough)//csh code hub?//more enemies (Done)//Upgrade turrets (Done)//art?//seminar//Howland wants me to FIX the game.//error 1010 = enemyArray[currentLvl-1] == nullpackage code {		import flash.display.MovieClip;	import flash.display.Sprite	import flash.display.Shape	import flash.display.Stage;	import flash.display.SimpleButton;	import flash.events.*	import flash.text.*			public class Document extends MovieClip {				var currentLvl:int = 1;		public var gameOver:Boolean = false;				var currentEnemy:int = 0;//the current enemy that we're creating from the array		var enemyTime:int = 0;//how many frames have elapsed since the last enemy was created		var enemyLimit:int = 12;//how many frames are allowed before another enemy is created		var enemyArray:Array = [//defining the array				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],//1's will just represent an enemy to be created				[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],//another row means another level				[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],				[2,3,5,2,3,5,2,3,5,5,3,2,5,3,2,2,5,3],				[100],				[5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5],				[100,250,100]			];//this array will tell the function when to create an enemy		var enemiesLeft:int;//how many enemies are left on the field					var startDir:String = 'RIGHT';//the direction the enemies go when they enter		var finDir:String;//the direction the enemies go when they exit		var startCoord:int;//the coordinates of the beginning of the road		var lvlArray:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,R,1,1,D,0,R,1,1,D,0,0,0,0,0,0,						S,R,1,1,1,1,1,U,0,0,1,0,1,0,0,1,0,R,1,1,D,0,						0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,1,0,0,1,0,						0,0,0,D,1,1,1,1,1,1,L,0,1,0,0,R,1,U,0,D,L,0,						0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,						0,0,0,1,0,0,0,0,0,0,R,1,U,0,D,1,1,1,1,L,0,0,						0,0,0,R,1,1,D,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,						0,0,0,0,0,0,1,0,0,0,1,0,D,1,L,0,0,0,R,1,1,F,						0,0,0,0,0,0,R,D,0,0,1,0,1,0,0,0,0,0,1,0,0,0,						0,0,0,0,0,0,0,R,1,1,U,0,R,1,1,1,1,1,U,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						];//this array will hold the formatting of the roads								var lvlArray2:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						S,R,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,F,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						];								var lvlArray3:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,R,1,1,D,0,0,R,1,1,D,0,0,R,1,1,D,0,0,						0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,						0,0,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,						S,D,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,R,1,F,						0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,						0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,						0,R,1,1,U,0,0,R,1,1,U,0,0,R,1,1,U,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,						];				var enemyHolder:Sprite = new Sprite();		var roadHolder:Sprite = new Sprite();//create an object that will hold all parts of the road				var money:int=100;//how much money the player has to spend on turrets		var lives:int=20;//how many lives the player has				public var rangeCircle:Shape = new Shape();				var S:String = 'START';		var F:String = 'FINISH';		var U:String = 'UP';		var R:String = 'RIGHT';		var D:String = 'DOWN';		var L:String = 'LEFT';				private var help:HelpScreen;		public var help_btn:SimpleButton;				public function Document() {						// constructor code									StartScreen_mc.Start_btn.addEventListener(MouseEvent.CLICK, beginGame);		}				private function onHelp(e:MouseEvent):void //Calls forth the helpful screen.		{			addChild(help);					}				public function beginGame(e:MouseEvent):void			{				addChild(roadHolder);//add it to the stage				roadHolder.visible = true;				StartScreen_mc.visible = false;				trace("I've been Clicked!");//				removeEventListener(Event.MouseEvent.CLICK, beginGame);									//Range Circle			rangeCircle.graphics.beginFill(0x006600,.5);			rangeCircle.graphics.drawCircle(12.5,12.5,100);			rangeCircle.graphics.endFill();						//run these functions at the start						makeRoad();			addChild(enemyHolder); //Keep this after "makeRoad(); else enemies go behind DirectBlocks();			addEventListener(Event.ENTER_FRAME, eFrame);//adding an eFrame function			addEventListener(Event.ENTER_FRAME, updateText);			startGame();			}									public function eFrame(e:Event):void{			//if there aren't any levels left			if(currentLvl > enemyArray.length){				gameOver=true;//set the game to be over				trace(gameOver);								//reset all the stats				currentLvl = 1;				currentEnemy = 0;				enemyTime = 0;				enemyLimit = 12;				enemiesLeft = 0;								removeEventListener(Event.ENTER_FRAME, eFrame);//remove this listener				removeEventListener(Event.ENTER_FRAME, updateText);				removeChild(roadHolder);//remove the pieces of road				gotoAndStop('win');//go to the win frame			}			if(lives<=0){//if the user runs out of lives				gameOver=true;//set the game to be over								//reset all the stats				currentLvl = 1;				currentEnemy = 0;				enemyTime = 0;				enemyLimit = 12;				enemiesLeft = 0;								removeEventListener(Event.ENTER_FRAME, eFrame);//remove this listener				removeChild(roadHolder);//remove the pieces of road				gotoAndStop('lose');//go to the lose frame			}						makeEnemies();//we'll just make some enemies						if(enemiesLeft==0){//if there are no more enemies left				currentLvl ++;//continue to the next level				startGame();//restart the game				currentEnemy = 0;//reset the amount of enemies there are			}		}				public function updateText(e:Event):void		{			//Updating the text fields			txtLevel.text = 'Level '+ currentLvl;			txtMoney.text = '$'+ money;			txtLives.text = 'Lives: '+ lives;			txtEnemiesLeft.text = 'Enemies Left:  '+ enemiesLeft;		}					public function startGame():void			{//we'll run this function every time a new level begins				trace("Current Level = " + currentLvl);				if(enemyArray[currentLvl-1] != null)				{					for(var i:int=0;i<enemyArray[currentLvl-1].length;i++)					{						if(enemyArray[currentLvl-1][i] != 0)						{							enemiesLeft ++;							trace("Enemies Left = " + enemiesLeft);						}					}				}				else if (enemyArray[currentLvl-1] == null && lives > 0)				{					gameOver=true;//set the game to be over					trace(gameOver);										//reset all the stats					currentLvl = 1;					currentEnemy = 0;					enemyTime = 0;					enemyLimit = 12;					enemiesLeft = 0;										removeEventListener(Event.ENTER_FRAME, eFrame);//remove this listener					removeEventListener(Event.ENTER_FRAME, updateText);					roadHolder.visible = false;//remove the pieces of road					//removeChild(rangeCircle);					//removeChild(enemyHolder);					gotoAndStop('win');//go to the win frame				}				else if (enemyArray[currentLvl-1] == null && lives == 0)				{					gameOver=true;//set the game to be over										//reset all the stats					currentLvl = 1;					currentEnemy = 0;					enemyTime = 0;					enemyLimit = 12;					enemiesLeft = 0;										removeEventListener(Event.ENTER_FRAME, eFrame);//remove this listener					roadHolder.visible = false;//remove the pieces of road					gotoAndStop('lose');//go to the lose frame				}							}				public function makeRoad():void		{			var row:int = 0;//the current row we're working on			var block;//this will act as the block that we're placing down						for(var i:int=0;i<lvlArray.length;i++)			{//creating a loop that'll go through the level array				if(lvlArray[i] == 0){//if the current index is set to 0					block = new EmptyBlock();//create a gray empty block					block.graphics.beginFill(0x333333);					block.graphics.drawRect(0,0,25,25);					block.graphics.endFill();					addChild(block);					//and set the coordinates to be relative to the place in the array					block.x= (i-row*22)*25;					block.y = row*25;				} 				else if(lvlArray[i] == 1){//if there is supposed to be a row					//just add a box that will be a darker color and won't have any actions					block = new Shape();					block.graphics.beginFill(0x111111);					block.graphics.drawRect(0,0,25,25);					block.graphics.endFill();							block.x= (i-row*22)*25;					block.y = row*25;						roadHolder.addChild(block);//add it to the roadHolder				} 				else if(lvlArray[i] is String){//if it's a string, meaning a special block					//then create a special block					block = new DirectBlock(lvlArray[i],(i-row*22)*25,row*25);					addChild(block);				}				for(var c:int = 1;c<=16;c++){					if(i == c*22-1)					{						//if 22 columns have gone by, then we move onto the next row						row++;					}				}			}		}		public function makeTurret(xValue:int,yValue:int):void		{//this will need to be told the x and y values			var turret:Turret = new Turret();//creating a variable to hold the Turret			//changing the coordinates			turret.x = xValue+12.5;			turret.y = yValue+12.5;			addChild(turret);//add it to the stage		}		public function makeEnemies():void{//this function will add enemies to the field			if(enemyTime < enemyLimit){//if it isn't time to make them yet				enemyTime ++;//then keep on waiting			} else {//otherwise				var theCode:int = enemyArray[currentLvl-1][currentEnemy];//get the code from the array				if(theCode != 0){//if it isn't an empty space					var newEnemy:Enemy = new Enemy(theCode);//then create a new enemy and pass in the code					enemyHolder.addChild(newEnemy);//and add it to the enemyholder				}				currentEnemy ++;//move on to the next enemy				enemyTime = 0;//and reset the time			}		}		//public function restartGame(e:MouseEvent):void//		{//			gotoAndStop(1)//			stage.removeEventListener(MouseEvent.CLICK,restartGame);//			trace('Derp');//		}				}		}