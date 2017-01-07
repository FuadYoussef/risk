import java.util.ArrayList;
import java.util.Iterator;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.commons.codec.net.URLCodec;

public class GetRequest
{
	String url;
	String content;
	HttpResponse response;
	UsernamePasswordCredentials creds;
    	ArrayList<BasicNameValuePair> headerPairs;
    
  URLCodec codec = new URLCodec("UTF-8");


  public GetRequest(String url) {
     this(url, new String[]{});
  }

  public GetRequest(String url, String[] args)
	{
    headerPairs = new ArrayList<BasicNameValuePair>();
           
    String urlArgs = "";
    try {
      for (int i = 0; i < args.length; i+= 2) {
        urlArgs += (i == 0 ? "?" : "&");
        urlArgs += codec.encode(args[i]) + "=" + codec.encode(args[i+1]);
      }
    }
    catch(Exception e) {
      System.out.println("Failed to encode args: " + e);
    }

    this.url = url + urlArgs;
    //System.out.println("    final url: " + this.url);
	}

	public void addUser(String user, String pwd) 
	{
		creds = new UsernamePasswordCredentials(user, pwd);
	
    	}
    
    	public void addHeader(String key,String value) {
        	BasicNameValuePair nvp = new BasicNameValuePair(key,value);
        	headerPairs.add(nvp);
        
    	}  
      
	public void send() 
	{
		try {
			DefaultHttpClient httpClient = new DefaultHttpClient();

			HttpGet httpGet = new HttpGet(url);

			if(creds != null){
				httpGet.addHeader(new BasicScheme().authenticate(creds, httpGet, null));				
			}

                    	Iterator<BasicNameValuePair> headerIterator = headerPairs.iterator();
                    	while (headerIterator.hasNext()) {
                      		BasicNameValuePair headerPair = headerIterator.next();
                      		httpGet.addHeader(headerPair.getName(),headerPair.getValue());
                    	}
  

			response = httpClient.execute( httpGet );
			HttpEntity entity = response.getEntity();
			this.content = EntityUtils.toString(response.getEntity());
			
			if( entity != null ) EntityUtils.consume(entity);
			httpClient.getConnectionManager().shutdown();
			
		} catch( Exception e ) { 
			e.printStackTrace(); 
		}
	}
	
	/* Getters
	_____________________________________________________________ */
	
	public String getContent()
	{
		return this.content;
	}
	
	public String getHeader(String name)
	{
		Header header = response.getFirstHeader(name);
		if(header == null)
		{
			return "";
		}
		else
		{
			return header.getValue();
		}
	}
}