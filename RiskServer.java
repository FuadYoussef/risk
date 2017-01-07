import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.*;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import com.google.gson.Gson;


abstract class BaseHandler implements HttpHandler {
    static Gson gson = new Gson();

    static void respond(HttpExchange t, Object response, int status) throws IOException {
        String json = gson.toJson(response);

        t.sendResponseHeaders(200, json.length());
        OutputStream os = t.getResponseBody();
        os.write(json.getBytes());
        os.close();
    }

    static void ok(HttpExchange t, Object response) throws IOException {
        respond(t, response, 200);
    }

    static class ErrorResult {
        String error;
    }

    static void error(HttpExchange t, String error_message) throws IOException {
        ErrorResult result = new ErrorResult();
        result.error = error_message;
        respond(t, result, 500);
    }

    static Map<String, String> parseParams(HttpExchange t) throws IOException {
        String query = t.getRequestURI().getRawQuery();
        Map<String, String> result = new HashMap<String, String>();
        if (query == null) {
            return result;
        }
        for (String rawParam : query.split("&")) {
            String param = java.net.URLDecoder.decode(rawParam, "UTF-8");
            String pair[] = param.split("=");
            if (pair.length > 1) {
                result.put(pair[0], pair[1]);
            } else {
                result.put(pair[0], "");
            }
        }
        return result;
    }

    static String getParam(HttpExchange t, String name) throws IOException {
        return parseParams(t).get(name);
    }

    static int getIntParam(HttpExchange t, String name, int defaultValue) throws IOException {
        String val = parseParams(t).get(name);
        if (val == null) {
            return defaultValue;
        }
        return Integer.parseInt(val);
    }

    @Override
    final public void handle(HttpExchange t) throws IOException {
        try {
            handleSafe(t);
        } catch (Exception e) {
            e.printStackTrace();
            error(t, "Exception processing request: " + e + ". See log for details.");
        }
    }

    abstract public void handleSafe(HttpExchange t) throws Exception;
}


public class RiskServer {

    long startTime;
    int numPlayers = 0;
    ArrayList<String> players = new ArrayList<String>();

    public static void main(String[] args) throws Exception {
        new RiskServer().setup();
    }

    public void setup() throws IOException {
        startTime = System.currentTimeMillis();
        HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);
        server.createContext("/test", new TestHandler());
        server.createContext("/join", new JoinHandler());
        server.createContext("/numPlayers", new NumPlayersHandler());
        server.setExecutor(null); // creates a default executor
        server.start();
    }

    class SimpleResponse {
        String message;
    }

    class TestHandler extends BaseHandler {
        @Override
        public void handleSafe(HttpExchange t) throws Exception {
            SimpleResponse response = new SimpleResponse();
            response.message = "This is the response";
            ok(t, response);
        }
    }

    class JoinHandler extends BaseHandler {
        @Override
        public void handleSafe(HttpExchange t) throws Exception {
            String name = getParam(t, "name");
            int age = getIntParam(t, "age", -1);
            numPlayers++;
            players.add(name);

            SimpleResponse response = new SimpleResponse();
            response.message = "Hi " + name + ", age " + age + "! You are the " + numPlayers + "th player.";
            ok(t, response);
        }
    }

    class NumPlayersHandler extends BaseHandler {
        class Response {
            int numPlayers;
            long uptime;
            ArrayList<String> players;
        }
        @Override
        public void handleSafe(HttpExchange t) throws Exception {
            Response response = new Response();
            response.numPlayers = numPlayers;
            response.uptime = System.currentTimeMillis() - startTime;
            response.players = players;
            ok(t, response);
        }
    }
}


