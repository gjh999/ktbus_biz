package egovframework.let.cmm.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import egovframework.let.cmm.support.GCollection2JsonConverter;
import egovframework.let.cmm.support.GMap2JsonConverter;
import egovframework.let.cmm.support.NaturalDeserializer;

import java.lang.reflect.Type;
import java.util.Collection;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
public class JsonUtil {
	private static final Logger logger = LoggerFactory.getLogger(JsonUtil.class);

	public static String toJsonStr(Object obj) {
		String rv = null;
		try {
			if (obj != null) {
				GsonBuilder gb = new GsonBuilder();
				gb.serializeNulls();
				gb.registerTypeAdapter(Map.class, new GMap2JsonConverter());
				gb.registerTypeAdapter(Collection.class, new GCollection2JsonConverter());
				Gson gson = gb.create();
				rv = gson.toJson(obj);
			} else {
				rv = "{}";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			rv = "{}";
		}
		return rv;
	}

	public static Object fromJsonStr(String jsonStr) {
		Object natural = null;
		try {
			GsonBuilder gsonBuilder = new GsonBuilder();
			gsonBuilder.registerTypeAdapter(Object.class, new NaturalDeserializer());
			Gson gson = gsonBuilder.create();
			natural = gson.fromJson(jsonStr, Object.class);
		} catch (Exception e) {
			logger.error("Error : {} \n {} ", (Object[]) new String[] { e.getMessage(), jsonStr });
		}
		return natural;
	}

	public static <T> T fromJsonGson(String jsonString, Class<T> classOfT) {
		Gson gson = new Gson();
		return (T) gson.fromJson(jsonString, classOfT);
	}

	public static <T> T fromJsonGson(JsonElement jsonElement, Type type) {
		Gson gson = new Gson();
		return (T) gson.fromJson(jsonElement, type);
	}

	public static <T> T fromJsonGson(String jsonString, Type typeOfT) {
		Gson gson = new Gson();
		return (T) gson.fromJson(jsonString, typeOfT);
	}

	public static final JsonArray fromJsonArrayGson(String jsonString) {
		JsonArray arr = null;
		JsonElement el = (new JsonParser()).parse(jsonString);
		if (jsonString != null)
			arr = el.getAsJsonArray();
		return arr;
	}

	public static String objectToJackson(Object obj) {
		String rv = null;
		try {
			if (obj != null) {
				ObjectMapper om = new ObjectMapper();
				rv = om.writeValueAsString(obj);
			} else {
				rv = "{}";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			rv = "{}";
		}
		return rv;
	}

	public static Map<String, Object> jacksonToObj(String jsonStr) {
		Map<String, Object> natural = null;
		try {
			ObjectMapper om = new ObjectMapper();
			natural = (Map<String, Object>) om.readValue(jsonStr, new TypeReference<Map<String, Object>>() {

			});
		} catch (Exception e) {
			logger.error("Error : {} \n {} ", (Object[]) new String[] { e.getMessage(), jsonStr });
		}
		return natural;
	}
}