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

void setup() {
  //size(926,563);
 // surface.setResizable(true);
 size(displayWidth, displayHeight);
  smooth();
  frameRate(10);
  showVirtualKeyboard();
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


JSONObject get(String url) {
  return get(url, new String[]{});
}

JSONObject get(String url, String[] args) {
  //println("Making request to: " + url + ", with " + args.length / 2 + " arguments.");
  for (int i = 0; i < args.length; i += 2) {
    //println("    " + args[i] + " --> " + args[i+1]);
  }
  GetRequest get = new GetRequest("http://10.24.11.123:8000/" + url, args);
  get.send();
  
  String response = get.getContent();
  //println("    Response Content: " + response);
  
  if (response == null) {
    return null;
  }
  JSONObject obj = parseJSONObject(response);
  return obj;
}