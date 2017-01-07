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
//realdrawdice doesnt work with while loop
//attempted to animate the dice end


//cant loop map or else will be slow. Tried noLoop() + loop() did not work. 

String dir = "C:/Users/fuady/Desktop/Risk Stuff/Processing/risk/risk_main_p2/data//";
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
boolean zIsPressed = false;
int amount=0;
boolean diceScreen = false;
int diceScreenStart = 0;
boolean animationDone = true;
  int attackDist;
  int attackXD;
  int attackYD;
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
  int theta;
  int speed = 15;
  int size;
  
  public Die() {
  }
  
  public Die(Die other) {
    this.x = other.x;
    this.y = other.y;
    this.xVel = other.xVel;
    this.yVel = other.yVel;
    this.whichDie = other.whichDie;
    this.degreeRotation = other.degreeRotation;
    this.isAttack = other.isAttack;
    this.theta = other.theta;
    this.speed = other.speed;
    this.size = other.size;
  }
}

class DiceAnimationState {
  int numFrames;
  boolean paused;
  //int speedMultiplier;
  Die[] dice;
}

DiceAnimationState dice_animation = null;

void setupDice(int numAttack, int numDefense) {

  dice_animation = new DiceAnimationState();
  
  dice_animation.dice = new Die[numAttack + numDefense];
  
  for (int i = 0; i < numAttack + numDefense; i++) {
    Die die = new Die();
    amount++;
    //println(amount);
    //die.x = 150 * i;
   // die.y = 150;
   die.x = (int)random(450); // 463;
   die.y = (int)random(350); // 281;
    die.xVel =30;
    die.yVel = 30;
    die.whichDie = (int)random(6);
    die.isAttack = i < numAttack;
    die.degreeRotation = (int)random(30);
    die.theta = (int)random(360);
    die.size = 100;
   //die.theta = 315;
    
    dice_animation.dice[i] = die;
  }
}
int VELOCITY = 15;
float rConvert(int degrees){
 return (degrees * 3.14159)/180;
}
int nConvert(int degrees){
  while(degrees < 0){
    degrees += 360;
  }
  while(degrees > 360){
    degrees -= 360;
  }
  return degrees;
}
int nQuad(int degrees){
  int quad = 0;
  if(nConvert(degrees)>=0 && nConvert(degrees)<90){
    quad = 1;
  }
  if(nConvert(degrees)>=90 && nConvert(degrees)<180){
    quad = 2;
  }
  if(nConvert(degrees)>=180 && nConvert(degrees)<270){
    quad = 3;
  }
  if(nConvert(degrees)>=270 && nConvert(degrees)<360){
    quad =4;
  }
  return quad;
}
int nSix(int degrees){
  int six = 0;
  if(nConvert(degrees)>=0 && nConvert(degrees)<60){
    six = 1;
  }
  if(nConvert(degrees)>=60 && nConvert(degrees)<120){
    six = 2;
  }
  if(nConvert(degrees)>=120 && nConvert(degrees)<180){
    six = 3;
  }
  if(nConvert(degrees)>=180 && nConvert(degrees)<240){
    six =4;
  }
  if(nConvert(degrees)>=240 && nConvert(degrees)<300){
    six =5;
  }
  if(nConvert(degrees)>=300 && nConvert(degrees)<360){
    six =6;
  }
  return six;
}
void addV(Die curDie, float multiplier) {
  float radians = 0;
  radians = rConvert(curDie.theta);
  curDie.x += multiplier*curDie.speed*cos(radians);
  curDie.y += multiplier*curDie.speed*sin(radians);
  //println(sin(rConvert(90)));
}
void changeTU(Die curDie){
  if(360 >= nConvert(curDie.theta)&&nConvert(curDie.theta) >= 180){
  curDie.theta = 360-curDie.theta;
  }else{
  }

}
void changeTD(Die curDie){
  curDie.theta = 360-curDie.theta ;
}
void changeTL(Die curDie){
  curDie.theta = 540-curDie.theta;
  curDie.x += 50;
}
void changeTR(Die curDie){
  curDie.theta=540-curDie.theta;
}
void changeTC(Die die1, Die die2){

  int save = 0;
  save = die1.theta;
  die1.theta = die2.theta;
  die2.theta = save;

}


float distance(Die die1, Die die2) {
  return Math.abs(die1.x - die2.x) + Math.abs(die1.y - die2.y);  
}

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
  scale(1.3, 1.3);
  int dStart = millis();
  if(titleScreen){
    drawTitleScreen();
    return;
  }
  if(diceScreen){
    realDrawDice();
    return;
  }
  if(animationDone){
  }
    
   JSONObject worldData = get("getWorld");
   JSONArray allJCountries = worldData.getJSONArray("allCountries"); 
  if(titleScreen==false){
     //image(map, 0, 0, width, height);

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
  fill(200, 200, 200);
  rect(5, 200, 100, 50);
  rect(5, 275, 100, 50);
  rect(800, 275, 100, 50);
  fill(2, 25, 255);
  text("Next", 802, 295);
  if(worldData.getInt("turnPhase") ==1){
    fill(2, 25, 255);
    text("Attack", 7, 220);
    text("Cancel Attack", 7, 295);
  }
  if(worldData.getInt("turnPhase") ==2){
    fill(2, 25, 255);
    text("Fortify", 7, 220);
    text("Withdraw", 7, 295);
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
  int dEnd = millis();
  println("draw took " + (dEnd-dStart) + " millis to draw. Frame rate is " + frameRate);
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
void diceEndAnimation() {
  JSONObject worldData = get("getWorld");
  for(int i = 0; i < dice_animation.dice.length; i++){
      Die curDie = dice_animation.dice[i];
      for(int j = 0; j < worldData.getJSONArray("attackDice").size(); j++){
         if(curDie.whichDie == worldData.getJSONArray("attackDice").getInt(j)){
           attackDist = (int)sqrt(((curDie.x- (50*j))*(curDie.x- (50*j))) + ((curDie.y- 310)*(curDie.y - 310)));
           attackXD = curDie.x - (j*50);
           attackYD = curDie.y - 310;
         }
       }
       if(attackXD >0){
         curDie.x = curDie.x - (attackYD/attackDist);
       }/*
       for(int b = 0; b < worldData.getJSONArray("defenseDice").size(); b++){
         if(!curDie.isAttack){
            curDie.whichDie = worldData.getJSONArray("defenseDice").getInt(b);
         }
       }*/
   }
   animationDone = false;
}

void realDrawDice() {
  int start = millis();
  JSONObject worldData = get("getWorld");
  //while(dice_animation.numFrames < 50){
  int s = millis()-diceScreenStart;
  noLoop();
  image(map, 0, 0, 926, 563);
  loop();
  print(s);
  //stroke(0, 255, 0);
  //rect(50, 50, 826, 463);

  for (int i = 0; i < dice_animation.dice.length; i++) {
    Die curDie = dice_animation.dice[i];
    pushMatrix();
    translate(curDie.x, curDie.y);
    rotate(radians(curDie.degreeRotation));
    fill(0, 255, 0);
    println("which die = " + curDie.whichDie);
    if (curDie.isAttack) {
      image(attack_dice_images[curDie.whichDie], -50, -50, curDie.size, curDie.size);
    } else {
      image(dice_images[curDie.whichDie], -50, -50,curDie.size, curDie.size);
    }
    ellipse(0, 0, 5, 5);
    popMatrix();
  }
  int draw_end = millis();
  if (s < 5000){
  dice_animation.numFrames++;
  if(dice_animation.numFrames > 7){
    dice_animation.numFrames = 0;
  }

  if (!dice_animation.paused) {
    for(int i= 0; i < dice_animation.dice.length; i++){
      Die curDie = dice_animation.dice[i];
      curDie.degreeRotation += (int)random(30);
    if (dice_animation.numFrames == 0) {
      curDie.whichDie = (int)random(6);
     // println(i + "  " + curDie.whichDie);
    }
    addV(curDie, 1.0);
    // println(nQuad(curDie.theta));
    //curDie.x += curDie.xVel;
    //curDie.y += curDie.yVel;
    //println(i + " " +  curDie.xVel + " " + curDie.yVel);
    }
    //ax += axVel +axVel;
    //ay += ayVel + ayVel;
      for(int i = 0; i < dice_animation.dice.length; i++){
    Die curDie = dice_animation.dice[i];  
   for(int j = 0; j < dice_animation.dice.length; j++){
      if(i<j){
        float d1 = distance(curDie, dice_animation.dice[j]);
        if (d1 <= 150) {
          Die curDie2 = new Die(curDie);
          Die diej2 = new Die(dice_animation.dice[j]);
          
          addV(curDie2, 0.1);
          addV(diej2, 0.1);
          
          float d2 = distance(curDie2, diej2);
          
          //println("d1 = " + d1 + ", d2 = " + d2);
          //dice_animation.paused = true;
          
          if (d2 < d1) {
            //curDie.speed = -VELOCITY-(int)random(10);
            //dice_animation.dice[j].speed = VELOCITY+(int)random(5);
            changeTC(curDie, dice_animation.dice[j]);
          }
        }
      }       
    }
    //println("after collision " + i + " " +  curDie.xVel + " " + curDie.yVel);
  }


  for(int i = 0; i < dice_animation.dice.length; i++){
    Die curDie = dice_animation.dice[i];
    if (curDie.x > 926 - 70) {
      //whichDie = (whichDie + 1) % 6;
      //curDie.xVel = -VELOCITY;
      changeTR(curDie);
      //println("hit right wall");
    } else if (curDie.x < 70) {
      //whichDie = (whichDie + 1) % 6;
     // curDie.xVel =  -1*curDie.xVel;
      changeTL(curDie);
    }
    
    if (curDie.y > 543 ) {
      //whichDie = (whichDie + 1) % 6;
      //curDie.yVel = -VELOCITY;
      changeTD(curDie);
    } else if (curDie.y < 50) {
      //whichDie = (whichDie + 1) % 6;
     //curDie.yVel = -1*curDie.yVel;
     changeTU(curDie);
    }
    //println("after wall" + i + " " +  curDie.xVel + " " + curDie.yVel);
  }
    
    }
  
  }
  if(s > 5000){
    ArrayList <Die> attackList = new ArrayList<Die>();
    ArrayList <Die> defenseList = new ArrayList<Die>();
   for(int i = 0; i < dice_animation.dice.length; i++){
      if(dice_animation.dice[i].isAttack){
        attackList.add(dice_animation.dice[i]);
      }
   }
   for(int i = 0; i < dice_animation.dice.length; i++){
      if(!dice_animation.dice[i].isAttack){
        defenseList.add(dice_animation.dice[i]);
      }
   }
      for(int j = 0; j < worldData.getJSONArray("attackDice").size(); j++){
           attackList.get(j).whichDie =  worldData.getJSONArray("attackDice").getInt(j)-1;
           Die curDie = attackList.get(j);
           if(curDie.x > 50*j){
             curDie.x-=5;
             
           }
           if(curDie.x < 50*j){
             curDie.x+=5;
           
           }
           if(curDie.y < 310){
             curDie.y+=5;
           
           }
           if(curDie.y>310){
             curDie.y-=5;
             
           }
           if(curDie.size >50){curDie.size=curDie.size-1;}
           if(curDie.degreeRotation%360 != 0){
             curDie.degreeRotation += Math.min(10, 360- (curDie.degreeRotation%360));
         }
         }
       for(int b = 0; b < worldData.getJSONArray("defenseDice").size(); b++){
         Die curDie = defenseList.get(b);
         curDie.whichDie = worldData.getJSONArray("defenseDice").getInt(b)-1;
         if(curDie.x > 50*b){
             curDie.x-=5;
             
           }
           if(curDie.x < 50*b){
             curDie.x+=5;
             
           }
           if(curDie.y < 360){
             curDie.y+=5;
            
           }
           if(curDie.y>360){
             curDie.y-=5;
            
           }
           if(curDie.size >50){curDie.size=curDie.size-1;
         }
           if(curDie.degreeRotation%360 != 0){
             curDie.degreeRotation += Math.min(10, 360- (curDie.degreeRotation%360));
         }
       }
      
  // diceEndAnimation();
  }
  if(s> 7000){diceScreen= false;}
  int physics_end = millis();
  //println("frame took " + (draw_end - start) + " milliseconds to draw, " + (physics_end - draw_end) + " millis for physics; frame rate is + " + frameRate);
  animationDone = true;
  
}

void keyPressed() {
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
    diceScreen=true;
    diceScreenStart = millis();
    zIsPressed = true;
    get("attack", args);
  }
  if(key == 'x' && worldData.getInt("turnPhase") == 1){
    println(clientName + " x keypressed");

    sCountry = null;
    tCountry = null;
    //zIsPressed = false;
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
void mouseClicked() {
    mouseX /= 1.3;
    mouseY /= 1.3;
  println(clientName + " mouse clicked");
    if(mouseX >=800 && mouseY >= 400 && mouseX<=925 && mouseY <= 500){
    get("start");
    titleScreen = false;
    redraw();
  }
  if(titleScreen == false){
    //map.resize(width, height); distorts the game
    //background(map);
    JSONObject worldData = get("getWorld");
    if(worldData.getJSONObject("curPlayer").getString("name").equals(clientName)){
        boolean inBox = false;
      if(mouseX <475 && mouseY > 475){
      }
      if(mouseX>=800 &&mouseX<=900&&mouseY>= 275&&mouseY<=325){
        inBox = true;
      }
      if(mouseX>=5 &&mouseX<=105&&mouseY>= 200&&mouseY<=250){
        inBox = true;
      }
     if(mouseX>=5 &&mouseX<=105&&mouseY>= 275&&mouseY<=325){
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
      if(mouseX>=800 &&mouseX<=900&&mouseY>= 275&&mouseY<=325){
        if(worldData.getInt("setupTurns")< worldData.getInt("numSetupTurns")){
           get("changeTurn");
          } 
          else {
            get("changePhase");
              if(dice_animation != null){
                dice_animation.numFrames = 0;
              }
          }
      }
  if(worldData.getJSONObject("curPlayer").getString("name").equals(clientName)){
    if(worldData.getInt("turnPhase") == 1){
      if(mouseX>=5 &&mouseX<=105&&mouseY>= 200&&mouseY<=250 && sCountry!=null && tCountry != null && sCountry.getInt("numTroops") > 1 ){
        String[] args={"targetCountry", tCountry.getString("name"), "sourceCountry", sCountry.getString("name")};
        setupDice((Math.min(sCountry.getInt("numTroops")-1, 3)),(Math.min(tCountry.getInt("numTroops"), 2)));
       // realDrawDice();
        //zIsPressed = true;
        get("attack", args);
      }
      if(mouseX>=5 &&mouseX<=105&&mouseY>= 275&&mouseY<=325){
          sCountry = null;
          tCountry = null;
          //zIsPressed = false;
      }
    }
    if(worldData.getInt("turnPhase") == 2&& tCountry != null && sCountry!=null){
      if(mouseX>=5 &&mouseX<=105&&mouseY>= 200&&mouseY<=250){
        String[] args={"targetCountry", tCountry.getString("name"), "sourceCountry", sCountry.getString("name")};
        get("fortify", args);
      }
      if(mouseX>=5 &&mouseX<=105&&mouseY>= 275&&mouseY<=325){
        String[] args={"targetCountry", sCountry.getString("name"), "sourceCountry", tCountry.getString("name")};
        get("fortify", args);   
        println("registered");
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