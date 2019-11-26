package com.qrhf.tools;

import java.util.Locale;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.qrhf.pojo.User;

public class SessionContainer implements HttpSessionBindingListener{
	 private User user;   
	    private Locale locale;   
	       
	  
	    public Locale getLocale() {   
	        return locale;   
	    }   
	  
	    public void setLocale(Locale locale) {   
	        this.locale = locale;   
	    }   
	  
	    public User getUser() {   
	        return user;   
	    }   
	  
	    public void setUser(User user) {   
	        this.user = user;   
	    }   
	    public void initialize(){   
	        user=new User();   
	    }   
	    public void cleanUp(){   
	        this.setUser(null);   
	    }   
	    public SessionContainer(){   
	        super();   
	        initialize();   
	    }   
	  
	    public void valueBound(HttpSessionBindingEvent arg0) {   
	        // TODO Auto-generated method stub   
	  
	    }   
	  
	    public void valueUnbound(HttpSessionBindingEvent arg0) {   
	        // TODO Auto-generated method stub   
	  
	    }   
}
