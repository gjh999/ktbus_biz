package egovframework.let.cmm.support;

import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.HashMap;
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
public class NaturalDeserializer implements JsonDeserializer<Object> {
	public Object deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) {
		if (json.isJsonNull())
			return null;
		if (json.isJsonPrimitive())
			return handlePrimitive(json.getAsJsonPrimitive());
		if (json.isJsonArray())
			return handleArray(json.getAsJsonArray(), context);
		return handleObject(json.getAsJsonObject(), context);
	}

	private Object handlePrimitive(JsonPrimitive json) {
		if (json.isBoolean())
			return Boolean.valueOf(json.getAsBoolean());
		if (json.isString())
			return json.getAsString();
		BigDecimal bigDec = json.getAsBigDecimal();
		try {
			bigDec.toBigIntegerExact();
			try {
				return Integer.valueOf(bigDec.intValueExact());
			} catch (ArithmeticException arithmeticException) {
				return Long.valueOf(bigDec.longValue());
			}
		} catch (ArithmeticException arithmeticException) {
			return Double.valueOf(bigDec.doubleValue());
		}
	}

	private Object handleArray(JsonArray json, JsonDeserializationContext context) {
		Object[] array = new Object[json.size()];
		for (int i = 0; i < array.length; i++)
			array[i] = context.deserialize(json.get(i), Object.class);
		return array;
	}

	private Map handleObject(JsonObject json, JsonDeserializationContext context) {
		Map<String, Object> map = new HashMap<>();
		for (Map.Entry<String, JsonElement> entry : (Iterable<Map.Entry<String, JsonElement>>) json.entrySet())
			map.put(entry.getKey(), context.deserialize(entry.getValue(), Map.class));
		return map;
	}
}