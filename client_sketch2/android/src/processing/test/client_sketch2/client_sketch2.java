package processing.test.client_sketch2;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.apache.commons.codec.binary.*; 
import org.apache.commons.codec.*; 
import org.apache.commons.codec.digest.*; 
import org.apache.commons.codec.language.*; 
import org.apache.commons.codec.net.*; 
import org.apache.commons.logging.impl.*; 
import org.apache.commons.logging.*; 
import org.apache.http.impl.cookie.*; 
import org.apache.http.impl.client.*; 
import org.apache.http.impl.conn.tsccm.*; 
import org.apache.http.impl.conn.*; 
import org.apache.http.impl.auth.*; 
import org.apache.http.cookie.*; 
import org.apache.http.cookie.params.*; 
import org.apache.http.annotation.*; 
import org.apache.http.client.*; 
import org.apache.http.client.methods.*; 
import org.apache.http.client.params.*; 
import org.apache.http.client.utils.*; 
import org.apache.http.client.protocol.*; 
import org.apache.http.client.entity.*; 
import org.apache.http.conn.*; 
import org.apache.http.conn.util.*; 
import org.apache.http.conn.ssl.*; 
import org.apache.http.conn.params.*; 
import org.apache.http.conn.routing.*; 
import org.apache.http.conn.scheme.*; 
import org.apache.http.auth.*; 
import org.apache.http.auth.params.*; 
import org.apache.http.impl.client.cache.*; 
import org.apache.http.impl.client.cache.memcached.*; 
import org.apache.http.impl.client.cache.ehcache.*; 
import org.apache.http.client.cache.*; 
import org.apache.http.*; 
import org.apache.http.util.*; 
import org.apache.http.io.*; 
import org.apache.http.impl.*; 
import org.apache.http.impl.io.*; 
import org.apache.http.impl.entity.*; 
import org.apache.http.message.*; 
import org.apache.http.params.*; 
import org.apache.http.protocol.*; 
import org.apache.http.entity.*; 
import org.apache.http.entity.mime.*; 
import org.apache.http.entity.mime.content.*; 
import http.requests.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class client_sketch2 extends PApplet {

/*

API

/whosThere
Returns:
  * # players
  * array of player names
  

/join
Takes: name
Returns: nothing


/startGame
Takes: nothing
Returns: nothing
Tell server to switch from waiting for players and start a game


/whoseTurn
Takes: nothing
Returns: the number of the player whose turn it is


/changeTurn
Takes: nothing
Returns: nothing


/getCountryInfo
Returns: everything about countries that doens't change during a game
  * names
  * connected countries
  

/getGameState
Returns: everything that might change during a game
  * num troops per country
  * coutnry owners
  * num cards per person


/getMyCards
Returns:
  * type, country of each card you own


/attack -- one round of combat
Take:
  * name of target
  * name of source
Returns:
  * number of target troops killed
  * number of source troops killed
  * attack dice values
  * defense dice values
  



*/

public void setup() {
  //size(926,563);
 // surface.setResizable(true);
 
  
  frameRate(10);
  map = loadImage(/*/* dir + */ "map.png");
  card_images= new PImage[]{
  loadImage(/* dir + */ "AfghanistanRiskCard.jpeg"),
  loadImage(/* dir + */ "AlaskaRiskCard.jpeg"),
  loadImage(/* dir + */ "AlbertaRiskCard.jpeg"),
  loadImage(/* dir + */ "ArgentinaRiskCard.jpeg"),
  loadImage(/* dir + */ "BrazilRiskCard.jpeg"), 
  loadImage(/* dir + */ "CentralAmericaRiskCard.jpeg"),
  loadImage(/* dir + */ "ChinaRiskCard.jpeg"),
  loadImage(/* dir + */ "CongoRiskCard.jpeg"),
  loadImage(/* dir + */ "EastAfricaRiskCard.jpeg"),
  loadImage(/* dir + */ "EasternAustraliaRiskCard.jpeg"),   
  loadImage(/* dir + */ "EasternUnitedStatesRiskCard.jpeg"),
  loadImage(/* dir + */ "EgyptRiskCard.jpeg"),
  loadImage(/* dir + */ "UnitedKingdomRiskCard.jpeg"),
  loadImage(/* dir + */ "GreenlandRiskCard.jpeg"),
  loadImage(/* dir + */ "IcelandRiskCard.jpeg"), 
  loadImage(/* dir + */ "IndiaRiskCard.jpeg"),
  loadImage(/* dir + */ "IndonesiaRiskCard.jpeg"),
  loadImage(/* dir + */ "IrkutskRiskCard.jpeg"),
  loadImage(/* dir + */ "JapanRiskCard.jpeg"),
  loadImage(/* dir + */ "KamchatkaRiskCard.jpeg"), 
  loadImage(/* dir + */ "MadagascarRiskCard.jpeg"),
  loadImage(/* dir + */ "MiddleEastRiskCard.jpeg"),
  loadImage(/* dir + */ "MongoliaRiskCard.jpeg"),
  loadImage(/* dir + */ "NewGuineaRiskCard.jpeg"),
  loadImage(/* dir + */ "NorthAfricaRiskCard.jpeg"), 
  loadImage(/* dir + */ "NorthernEuropeRiskCard.jpeg"),
  loadImage(/* dir + */ "NorthwestTerritoryRiskCard.jpeg"),
  loadImage(/* dir + */ "OntarioRiskCard.jpeg"),
  loadImage(/* dir + */ "PeruRiskCard.jpeg"),
  loadImage(/* dir + */ "QuebecRiskCard.jpeg"),   
  loadImage(/* dir + */ "ScandanaviaRiskCard.jpeg"),
  loadImage(/* dir + */ "SiamRiskCard.jpeg"),
  loadImage(/* dir + */ "SiberiaRiskCard.jpeg"),
  loadImage(/* dir + */ "SouthAfricaRiskCard.jpeg"),
  loadImage(/* dir + */ "SouthernEuropeRiskCard.jpeg"), 
  loadImage(/* dir + */ "UkraineRiskCard.jpeg"),
  loadImage(/* dir + */ "UralRiskCard.jpeg"),
  loadImage(/* dir + */ "VenezuelaRiskCard.jpeg"),
  loadImage(/* dir + */ "WesternAustraliaRiskCard.jpeg"),
  loadImage(/* dir + */ "WesternEuropeRiskCard.jpeg"), 
  loadImage(/* dir + */ "WesternUnitedStatesRiskCard.jpeg"),
  loadImage(/* dir + */ "WildCardRiskCard.jpeg"),
  loadImage(/* dir + */ "WildCardTwoRiskCard.jpeg"),
  loadImage(/* dir + */ "YakutskRiskCard.jpeg")
};
 horse_images= new PImage[]{
  loadImage(/* dir + */ "Pink Horse.png"),
  loadImage(/* dir + */ "Red Horse.png"),
  loadImage(/* dir + */ "Blue Horse.png"),
  loadImage(/* dir + */ "Yellow Horse.png"),
  loadImage(/* dir + */ "Green Horse.png"), 
  loadImage(/* dir + */ "horse.png")
};
 soldier_images= new PImage[]{
  loadImage(/* dir + */ "Pink Soldier.png"),
  loadImage(/* dir + */ "Red Soldier.png"),
  loadImage(/* dir + */ "Blue Soldier.png"),
  loadImage(/* dir + */ "Yellow Soldier.png"),
  loadImage(/* dir + */ "Green Soldier.png"),
  loadImage(/* dir + */ "soldier.png")
};
 cannon_images=new PImage[]{
  loadImage(/* dir + */ "Pink Cannon.png"),
  loadImage(/* dir + */ "Red Cannon.png"),
  loadImage(/* dir + */ "Blue Cannon.png"),
  loadImage(/* dir + */ "Yellow Cannon.png"),
  loadImage(/* dir + */ "Green Cannon.png"),
  loadImage(/* dir + */ "cannon.png")
};
 dice_images = new PImage[]{
  loadImage(/* dir + */ "die_face_1.png"),
  loadImage(/* dir + */ "die_face_2.png"),
  loadImage(/* dir + */ "die_face_3.png"),
  loadImage(/* dir + */ "die_face_4.png"),
  loadImage(/* dir + */ "die_face_5.png"),
  loadImage(/* dir + */ "die_face_6.png"),
};
 attack_dice_images = new PImage[]{
  loadImage(/* dir + */ "Attack Die 1.jpg"),
  loadImage(/* dir + */ "Attack Die 2.jpg"),
  loadImage(/* dir + */ "Attack Die 3.jpg"),
  loadImage(/* dir + */ "Attack Die 4.jpg"),
  loadImage(/* dir + */ "Attack Die 5.jpg"),
  loadImage(/* dir + */ "Attack Die 6.jpg"),
};
}


public JSONObject get(String url) {
  return get(url, new String[]{});
}

public JSONObject get(String url, String[] args) {
  //println("Making request to: " + url + ", with " + args.length / 2 + " arguments.");
  for (int i = 0; i < args.length; i += 2) {
    //println("    " + args[i] + " --> " + args[i+1]);
  }
  GetRequest get = new GetRequest("http://localhost:8000/" + url, args);
  get.send();
  
  String response = get.getContent();
  //println("    Response Content: " + response);
  
  if (response == null) {
    return null;
  }
  JSONObject obj = parseJSONObject(response);
  return obj;
}
//TODO
//make start button based on the risk card selection -- done
//pull over relevant parts of keypressed and mouseclicked
//fix continent troop bonus -- done
//draw info box -- error
//draw riskcards -- fix syntax for is selected and for drawing cards using arraylist of names
//get world isSelected might be wrong
// numsetupturns also maybe wrong
//placetroop lcountry and redeemcard maybe wrong syntax 
//issue with getInt("numTroops")++;

// set up phase not always allowing place troops | fixed
// unlimited fortification | fixed
// color in gray box not correct | fixed
// no backwards fortification | fixed
// source and target country does not clear | fixed by x press if it gets stuck
// cant select target country | appears to be fixed
//cards cant be selected  | fixed
  


//cant attack when calling real draw dice



//ring dir = This PC\Nexus 6P\Processing Sketches\New Folder\client_sketch2\data
//String dir = "C:/Users/fuady/Desktop/Risk Stuff/Processing/risk/risk_main_p2/data//";
//String dir = "/Users/Nextcell/Desktop/Risk Stuff/Processing/risk/risk_main/data/";
PImage map;
PImage card_images[];
PImage horse_images[];
PImage soldier_images[];
PImage cannon_images[];
PImage dice_images[];
PImage attack_dice_images[];
Country lastClickedCountry = null;
boolean titleScreen = true;
int IMAGE_SIZE = 30;
JSONObject lCountry = null;
JSONObject sCountry = null;
JSONObject tCountry= null;
JSONObject clientPlayer = null;
boolean nameEntered = false;
String clientName = "Fuad";
ArrayList<String> clientRiskCards = new ArrayList<String>();
class Country {
  public Country(String name, int x, int y, int ignored) {
    this.name = name;
    this.x = x;
    this.y = y;
  }
  public int x, y;
  public String name;
}


Country[] allCountries = {
  new Country("Alaska", 88, 99, 0),
  new Country("Northwest Territory", 163, 89, 0),
  new Country("Greenland", 319, 70, 0),
  new Country("Alberta", 157, 145, 0),
  new Country("Ontario", 213, 157, 0),
  new Country("Quebec", 269, 159, 0),
  new Country("Western US", 160, 208, 0),
  new Country("Eastern US", 223, 225, 0),
  new Country("Central America", 166, 264, 0),
  new Country("Venezuela", 230, 321, 1),
  new Country("Peru", 248, 390, 1),
  new Country("Argentina", 249, 442, 1),
  new Country("Brazil", 291, 365, 1),
  new Country("Indonesia", 696, 414, 5),
  new Country("New Guinea", 782, 395, 5),
  new Country("Eastern Australia", 789, 459, 5),
  new Country("Western Australia", 741, 491, 5),
  new Country("North Africa", 418, 347, 3),
  new Country("Egypt", 482, 325, 3),
  new Country("Central Africa", 476, 417, 3),
  new Country("East Africa", 518, 382, 3),
  new Country("South Africa", 487, 484, 3),
  new Country("Madagascar", 551, 493, 3),
  new Country("Iceland", 372, 123, 2),
  new Country("United Kingdom", 379, 184, 2),
  new Country("Western Europe", 390, 269, 2),
  new Country("Scandanavia", 461, 106, 2),
  new Country("Northern Europe", 448, 199, 2),
  new Country("Southern Europe", 459, 237, 2),
  new Country("Russia", 527, 151, 2),
  new Country("Middle East", 548, 285, 4),
  new Country("India", 633, 292, 4),
  new Country("Southeast Asia", 697, 318, 4),
  new Country("Afghanistan", 588, 223, 4),
  new Country("China", 693, 260, 4),
  new Country("Irkutsk", 699, 151, 4),
  new Country("Mongolia", 700, 201, 4),
  new Country("Japan", 790, 206, 4),
  new Country("Ural", 607, 143, 4),
  new Country("Siberia", 652, 105, 4),
  new Country("Yakutsk", 715, 75, 4),
  new Country("Kamchatka", 784, 79, 4)
};
class riskCard {
  public riskCard(String cardName, int type){
    this.cardName = cardName;
    this.type= type;
    this.xLocation = -1;
    this.isSelected= false;
  }
  public String cardName;
  public int type;
  public int xLocation;
  public boolean isSelected;
}
  
 riskCard[] allRiskCards = {
   //types: 0 = Soldier, 1 = Calvary, 2 = Cannon, 3 = wild card
   new riskCard("Afghanistan", 0),
   new riskCard("Alaska", 0),
   new riskCard("Alberta", 0),
   new riskCard("Argentina", 0),
   new riskCard("Brazil", 2),
   new riskCard("Central America", 1),
   new riskCard("China", 1),
   new riskCard("Central Africa", 1),
   new riskCard("East Africa", 2),
   new riskCard("Eastern Australia", 0),
   new riskCard("Eastern US", 2),
   new riskCard("Egypt", 0),
   new riskCard("United Kingdom", 1),
   new riskCard("Greenland", 1),
   new riskCard("Iceland", 0),
   new riskCard("India", 0),
   new riskCard("Indonesia", 1),
   new riskCard("Irkutsk", 0),
   new riskCard("Japan", 0),
   new riskCard("Kamchatka", 1),
   new riskCard("Madagascar", 0),
   new riskCard("Middle East", 2),
   new riskCard("Mongolia", 2),
   new riskCard("New Guinea", 1),
   new riskCard("North Africa", 0),
   new riskCard("Northern Europe", 1),
   new riskCard("Northwest Territory", 2),
   new riskCard("Ontario", 1),
   new riskCard("Peru", 1),
   new riskCard("Quebec", 2),
   new riskCard("Scandanavia", 2),
   new riskCard("Siam", 2),
   new riskCard("Siberia", 2),
   new riskCard("South Africa", 2),
   new riskCard("Southern Europe", 1),
   new riskCard("Ukraine", 2),
   new riskCard("Ural", 1),
   new riskCard("Venezuela", 2),
   new riskCard("Western Australia", 2),
   new riskCard("Western Europe", 0),
   new riskCard("Western US", 0),
   new riskCard("Wild Card 1", 3),
   new riskCard("Wild Card 2", 3),
   new riskCard("Yakutsk", 1)
 };
class Die {
  int x;
  int y;
  int xVel;
  int yVel;
  int whichDie;
  int degreeRotation;
  boolean isAttack;
}

class DiceAnimationState {
  int numFrames;
  boolean paused;
  //int speedMultiplier;
  Die[] dice;
}

DiceAnimationState dice_animation = null;

public void setupDice(int numAttack, int numDefense) {
  dice_animation = new DiceAnimationState();
  
  dice_animation.dice = new Die[numAttack + numDefense];
  
  for (int i = 0; i < numAttack + numDefense; i++) {
    Die die = new Die();
    die.x = 70 * i;
    die.y = 70 * i;
    die.xVel = die.yVel = VELOCITY;
    die.whichDie = (int)random(6);
    die.isAttack = i < numAttack;
    die.degreeRotation = (int)random(30);
    
    dice_animation.dice[i] = die;
  }
}


//int x = 0; 
//int y = 0;
//int ax =100;
//int ay = 100;

int VELOCITY = 15;

public void drawTitleScreen() {
  int y = 50;
  fill(200,200,200);
  rect(0,0, 2000, 2000);
  fill(255, 255, 255);
  textSize(20);
  text("Enter your name: " , 250, y);
  fill(200, 150, 50);
  text(my_name + "|", 450, y);

  y+=50;
  JSONObject result = get("numPlayers");
  if (result == null) {
    text("Error with finding other players", 100, y);
    return;
  }
  JSONArray playerNames = result.getJSONArray("players");
  for (int i = 0; i < result.getInt("numPlayers"); i++) {
      fill(255, 255, 255);
      text(i+1+"." + "   " + playerNames.getString(i), 250, y+ 50*i);
  }
  fill(255, 255, 255);
  rect(800, 400, 125, 100);
  fill(0, 0, 0);
  textSize(13);
  text("click here to start", 800, 420);
}

public Country findCountryByName(String name) {
  for (Country c : allCountries) {
    if (c.name.equals(name)) {
      return c;
    }
  }
  return null;
}

public void draw() {
  drawTitleScreen();
   JSONObject worldData = get("getWorld");
   JSONArray allJCountries = worldData.getJSONArray("allCountries"); 
  if(titleScreen==false){
     //image(map, 0, 0, width, height);
     scale(1.3f, 1.3f);
     image(map, 0, 0, 926, 563);
    for (int i = 0; i < allJCountries.size(); i++) {
      JSONObject c = allJCountries.getJSONObject(i);
      Country clientCountry = findCountryByName(c.getString("name"));
      drawTroops(c.getInt("numTroops"), clientCountry.x - IMAGE_SIZE, clientCountry.y - IMAGE_SIZE, c.getJSONObject("owningPlayer").getInt("clr"));
    } 
      for(int i = 0; i < worldData.getJSONArray("gamePlayers").size(); i++){
      fill(150, 150, 153);
      rect(3, 417, 220, 200); 
      fill(222, 2, 222);
      textSize(12);
      if(worldData.getInt("setupTurns") <worldData.getInt("numSetupTurns")){
       text(worldData.getJSONObject("curPlayer").getString("name") + 
           " Troops\n" + "turn " + worldData.getInt("setupTurns") + " out of " + worldData.getInt("numSetupTurns") + " setup turns", 3, 450);
        drawTroops(1, 3, 500, worldData.getJSONObject("curPlayer").getInt("clr"));
      } else {
        text(worldData.getJSONObject("curPlayer").getString("name") + " \n" + "turn phase equals " + worldData.getInt("turnPhase") + " \n" + "Owns " + worldData.getInt("realNumCountry") + " countries", 3, 450); 
        drawTroops(worldData.getInt("remainingTroops"), 3, 500, worldData.getJSONObject("curPlayer").getInt("clr"));
      }
    }
  }
  if (lCountry != null) {
    fill(255, 0, 0);
    ellipse(lastClickedCountry.x, lastClickedCountry.y, 10, 10);
    fill(255, 255, 2);
    /*for(int i=0; i < lastClickedCountry.connectedCountries.size(); i++){
      Country c = lastClickedCountry.connectedCountries.get(i);
      ellipse(c.x, c.y, 7, 7);
    }*/
  } 
  if ( sCountry != null) {
    Country sourceCountry = null;
    for(int i = 0; i < allCountries.length; i++){
      if(sCountry.getString("name").equals(allCountries[i].name)){
       sourceCountry =  allCountries[i];
      }
    }
    fill(0, 255, 0);
    ellipse(sourceCountry.x, sourceCountry.y, 12, 12);
  }
  if (tCountry != null) {
    Country targetCountry = null;
    for(int i = 0; i < allCountries.length; i++){
      if(tCountry.getString("name").equals(allCountries[i].name)){
       targetCountry =  allCountries[i];
      }
    }
    fill(0, 0, 255);
    ellipse(targetCountry.x, targetCountry.y, 12, 12);
  }
  for(int i = 0; i < worldData.getJSONArray("gamePlayers").size(); i ++){
    if(worldData.getJSONArray("gamePlayers").getJSONObject(i).getString("name").equals(clientName)){
      clientPlayer = worldData.getJSONArray("gamePlayers").getJSONObject(i);
    }
  }
  if(!worldData.isNull("curPlayer") && worldData.getJSONObject("curPlayer").getString("name").equals(clientName) && worldData.getJSONObject("curPlayer").getInt("playerCardsWon")>0){
   int x = 70;
   int y = 475;
   
    for(int i = 0; i < worldData.getJSONArray("allRiskCards").size(); i++){
      //clientRiskCards = new Arraylist<Stinrg>();
      JSONObject riskCard = worldData.getJSONArray("allRiskCards").getJSONObject(i);
      if(!riskCard.isNull("owningPlayer") && riskCard.getJSONObject("owningPlayer").getString("name").equals(clientPlayer.getString("name"))){
        image(card_images[i], x, y, 50, 75);
        //cRiskCardx = x;
        if(allRiskCards[i].cardName.equals(riskCard.getString("cardName"))){
          allRiskCards[i].xLocation = x;
        }
        //for(int j = 0; j < allRiskCards.length; j++){
        //  if(allRiskCards[j].cardName.equals(riskCard.getString("cardName"))){
        //    allRiskCards[j].xLocation = x;
        //  }
        //}
        if(riskCard.getBoolean("isSelected")){
          fill(255,0,0);
          ellipse(x+25,525, 12, 12);
        }
        x+=55;
      }
    }
  }
  if(!worldData.isNull("attackDice") && !worldData.isNull("defenseDice")){
  if((worldData.getInt("turnPhase")> 0)&& sCountry != null && tCountry!= null){
    for(int i = 0; i < worldData.getJSONArray("attackDice").size(); i++){
       drawAttackDie(worldData.getJSONArray("attackDice").getInt(i), 50* i, 310);
   }
   for(int i = 0; i < worldData.getJSONArray("defenseDice").size(); i++){
     drawDie(worldData.getJSONArray("defenseDice").getInt(i), 50*i, 360);
   }
  }
  }
}

public void drawTroops(int numTroops, int x, int y, int clr) {
  drawTroops(numTroops/10, (numTroops % 10) / 5, numTroops % 5, x, y, clr);
}

public void drawTroops(int cannons, int horses, int soldiers, int x, int y, int clr){
 
  if (soldiers == 0 && horses == 0){
 for (int i=0; i < cannons; i++) {
    image(cannon_images[clr], x + i*IMAGE_SIZE/2, y, IMAGE_SIZE, IMAGE_SIZE);
    }
  } 
 
else{
  for (int i=0; i < cannons; i++) {
    image(cannon_images[clr], x + i*IMAGE_SIZE/2, y + IMAGE_SIZE*.8f, IMAGE_SIZE, IMAGE_SIZE);
  }
}

 if (soldiers == 0 ){
  for (int i=0; i < horses; i++) {
    image(horse_images[clr], x + i*IMAGE_SIZE/2, y, IMAGE_SIZE, IMAGE_SIZE);
    }
  } 
 
  for (int i=0; i < soldiers; i++) {
    image(soldier_images[clr], x + i*IMAGE_SIZE/2, y, IMAGE_SIZE, IMAGE_SIZE);
  }
  if (soldiers > 0 ){
 for (int i=0; i < horses; i++) {
   image(horse_images[clr], x + i*IMAGE_SIZE/2 + soldiers*IMAGE_SIZE/2 , y, IMAGE_SIZE, IMAGE_SIZE);
    }
  }

}
String my_name="";

public void titleScreenKeyPressed() {
  JSONObject worldData = get("getWorld");
  boolean uniqueName = true;
  if(worldData.getJSONArray("gamePlayers")!=null){
    for(int i = 0; i <worldData.getJSONArray("gamePlayers").size(); i++){
      if(worldData.getJSONArray("gamePlayers").getJSONObject(i).getString("name").equals(my_name)){
        uniqueName = false;
      }
    }
  }
  if( nameEntered == false && keyCode == ENTER && uniqueName == true ) {
    nameEntered = true;
    clientName= my_name;
    get("join", new String[]{"name", my_name});
    my_name = "";
    return;
  }
  if(nameEntered == false && keyCode == BACKSPACE && my_name.length() != 0 ){
    my_name = my_name.substring(0, my_name.length()-1);
  }
  else if(nameEntered == false && ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z'))) {
    my_name = my_name + key; 
  }
}
public void realDrawDice() {
  while(dice_animation.numFrames < 50){
    fill(200,200,200);
    rect(0,0, 2000, 2000);
    
    stroke(0, 255, 0);
    rect(50, 50, 826, 463);
  
  
    for (int i = 0; i < dice_animation.dice.length; i++) {
      Die curDie = dice_animation.dice[i];
      pushMatrix();
      translate(curDie.x, curDie.y);
      rotate(radians(curDie.degreeRotation));
      fill(0, 255, 0);
      if (curDie.isAttack) {
        image(attack_dice_images[curDie.whichDie], -50, -50, 100, 100);
      } else {
        image(dice_images[curDie.whichDie], -50, -50, 100, 100);
      }
      ellipse(0, 0, 5, 5);
      popMatrix();
    }
    
     
    //pushMatrix();
    //translate(ax, ay);
    //rotate(radians(degreeRotation));
    //image(attack_dice_images[aWhichDie], -50, -50, 100, 100);
    //popMatrix();
  
  
    
    dice_animation.numFrames++;
    
    if (!dice_animation.paused) {
      for(int i = 0; i < dice_animation.dice.length; i++){
        Die curDie = dice_animation.dice[i];
        curDie.degreeRotation += (int)random(30);
      if (dice_animation.numFrames > 7) {
        curDie.whichDie = (int)random(6);
        //whichDie = (whichDie + 1) % 6;
        dice_animation.numFrames = 0;
      }
      
      curDie.x += curDie.xVel;
      curDie.y += curDie.yVel;
      //ax += axVel +axVel;
      //ay += ayVel + ayVel;
      
      if (curDie.x > 926 - 50) {
        //whichDie = (whichDie + 1) % 6;
        curDie.xVel = -VELOCITY;
      } else if (curDie.x < 50) {
        //whichDie = (whichDie + 1) % 6;
        curDie.xVel = VELOCITY;
      }
      
      if (curDie.y > 563 ) {
        //whichDie = (whichDie + 1) % 6;
        curDie.yVel = -VELOCITY;
      } else if (curDie.y < 50) {
        //whichDie = (whichDie + 1) % 6;
       curDie.yVel = VELOCITY;
      }
      for(int j = 0; i < dice_animation.dice.length; i++){
        if(!curDie.equals(dice_animation.dice[j])){
          if(Math.abs(curDie.y - dice_animation.dice[j].y)<=50){
            curDie.yVel = VELOCITY;
            dice_animation.dice[j].yVel = -VELOCITY;
          }
          if(Math.abs(curDie.x - dice_animation.dice[j].x)<=50){
            curDie.xVel = VELOCITY;
            dice_animation.dice[j].xVel = -VELOCITY;
          }
        }       
      }
      }
    }
  }
  //dice_animation.numFrames = 0;
}

public void keyPressed() {
  println(clientName + " keypressed");
  JSONObject worldData = get("getWorld");
   if (titleScreen == true) {
    titleScreenKeyPressed();
    return;
  }
  if(keyCode == RETURN || keyCode == ENTER){
    println(clientName + " enter pressed");
    if(worldData.getInt("setupTurns")< worldData.getInt("numSetupTurns")){
      get("changeTurn");
    } else {
      get("changePhase");
      if(dice_animation != null){
      dice_animation.numFrames = 0;
      }
    }
  }
  if(worldData.getJSONObject("curPlayer").getString("name").equals(clientName)){
  if(keyCode == UP && worldData.getInt("turnPhase") == 2 /*&& sCountry.getInt("numTroops") >1*/){
    String[] args={"targetCountry", tCountry.getString("name"), "sourceCountry", sCountry.getString("name")};
    get("fortify", args);
  }
  if(keyCode == DOWN && worldData.getInt("turnPhase") == 2 /*&& tCountry.getInt("numTroops")> 1*/){
    String[] args={"targetCountry", sCountry.getString("name"), "sourceCountry", tCountry.getString("name")};
    get("fortify", args);   
    println("registered");
  }
  if(key == 'z' && worldData.getInt("turnPhase") == 1 && tCountry != null && sCountry.getInt("numTroops") > 1 ){
   
    String[] args={"targetCountry", tCountry.getString("name"), "sourceCountry", sCountry.getString("name")};
    setupDice((Math.min(sCountry.getInt("numTroops")-1, 3)),(Math.min(tCountry.getInt("numTroops"), 2)));
    //realDrawDice();
    get("attack", args);
  if(key == 'x' && worldData.getInt("turnPhase") == 1){
    sCountry = null;
    tCountry = null;
  }
  }
}
}

public boolean containsCountry(JSONArray connectedCountryNames, JSONObject country) {
  for (int i = 0; i < connectedCountryNames.size(); i++) {
    if (connectedCountryNames.getString(i).equals(country.getString("name"))) {
      return true;
    }
  }
  return false;
}

public void drawAttackDie(int value, int x, int y) {
  image(attack_dice_images[value-1], x, y, 50, 50);
}
public void drawDie(int value, int x, int y) {
  image(dice_images[value-1], x, y, 50, 50);
}
public void mouseClicked() {
  println(clientName + " mouse clicked");
    if(mouseX >=800 && mouseY >= 400 && mouseX<=925 && mouseY <= 500){
    get("start");
    titleScreen = false;
  }
  if(titleScreen == false){
    mouseX /= 1.3f;
    mouseY /= 1.3f;
    JSONObject worldData = get("getWorld");
    if(worldData.getJSONObject("curPlayer").getString("name").equals(clientName)){
    boolean inBox = false;
  if(mouseX <475 && mouseY > 475){
    inBox = true;
  }
  if(inBox == false){
    double closestDist = 10000000;
    for (int i = 0; i < worldData.getJSONArray("allCountries").size(); i++) {
      
      if(allCountries[i].name.equals(worldData.getJSONArray("allCountries").getJSONObject(i).getString("name"))){
      double dist = sqrt(pow(mouseX - allCountries[i].x, 2) + pow(mouseY - allCountries[i].y, 2));
      if (dist < closestDist) {
        closestDist = dist;
        lastClickedCountry = allCountries[i];
      }
    }
    }
  }
  for(int i = 0; i < allRiskCards.length; i++){
    boolean overCard;
    overCard = false;
    float cy;
    int cardSize = 500;
    cy = 475;
    JSONObject riskCard = worldData.getJSONArray("allRiskCards").getJSONObject(i);
    if(allRiskCards[i].cardName.equals(riskCard.getString("cardName"))){
    if((worldData.getJSONObject("curPlayer").getInt("playerCardsWon") > 0) && (mouseX > allRiskCards[i].xLocation && mouseX < allRiskCards[i].xLocation+ 50 && 
      mouseY > cy && mouseY < cy+75) /*&& (riskCard.getJSONObject("owningPlayer").equals(worldData.getJSONObject("curPlayer")))*/){ //JSONObject["owningPlayer"] not found error sometimes
      String[] args={"cardName", riskCard.getString("cardName")};
      get("redeemCard", args);
    }
    }
  }
 // cardBonus();
  if(inBox){
    return;
  }
  for(int i = 0; i<allCountries.length; i++){
    if(lastClickedCountry.name.equals(worldData.getJSONArray("allCountries").getJSONObject(i).getString("name"))){
      lCountry = worldData.getJSONArray("allCountries").getJSONObject(i);
    }
  }
  
  if (worldData.getInt("setupTurns") < worldData.getInt("numSetupTurns")) {
    if (lCountry.getJSONObject("owningPlayer").getInt("trn") == 1){
     // if(worldData.getJSONObject("curPlayer").getString("name").equals(clientName)){
      String[] args ={"country", lCountry.getString("name")};
      get("setupTurnsPlaceTroop", args);
      get("changeTurn");
   // }
    }
  } else if (worldData.getInt("turnPhase") == 0 && lCountry.getJSONObject("owningPlayer").getInt("trn") == 1 ) {
      String[] args ={"country", lCountry.getString("name")};
      get("placeTroop", args);
  } else if (worldData.getInt("turnPhase") == 2 && lCountry.getJSONObject("owningPlayer").getInt("trn")==1){
    if(sCountry== null){
      sCountry = lCountry;
      //println(sCountry.name +"is the source");
    } else if(tCountry == null && sCountry != lCountry && containsCountry(sCountry.getJSONArray("connectedCountryNames"), lCountry)){
        tCountry = lCountry;
       // println(targetCountry.name + "is the target");
    } 
  } else if(worldData.getInt("turnPhase") == 1){
    if(sCountry== null && lCountry.getJSONObject("owningPlayer").getInt("trn")==1){
      sCountry = lCountry;
      //println(sourceCountry.name + " is the source");
    } else if(sCountry != null && tCountry == null && !sCountry.getJSONObject("owningPlayer").getString("name").equals(lCountry.getJSONObject("owningPlayer").getString("name")) && containsCountry(sCountry.getJSONArray("connectedCountryNames"), lCountry)){
      tCountry = lCountry;
      //println(targetCountry.name + " is the target");
      //setDice();
    }
  } 

  /*int numCountry = 0;
  for(int i = 0; i < gamePlayers.length; i++){
    if (gamePlayers[i].trn == 1){ 
      for(int p = 0; p < allCountries.length; p++){
        if (allCountries[p].owningPlayer == gamePlayers[i]){
         numCountry++;
        }
      }
    }
  }
  */
  }
  }
}
  public void settings() {  size(displayWidth, displayHeight);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "client_sketch2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
