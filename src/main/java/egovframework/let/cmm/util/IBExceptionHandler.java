package egovframework.let.cmm.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;


public class IBExceptionHandler extends SimpleMappingExceptionResolver {
	private static final Logger LOGGER = LoggerFactory.getLogger(IBExceptionHandler.class);
	private String ajaxErrorView = "com/error/ajaxException";
    
    @SuppressWarnings("unused")
	@Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object o, Exception e) {
    	LOGGER.error("-------------------------   ERROR   -----------------------------");
    	LOGGER.error(e.getMessage());
        if( isAjax(request) ) {
            String exceptionMessage =  "ERROR OCCOR!!!\n\n" + getExceptionMessage(e);
            ModelAndView m = new ModelAndView(ajaxErrorView);
            m.addObject("exceptionMessage", "오류가 발생하였습니다");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return m;
        } else {
            return super.resolveException(request, response, o, e);
        }
    }

    private String getExceptionMessage(Throwable e) {
        String message = "";
        while( e != null ) {
            message += e.getMessage() + "\n";
            e = e.getCause();
        }
        return message;
    }
    
    private boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    }

 

    public void setAjaxErrorView(String ajaxErrorView) {
        this.ajaxErrorView = ajaxErrorView;
    }


    public String getAjaxErrorView() {
        return ajaxErrorView;
    }
    
    
    
}
