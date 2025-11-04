package egovframework.let.cmm.util;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.net.URL;
import java.rmi.dgc.VMID;
import java.text.ParseException;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import org.apache.commons.io.IOUtils;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.util.StringUtils;

import egovframework.let.cmm.support.ApplicationContextProvider;

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
public class ObjectUtil {
	private static final String SUBMIT_NAME_PREFIX_VAR = "submitNamePrefix";

	private static final Logger logger = LoggerFactory.getLogger(ObjectUtil.class);

	public static boolean isEmpty(Object obj) {
		if (obj instanceof Collection)
			return ((Collection) obj).isEmpty();
		if (obj instanceof Object[])
			return (((Object[]) obj).length == 0);
		return (obj == null || "".equals(getSafeString(obj)));
	}

	public static String getSafeString(Object obj) {
		return getSafeString(obj, null);
	}

	public static String getSafeString(Object obj, Object def) {
		if (obj == null)
			return null;
		if (obj instanceof String)
			return String.valueOf(obj).trim();
		if (obj instanceof java.util.Collections)
			return StringUtils.collectionToDelimitedString((Collection) obj, ";");
		return obj.toString();
	}

	public static String nvl(Object obj, Object def) {
		return getSafeString(isEmpty(obj) ? def : obj);
	}

	public static Object nvlObj(Object obj, Object def) {
		return isEmpty(obj) ? def : obj;
	}

	public static Throwable getRootCause(Throwable e) {
		Throwable t = e.getCause();
		if (t != null)
			return getRootCause(t);
		return e;
	}

	public static String getGUID() {
		VMID id = new VMID();
		String tmp = id.toString();
		tmp = tmp.replaceAll("[:|-]", "");
		return tmp;
	}

	public static Date long2Date(long x) {
		return new Date(x);
	}

	public static int parseInt(Object obj) {
		return parseInt(obj, 0);
	}

	public static int parseInt(Object obj, int default_num) {
		int parseInt = 0;
		try {
			if (obj instanceof Integer) {
				parseInt = ((Integer) obj).intValue();
			} else {
				String str = getSafeString(obj);
				if (str != null) {
					parseInt = Integer.parseInt(str.trim());
				} else {
					parseInt = default_num;
				}
			}
		} catch (Exception nf) {
			parseInt = default_num;
		}
		return parseInt;
	}

	public static float parseFloat(String str) {
		return parseFloat(str, 0.0F);
	}

	public static float parseFloat(String str, float default_num) {
		float parseFloat = 0.0F;
		try {
			if (str != null) {
				parseFloat = Float.parseFloat(str.trim());
			} else {
				parseFloat = default_num;
			}
		} catch (Exception exception) {
		}
		return parseFloat;
	}

	public static double parseDouble(Object str) {
		double n = 0.0D;
		try {
			n = Double.parseDouble(str.toString());
		} catch (Throwable e) {
			logger.error("str = [" + str + "] : " + e.getMessage());
		}
		return n;
	}

	public static String stringOfUrl(String addr) throws IOException {
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		URL url = new URL(addr);
		IOUtils.copy(url.openStream(), (OutputStream) output);
		return output.toString();
	}

	public static String getStackTrace(Exception e) {
		StringBuffer sBuf = new StringBuffer();
		sBuf.append(e);
		StackTraceElement[] trace = e.getStackTrace();
		byte b;
		int i;
		StackTraceElement[] arrayOfStackTraceElement1;
		for (i = (arrayOfStackTraceElement1 = trace).length, b = 0; b < i;) {
			StackTraceElement el = arrayOfStackTraceElement1[b];
			sBuf.append("\n").append("\tat " + el);
			b++;
		}
		return sBuf.toString();
	}

	public static String cleanDate(String dateStr) {
		return dateStr.replace("-", "");
	}

	public static Map<String, Object> ConvertObjectToMap(Object obj) {
		Map<String, Object> resultMap = new HashMap<>();
		try {
			Field[] fields = obj.getClass().getDeclaredFields();
			for (int i = 0; i <= fields.length - 1; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	public static Object convertMapToObject(Map map, Object objClass) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator<String> itr = map.keySet().iterator();
		while (itr.hasNext()) {
			keyAttribute = itr.next();
			methodString = String.valueOf(setMethodString) + keyAttribute.substring(0, 1).toUpperCase()
					+ keyAttribute.substring(1);
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				for (int i = 0; i <= methods.length - 1; i++) {
					if (methodString.equals(methods[i].getName()))
						methods[i].invoke(objClass, new Object[] { map.get(keyAttribute) });
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return objClass;
	}

	public static String arrayToDelimString(String[] arr, String delimiter) {
		if (arr == null)
			return "";
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < arr.length; i++) {
			if (i > 0)
				sb.append(delimiter);
			sb.append(arr[i]);
		}
		return sb.toString();
	}

	public static Object[] toArray(Object obj) {
		if (obj == null)
			return ArrayUtils.EMPTY_OBJECT_ARRAY;
		if (obj instanceof Object[])
			return (Object[]) obj;
		if (obj instanceof Collection)
			return ((Collection) obj).toArray(new Object[0]);
		return ArrayUtils.add(ArrayUtils.EMPTY_OBJECT_ARRAY, obj);
	}

	public static List<Object> convertArrayToList(Object[] obj) {
		return Arrays.asList(obj);
	}

	public static String[] list2StrArray(List<String> list) {
		if (list != null)
			return list.<String>toArray(new String[0]);
		return new String[0];
	}

	public static String[] safeArray(String[] arr, int length) {
		String[] newArr = new String[length];
		Arrays.fill((Object[]) newArr, "");
		for (int j = 0; j < arr.length; j++)
			newArr[j] = arr[j];
		return newArr;
	}

	public static Object[] addAll(Object[] arg0, Object[] arg1) {
		return ArrayUtils.addAll(arg0, arg1);
	}

	public static Object getBean(String beanID) {
		Object obj = null;
		try {
			ApplicationContext ctx = ApplicationContextProvider.getApplicationContext();
			if (ctx != null)
				obj = ctx.getBean(beanID);
		} catch (Exception e) {
			logger.error(" !!! {} ", e.getMessage());
		}
		return obj;
	}

	public static String toJsonStr(Object obj) {
		return JsonUtil.toJsonStr(obj);
	}

	public static String getDataString(Object obj) {
		if (obj == null)
			return null;
		if (obj instanceof String)
			return String.valueOf(obj).trim();
		if (obj instanceof java.util.Collections)
			return StringUtils.collectionToDelimitedString((Collection) obj, ";");
		return String.valueOf(obj).trim();
	}

	public static boolean isNumeric(String s) {
		Pattern pattern = Pattern.compile("[+-]?\\d+");
		return pattern.matcher(s).matches();
	}

	public static Object convertToObject(Class<?> cls, String value)
			throws ClassNotFoundException, InstantiationException, IllegalAccessException, ParseException {
		String name = cls.getName();
		Object obj = null;
		if (cls == String.class)
			return value;
		if (cls == Integer.class || name.equals("int")) {
			obj = Integer.valueOf(value);
		} else if (cls == Boolean.class || name.equals("boolean")) {
			obj = Boolean.valueOf(value);
		} else if (cls == Double.class || name.equals("double")) {
			obj = Double.valueOf(value);
		} else if (cls == Short.class || name.equals("short")) {
			obj = Short.valueOf(value);
		} else if (cls == Long.class || name.equals("long")) {
			obj = Long.valueOf(value);
		} else if (cls == Float.class || name.equals("float")) {
			obj = Float.valueOf(value);
		} else if (cls == Character.class) {
			obj = String.valueOf(value);
		} else if (cls == Byte.class || name.equals("byte")) {
			obj = Byte.valueOf(value);
		} else if (cls == Date.class) {
			if (StringUtil.length(value) == 8) {
				obj = DateUtil.strToDate(value, "ddMMyyyy");
			} else if (StringUtil.length(value) > 8) {
				obj = DateUtil.strToDate(value, "ddMMyyyy HH:mm:ss");
			}
		} else if (cls == BigDecimal.class) {
			try {
				obj = new BigDecimal(value);
			} catch (NumberFormatException nfe) {
				logger.error("Can't convert to BigDecimal : {}", value);
				throw nfe;
			}
		} else {
			return value;
		}
		return obj;
	}

	public static <T> List<T> toList(Map<String, String[]> paramMap, Class<T> clazz) throws Exception {
		String prefix = getSubmitNamePrefix(paramMap.get("submitNamePrefix"), clazz.getSimpleName());
		return ParamMatrix.getObjectList(clazz, paramMap, prefix);
	}

	private static String getSubmitNamePrefix(String[] namePrefix, String clazzName) {
		if (namePrefix != null && namePrefix.length > 0) {
			byte b;
			int i;
			String[] arrayOfString;
			for (i = (arrayOfString = namePrefix).length, b = 0; b < i;) {
				String prefix = arrayOfString[b];
				if (clazzName.equals(prefix))
					return prefix;
				b++;
			}
		}
		return null;
	}
}