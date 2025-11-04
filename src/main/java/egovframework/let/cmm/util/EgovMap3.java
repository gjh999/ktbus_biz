package egovframework.let.cmm.util;

import org.apache.commons.collections4.map.ListOrderedMap;

@SuppressWarnings("rawtypes")
public class EgovMap3 extends ListOrderedMap {

    private static final long serialVersionUID = 6723434363565852261L;

    /**
     * key 에 대하여 Camel Case 변환하여 super.put
     * (ListOrderedMap) 을 호출한다.
     * @param key
     *        - '_' 가 포함된 변수명
     * @param value
     *        - 명시된 key 에 대한 값 (변경 없음)
     * @return previous value associated with specified
     *         key, or null if there was no mapping for
     *         key
     */
    @SuppressWarnings("unchecked")
	@Override
    public Object put(Object key, Object value) {
        return super.put(convert2CamelCase((String) key),  org.apache.commons.lang3.StringEscapeUtils.unescapeXml(value+""));
    }
    
    public static String convert2CamelCase(String underScore) {
        // '_' 가 나타나지 않으면 이미 camel case 로 가정함.
        // 단 첫째문자가 대문자이면 camel case 변환 (전체를 소문자로) 처리가
        // 필요하다고 가정함. --> 아래 로직을 수행하면 바뀜
        if (underScore.indexOf('_') < 0 && Character.isLowerCase(underScore.charAt(0))) {
            return underScore;
        }
        
        StringBuilder result = new StringBuilder();
        
        boolean nextUpper = false;
        int len = underScore.length();

        for (int i = 0; i < len; i++) {
            char currentChar = underScore.charAt(i);
            
            //첫글자 대문자로 변환
            if (i == 0){
            	result.append(currentChar = Character.toUpperCase(currentChar));
            }else{
                if (currentChar == '_') {
                    nextUpper = true;
                } else {
                    if (nextUpper) {
                        result.append(Character.toUpperCase(currentChar));
                        nextUpper = false;
                    } else {
                        result.append(Character.toLowerCase(currentChar));
                    }
                }
            }
        }

        return result.toString();
    }
}