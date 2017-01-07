JSONObject get(String url) {
  return get(url, new String[]{});
}

JSONObject get(String url, String[] args) {
  println("Making request to: " + url + ", with " + args.length / 2 + " arguments.");
  for (int i = 0; i < args.length; i += 2) {
    println("    " + args[i] + " --> " + args[i+1]);
  }
  GetRequest get = new GetRequest("http://localhost:8000/" + url, args);
  get.send();
  
  String response = get.getContent();
  println("    Response Content: " + response);
  
  if (response == null) {
    return null;
  }
  JSONObject obj = parseJSONObject(response);
  return obj;
}

void setup() {
  size(400, 400);
  smooth();
  frameRate(1);
  get("test");
}

void draw() {
  fill(0, 0, 0);
  rect(0, 0, 2000, 2000);
  
  fill(128, 0, 0);
  JSONObject result = get("numPlayers");
  if (result == null) {
    text("Error with GET request", 100, 100);
    return;
  }
  JSONArray playerNames = result.getJSONArray("players");
  for (int i = 0; i < result.getInt("numPlayers"); i++) {
    int j = i + 2;
    ellipse(50 * j, 50 * j, 50, 50);
    text(playerNames.getString(i), 50 * j, 50 * j);
  }
}

void mouseClicked() {
  get("join", new String[]{"name", "Alphabet &&& Soup", "age", "100"});
}