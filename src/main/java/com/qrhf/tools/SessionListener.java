package com.qrhf.tools;


import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
 
import com.qrhf.tools.SessionContext;
 
public class SessionListener implements HttpSessionListener {
    public  static SessionContext sessionContext=SessionContext.getInstance();
 
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
    	sessionContext.AddSession(httpSessionEvent.getSession());
    }
 
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        sessionContext.DelSession(httpSessionEvent.getSession());
    }
}
