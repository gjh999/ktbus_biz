package egovframework.let.cmm.util;

import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ExtHttpRequestParam implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private static final Log logger = LogFactory.getLog(ExtHttpRequestParam.class);
    
    private Map<String, Object> paramMap = null;;
    private Map<String, Object> simpleMap = null;
    private Locale locale = null;
    
    
    private boolean multiPart = false;
    
    
    // // 임시 데이타 저장소
    private Map<String, Object> param = null;
    
    public ExtHttpRequestParam() {
        this.param = new HashMap<String, Object>();
        this.paramMap = new HashMap<String, Object>();
    }
    
    public void setLocale(Locale locale) {
        this.locale = locale;
    }
    
    public Locale getLocale() {
        return this.locale;
    }
    
   
    
    public boolean isMultiPart() {
        return multiPart;
    }
    
    public void setMultiPart(boolean multiPart) {
        this.multiPart = multiPart;
    }
    
    public boolean containsKey(String key) {
        return this.paramMap.containsKey(key);
    }
    
  
    
    public void setParam(Map<String, Object> hParam) {
        this.paramMap = hParam;
        simpleMap = null;
    }
    
    public String getP(String key) {
        return getParameter(key, null);
    }
        
    public Object getObject(String key) {
        return paramMap.get(key);
    }
    
    public String getParameter(String key) {
        return getParameter(key, null);
    }
    
    public void put(String key, String value) {
        if (paramMap == null) {
            paramMap = new HashMap<String, Object>();
        }
        
        paramMap.put(key, (String[]) ArrayUtils.add(ArrayUtils.EMPTY_STRING_ARRAY, value));
        simpleMap = null;
    }
    
    public String getParameter(String key, String def) {
        
        String rv = null;
        if (paramMap != null) {
            
            Object t = this.paramMap.get(key);
            if (t != null) {
                if (t instanceof Object[]) {
                    rv = ObjectUtil.getSafeString(((Object[]) t)[0]);
                }
            }
        }
        
        return ObjectUtil.nvl(rv, def);
    }
    
    /**
     * null 없음 !!
     * 
     * @param key
     * @return
     */
    public String[] getParameterValues(String key) {
        
        String[] rv = null;
        if (paramMap != null) {
            Object o = this.paramMap.get(key);
            if (o != null) {
                if (o instanceof Object[]) {
                    rv = (String[]) o;
                }
            }
        }
        return (rv == null) ? new String[0] : rv;
    }
    
    /**
     * Parameter로 넘어온 정보를 Map에 담아 넘겨줌 여러개의 값의 경우 첫번째 값을 너어줌(list나 collection아님)
     * 
     * @return
     */
    public Map<String, Object> getParameterMap() {
        
        if (simpleMap == null) {
            
            simpleMap = new HashMap<String, Object>();
            Set<String> keySet = paramMap.keySet();
            
            String[] values = null;
            for (String key : keySet) {
                values = (String[]) this.paramMap.get(key);
                
                if (values.length < 2)
                    simpleMap.put(key, this.getParameter(key));
                else
                    simpleMap.put(key, this.getParameterValues(key));
            }
        }
        return simpleMap;
    }
    
    /**
     * View Object ID가 같은 대상에 대한 값을 ArrayList로 반환해준다.
     * 
     * @param key
     * @return
     */
    public ArrayList<String> getParameterList(String key) {
        
        ArrayList<String> paramList = new ArrayList<String>();
        
        try {
            
            Object o = (Object) paramMap.get(key);
            
            Class<? extends Object> c = o.getClass();
            if (o != null) {
                
                if (c.isArray()) {
                    
                    int length = Array.getLength(o);
                    if (length != 0) {
                        
                        for (int i = 0; i < length; i++) {
                            
                            Object tiem = Array.get(o, i);
                            if (tiem == null) {
                                paramList.add("");
                            } else {
                                paramList.add(tiem.toString());
                            }
                        }
                    }
                    
                } else {
                    paramList.add(o.toString());
                }
            }
        } catch (Exception e) {
        }
        
        return paramList;
    }
    
    public Set<String> getKeySet() {
        return this.paramMap.keySet();
    }
    
  
    
   
    
    public String toString() {
        StringBuffer msg = new StringBuffer();
        
        msg.append("  paramMap={");
        if (paramMap != null) {
            Set<String> keySet = paramMap.keySet();
            for (String key : keySet) {
                msg.append(key + "=" + ToStringBuilder.reflectionToString(paramMap.get(key), ToStringStyle.SIMPLE_STYLE));
            }
        } else {
            msg.append("null");
        }
        
        msg.append("}\n");
        return msg.toString();
    }
    
    /**
     * mutilpart form이 아니면 exception 발생
     * 
     * @throws Exception
     */
    private void assertMulti() throws Exception {
        if (!this.multiPart) {
            throw new Exception("form type이 파일을 전송할수 없습니다. FORM tag에 type=\"POST\" +" + " enctype=\"multipart/form-data\" 를 추가해 주십시요 .");
        }
    }
    
    public boolean setDefaultParam(String key, Object value) {
        
        boolean changed = false;
        if (paramMap != null) {
            
            if (paramMap.containsKey(key)) {
                
                if (ObjectUtil.isEmpty(paramMap.get(key))) {
                    paramMap.put(key, value);
                    changed = true;
                }
                
            } else {
                paramMap.put(key, value);
                changed = true;
            }
        }
        return changed;
    }
}