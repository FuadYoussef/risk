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

import android.view.inputmethod.InputMethodManager;
import android.content.Context;

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

void showVirtualKeyboard() {
  Context context = getActivity();
  InputMethodManager imm = (InputMethodManager)context.getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,0);
}

void hideVirtualKeyboard() {
  Context context = getActivity();
  InputMethodManager imm = (InputMethodManager)context.getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0);
}

void setupDice(int numAttack, int numDefense) {
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

void drawTitleScreen() {
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

Country findCountryByName(String name) {
  for (Country c : allCountries) {
    if (c.name.equals(name)) {
      return c;
    }
  }
  return null;
}

void draw() {
  if (titleScreen == true) {
    drawTitleScreen();  
  }
   JSONObject worldData = get("getWorld");
   JSONArray allJCountries = worldData.getJSONArray("allCountries"); 
  if(titleScreen==false){
     //image(map, 0, 0, width, height);
     scale(1.3, 1.3);
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

void drawTroops(int numTroops, int x, int y, int clr) {
  drawTroops(numTroops/10, (numTroops % 10) / 5, numTroops % 5, x, y, clr);
}

void drawTroops(int cannons, int horses, int soldiers, int x, int y, int clr){
 
  if (soldiers == 0 && horses == 0){
 for (int i=0; i < cannons; i++) {
    image(cannon_images[clr], x + i*IMAGE_SIZE/2, y, IMAGE_SIZE, IMAGE_SIZE);
    }
  } 
 
else{
  for (int i=0; i < cannons; i++) {
    image(cannon_images[clr], x + i*IMAGE_SIZE/2, y + IMAGE_SIZE*.8, IMAGE_SIZE, IMAGE_SIZE);
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

void titleScreenKeyPressed() {
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
void realDrawDice() {
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

void keyPressed() {
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

boolean containsCountry(JSONArray connectedCountryNames, JSONObject country) {
  for (int i = 0; i < connectedCountryNames.size(); i++) {
    if (connectedCountryNames.getString(i).equals(country.getString("name"))) {
      return true;
    }
  }
  return false;
}

void drawAttackDie(int value, int x, int y) {
  image(attack_dice_images[value-1], x, y, 50, 50);
}
void drawDie(int value, int x, int y) {
  image(dice_images[value-1], x, y, 50, 50);
}
void mousePressed() {
  println(clientName + " mouse clicked");
    if(mouseX >=800 && mouseY >= 400 && mouseX<=925 && mouseY <= 500){
    get("start");
    titleScreen = false;
    hideVirtualKeyboard();
  }
  if(titleScreen == false){
    mouseX /= 1.3;
    mouseY /= 1.3;
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