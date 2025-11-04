package egovframework.let.cmm.util;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

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
public class ParamMatrix {
	private static boolean isValidParamType(Method m) {
		Class[] clazzs = m.getParameterTypes();
		if (clazzs.length == 1) {
			Class clazz = clazzs[0];
			if (clazz.equals(double.class) || clazz.equals(float.class) || clazz.equals(int.class)
					|| clazz.equals(long.class) || clazz.equals(short.class) || clazz.equals(Double.class)
					|| clazz.equals(Float.class) || clazz.equals(Integer.class) || clazz.equals(Long.class)
					|| clazz.equals(Short.class) || clazz.equals(String.class) || clazz.equals(BigDecimal.class)
					|| clazz.equals(MultipartFile.class) || clazz.equals(Date.class) || clazz.equals(BigDecimal.class)
					|| clazz.equals(BigInteger.class))
				return true;
		}
		return false;
	}

	private static String getParamKey(Method m) {
		String r = null;
		if (isValidParamType(m) && m.getName().startsWith("set") && m.getName().length() > 3) {
			r = m.getName().substring(3, 4).toLowerCase();
			if (m.getName().length() > 4)
				r = String.valueOf(r) + m.getName().substring(4);
			return r;
		}
		return null;
	}

	static class MethodToValues {
		Method m;

		String[] values;

		MethodToValues(Method m, String[] values) {
			this.m = m;
			this.values = values;
		}

		Class getArgType() {
			assert (this.m.getParameterTypes()).length > 0;
			return this.m.getParameterTypes()[0];
		}

		Integer getInteger(int index) {
			return Integer
					.valueOf(Integer.parseInt(StringUtils.isEmpty(this.values[index]) ? "0" : this.values[index]));
		}

		Long getLong(int index) {
			return Long.valueOf(Long.parseLong(StringUtils.isEmpty(this.values[index]) ? "0" : this.values[index]));
		}

		Double getDouble(int index) {
			return Double
					.valueOf(Double.parseDouble(StringUtils.isEmpty(this.values[index]) ? "0" : this.values[index]));
		}

		BigDecimal getBigDecimal(int index) {
			return new BigDecimal(StringUtils.isEmpty(this.values[index]) ? "0" : this.values[index]);
		}

		BigInteger getBigInteger(int index) {
			return new BigInteger(StringUtils.isEmpty(this.values[index]) ? "0" : this.values[index]);
		}

		String getString(int index) {
			return this.values[index];
		}

		Date getDate(int index) {
			try {
				SimpleDateFormat srcSdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				return srcSdf.parse(this.values[index]);
			} catch (Exception e) {
				return null;
			}
		}

		Object getValue(int index) {
			Class clazz = getArgType();
			if (clazz.equals(double.class) || clazz.equals(float.class) || clazz.equals(Double.class)
					|| clazz.equals(Float.class))
				return getDouble(index);
			if (clazz.equals(int.class) || clazz.equals(short.class) || clazz.equals(Integer.class)
					|| clazz.equals(Short.class))
				return getInteger(index);
			if (clazz.equals(long.class) || clazz.equals(Long.class))
				return getLong(index);
			if (clazz.equals(BigDecimal.class))
				return getBigDecimal(index);
			if (clazz.equals(BigInteger.class))
				return getBigInteger(index);
			if (clazz.equals(Date.class))
				return getDate(index);
			return getString(index);
		}
	}

	private static <T> MethodToValues[] getMethodToValues(Class<T> t, Map<String, String[]> params, String prefix) {
		ArrayList<MethodToValues> r = new ArrayList<>();
		byte b;
		int i;
		Method[] arrayOfMethod;
		for (i = (arrayOfMethod = t.getMethods()).length, b = 0; b < i;) {
			Method m = arrayOfMethod[b];
			String key = getParamKey(m);
			if (key != null) {
				if (prefix != null && !prefix.isEmpty())
					key = String.valueOf(prefix) + key;
				String[] values = params.get(key);
				if (values != null && values.length > 0)
					r.add(new MethodToValues(m, values));
			}
			b++;
		}
		return r.<MethodToValues>toArray(new MethodToValues[r.size()]);
	}

	private static int getMaxValuesLength(MethodToValues[] values) {
		int r = 0;
		byte b;
		int i;
		MethodToValues[] arrayOfMethodToValues;
		for (i = (arrayOfMethodToValues = values).length, b = 0; b < i;) {
			MethodToValues e = arrayOfMethodToValues[b];
			if (r < e.values.length)
				r = e.values.length;
			b++;
		}
		return r;
	}

	public static <T> List<T> getObjectList(Class<T> t, Map<String, String[]> params, String prefix) throws Exception {
		LinkedList<T> r = new LinkedList<>();
		MethodToValues[] values = getMethodToValues(t, params, prefix);
		int maxValuesLength = getMaxValuesLength(values);
		for (int i = 0; i < maxValuesLength; i++) {
			T o = t.newInstance();
			byte b;
			int j;
			MethodToValues[] arrayOfMethodToValues;
			for (j = (arrayOfMethodToValues = values).length, b = 0; b < j;) {
				MethodToValues v = arrayOfMethodToValues[b];
				if (v.values.length > i)
					try {
						v.m.invoke(o, new Object[] { v.getValue(i) });
					} catch (Exception cause) {
						cause.printStackTrace();
					}
				b++;
			}
			r.add(o);
		}
		return r;
	}

	public static <T> List<T> getObjectList(Class<T> t, Map<String, String[]> params) throws Exception {
		return getObjectList(t, params, null);
	}

	public static class FooVo {
		private Integer id = null;

		private String name = null;

		private Double money = null;

		public Integer getId() {
			return this.id;
		}

		public void setId(Integer id) {
			this.id = id;
		}

		public String getName() {
			return this.name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public Double getMoney() {
			return this.money;
		}

		public void setMoney(Double money) {
			this.money = money;
		}

		public String toString() {
			return "id[" + ((this.id == null) ? "(null)" : this.id.toString()) + "]" + ", name["
					+ ((this.name == null) ? "(null)" : this.name) + "]" + ", money["
					+ ((this.money == null) ? "(null)" : this.money.toString()) + "]";
		}
	}

	public static void main(String[] args) throws Exception {
		HashMap<String, String[]> params = (HashMap) new HashMap<>();
		String[] ids = { "1", "2", "3" };
		String[] names = { "name 1", "name 2" };
		String[] moneys = { "1.1", "2.2", "3.3" };
		params.put("id", ids);
		params.put("name", names);
		params.put("money", moneys);
		String[] ids2 = { "10", "20", "30" };
		String[] names2 = { "name 10", "name 20", "name 30" };
		String[] moneys2 = { "10.1", "20.2", "30.3" };
		params.put("prefix.id", ids2);
		params.put("prefix.name", names2);
		params.put("prefix.money", moneys2);
		List<FooVo> foos = getObjectList(FooVo.class, (Map<String, String[]>) params);
		foos = getObjectList(FooVo.class, (Map<String, String[]>) params, "prefix.");
	}
}