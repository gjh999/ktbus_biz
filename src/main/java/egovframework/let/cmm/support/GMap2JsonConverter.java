package egovframework.let.cmm.support;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import java.lang.reflect.Type;
import java.util.Map;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * 
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일              수정자           수정내용
 *  ----------  --------   ---------------------------
 *  2011.08.31  JJY        최초 생성
 *  2021.08.12  신용호            추가 URL 생성
 *
 *      </pre>
 */
public class GMap2JsonConverter implements JsonSerializer<Map<String, String>>, JsonDeserializer<Map> {
	public Map deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
			throws JsonParseException {
		return null;
	}

	public JsonElement serialize(Map<String, String> src, Type typeOfSrc, JsonSerializationContext context) {
		JsonObject map = new JsonObject();
		Type childGenericType = null;
		for (Map.Entry entry : src.entrySet() ) {
			JsonElement valueElement = null;
			Object value = entry.getValue();
			if (value == null) {
				JsonPrimitive jsonPrimitive = new JsonPrimitive("");
			} else {
				Type childType = (childGenericType == null) ? value.getClass() : childGenericType;
				valueElement = context.serialize(value, childType);
			}
			map.add(String.valueOf(entry.getKey()), valueElement);
		}
		return (JsonElement) map;
	}
}