package com.dev.drakestore.controller.user;
//package com.devpro.shop14.controller.user;
//
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HandleErrorController implements ErrorController {
	
	
	@RequestMapping(value = { "/error" }, method = RequestMethod.GET) // -> action
	  public String handleError(final ModelMap model, 
			  final HttpServletRequest request, 
			  final HttpServletResponse response) {
	    Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
	    if (status != null) {
	      Integer statusCode = Integer.valueOf(status.toString());
	      if (statusCode == HttpStatus.NOT_FOUND.value()) {
	        return "user/404-error";
	      } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
	        return "user/500-error";
	      }
	    }
	    return "error";
	  }
	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return "/error";
	}

}
