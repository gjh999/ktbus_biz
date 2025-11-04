package egovframework.let.cmm.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.text.MessageFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;

import org.springframework.web.util.HtmlUtils;

import egovframework.let.cmm.support.KeyValuePairParser;

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
public class StringUtil extends StringUtils {
	public static final int LEFT = 1;

	public static final int CENTER = 2;

	public static final int RIGHT = 3;

	public static final String DefaultSep = ",";

	public static boolean equals(String str1, String str2) {
		return (str1 == null) ? ((str2 == null)) : ((str1.compareTo(str2) == 0));
	}

	public static boolean isEmpty(String str) {
		return !(str != null && str.trim().length() != 0);
	}

	public static boolean isWord(String str) {
		if (str == null)
			return false;
		int len = str.length();
		for (int i = 0; i < len; i++) {
			if (!Character.isLetter(str.charAt(i)))
				return false;
		}
		return true;
	}

	public static boolean isAlphanumeric(String str) {
		if (str == null)
			return false;
		int len = str.length();
		for (int i = 0; i < len; i++) {
			if (!Character.isLetterOrDigit(str.charAt(i)))
				return false;
		}
		return true;
	}

	public static boolean isNumeric(String str) {
		return str.matches("[-+]?\\d*\\.?\\d+");
	}

	public static String trim(String str) {
		return trim(str, (String) null);
	}

	public static long zeroConvertLong(String src) {
		if (src == null || src.equals("null") || "".equals(src) || " ".equals(src))
			return 0L;
		return Long.parseLong(src.trim());
	}

	public static String trim(String str, String def) {
		return (str == null) ? def : str.trim();
	}

	public static String ltrim(String str) {
		return stripStart(str, null);
	}

	public static String rtrim(String str) {
		return stripEnd(str, null);
	}

	private static String strPad(String str, int size, String padStr, boolean where) {
		if (str == null)
			return "";
		if (str.length() >= size)
			return str;
		String res = null;
		StringBuffer sb = new StringBuffer();
		String tmpStr = null;
		int tmpSize = size - str.length();
		for (int i = 0; i < size; i += padStr.length())
			sb.append(padStr);
		tmpStr = sb.toString().substring(0, tmpSize);
		if (where) {
			res = tmpStr.concat(str);
		} else {
			res = str.concat(tmpStr);
		}
		return res;
	}

	public static String left(String str, int len) {
		if (str == null || len < 0)
			return "";
		if (str.length() < len)
			return str;
		return str.substring(0, len);
	}

	public static String right(String str, int len) {
		if (str == null || len < 0)
			return "";
		if (str.length() < len)
			return str;
		return str.substring(str.length() - len);
	}

	public static String mid(String str, int pos, int len) {
		if (str == null || len < 0 || pos > str.length())
			return "";
		if (pos < 0)
			pos = 0;
		if (str.length() < pos + len)
			return str.substring(pos);
		return str.substring(pos, pos + len);
	}

	public static String lPad(String str, int size, char padChar) {
		return lPad(str, size, String.valueOf(padChar));
	}

	public static String lPad(String str, int size, String padStr) {
		return strPad(str, size, padStr, true);
	}

	public static String rPad(String str, int size, char padChar) {
		return rPad(str, size, String.valueOf(padChar));
	}

	public static String rPad(String str, int size, String padStr) {
		return strPad(str, size, padStr, false);
	}

	public static String substring(String input, int beginIndex, int endIndex) {
		if (input == null)
			input = "";
		if (beginIndex >= input.length())
			return "";
		if (beginIndex < 0)
			beginIndex = 0;
		if (endIndex < 0 || endIndex > input.length())
			endIndex = input.length();
		if (endIndex < beginIndex)
			return "";
		return input.substring(beginIndex, endIndex);
	}

	public static String getByteCut(String inputString, int maxBytes) throws UnsupportedEncodingException {
		String outputString = "";
		Charset CHARSET = Charset.forName("UTF-8");
		if (inputString == null)
			return "";
		byte[] bytes = inputString.getBytes(CHARSET);
		int len = 0;
		if (bytes.length > maxBytes) {
			len = maxBytes;
		} else {
			len = bytes.length;
		}
		CharsetDecoder decoder = CHARSET.newDecoder();
		decoder.onMalformedInput(CodingErrorAction.IGNORE);
		decoder.reset();
		try {
			CharBuffer decoded = decoder.decode(ByteBuffer.wrap(bytes, 0, len));
			outputString = decoded.toString();
		} catch (CharacterCodingException e) {
			e.printStackTrace();
		}
		return outputString;
	}

	public static String getStringCut(String str, int sz) throws UnsupportedEncodingException {
		str = ObjectUtil.nvl(str, "");
		if (str.equals("") || (str.getBytes()).length <= sz)
			return str;
		String a = str;
		int i = 0;
		String imsi = "";
		String rlt = "";
		imsi = a.substring(0, 1);
		while (i < sz) {
			byte[] ar = imsi.getBytes();
			i += ar.length;
			rlt = String.valueOf(rlt) + imsi;
			a = a.substring(1);
			if (a.length() == 1) {
				imsi = a;
				continue;
			}
			if (a.length() > 1)
				imsi = a.substring(0, 1);
		}
		return String.valueOf(rlt) + "...";
	}

	public static String replace(String source, char ch, String replace) {
		return replace(source, ch, replace, -1);
	}

	public static String replace(String source, char ch, String replace, int max) {
		return replace(source, (new StringBuilder(String.valueOf(ch))).toString(), replace, max);
	}

	public static String replace(String source, String original, String replace) {
		return replace(source, original, replace, -1);
	}

	public static String replace(String source, String original, String replace, int max) {
		if (source == null)
			return null;
		int nextPos = 0;
		int currentPos = 0;
		int len = original.length();
		StringBuffer result = new StringBuffer(source.length());
		while ((nextPos = source.indexOf(original, currentPos)) != -1) {
			result.append(source.substring(currentPos, nextPos));
			result.append(replace);
			currentPos = nextPos + len;
			if (--max == 0)
				break;
		}
		if (currentPos < source.length())
			result.append(source.substring(currentPos));
		return result.toString();
	}

	public static String repeat(String pattern, int n) {
		if (pattern == null)
			return null;
		StringBuffer sb = new StringBuffer(n * pattern.length());
		repeat(sb, pattern, n);
		return sb.toString();
	}

	private static void repeat(StringBuffer sb, String pattern, int n) {
		if (pattern == null)
			return;
		for (int i = 0; i < n; i++)
			sb.append(pattern);
	}

	public static int indexOf(String str, String[] strs) {
		if (str == null)
			return -1;
		int len = strs.length;
		int tmp = 0;
		int ret = Integer.MAX_VALUE;
		for (int i = 0; i < len; i++) {
			tmp = str.indexOf(strs[i]);
			if (tmp != -1)
				if (tmp < ret) {
					ret = tmp;
					break;
				}
		}
		return (ret == Integer.MAX_VALUE) ? -1 : ret;
	}

	public static int lastIndexOf(String str, String[] strs) {
		if (str == null)
			return -1;
		int len = strs.length;
		int ret = -1;
		int tmp = 0;
		for (int i = 0; i < len; i++) {
			tmp = str.lastIndexOf(strs[i]);
			if (tmp > ret)
				ret = tmp;
		}
		return ret;
	}

	public static String getLastValue(String packageName) {
		return packageName.substring(packageName.lastIndexOf('.') + 1);
	}

	public static List<String> tokenizer(String source, String deli) {
		if (source == null)
			return null;
		if (deli == null)
			deli = " ";
		int idx = source.indexOf(deli);
		List<String> list = new ArrayList<>();
		while (idx > -1) {
			String sub = source.substring(0, idx);
			source = source.substring(idx + 1);
			idx = source.indexOf(deli);
			list.add(sub);
		}
		list.add(source);
		return list;
	}

	public static String htmlEscape(String s) {
		if (s == null) {
			s = "";
		} else {
			s = HtmlUtils.htmlEscape(s);
		}
		return s;
	}

	public static String javaScriptEscape(String input) {
		if (input == null)
			return input;
		StringBuffer filtered = new StringBuffer(input.length());
		char prevChar = Character.MIN_VALUE;
		for (int i = 0; i < input.length(); i++) {
			char c = input.charAt(i);
			if (c == '"') {
				filtered.append("\\\"");
			} else if (c == '\'') {
				filtered.append("\\'");
			} else if (c == '\\') {
				filtered.append("\\\\");
			} else if (c == '/') {
				filtered.append("\\/");
			} else if (c == '\t') {
				filtered.append("\\t");
			} else if (c == '\n') {
				if (prevChar != '\r')
					filtered.append("\\n");
			} else if (c == '\r') {
				filtered.append("\\n");
			} else if (c == '\f') {
				filtered.append("\\f");
			} else {
				filtered.append(c);
			}
			prevChar = c;
		}
		return filtered.toString();
	}

	/*
	public static String getSafeString(Object obj) {
		if (obj == null)
			return null;
		if (obj instanceof String)
			return String.valueOf(obj).trim();
		if (obj instanceof java.util.Collections)
			return StringUtils.collectionToDelimitedString((Collection) obj, ";");
		return obj.toString();
	}
	*/

	public static boolean toBoolean(Object v) {
		if (v instanceof String) {
			if ("t".equalsIgnoreCase((String) v) || "true".equalsIgnoreCase((String) v)
					|| "y".equalsIgnoreCase((String) v) || "yes".equalsIgnoreCase((String) v))
				return true;
			return false;
		}
		if (v instanceof Boolean)
			return ((Boolean) v).booleanValue();
		return false;
	}

	public static String capitalize(String str) {
		if (str == null || str.length() == 0)
			return str;
		return changeFirstCharacterCase(str.toLowerCase(), true);
	}

	public static String uncapitalize(String str) {
		return changeFirstCharacterCase(str, false);
	}

	private static String changeFirstCharacterCase(String str, boolean capitalize) {
		if (str == null || str.length() == 0)
			return str;
		StringBuffer buf = new StringBuffer(str.length());
		if (capitalize) {
			buf.append(Character.toUpperCase(str.charAt(0)));
		} else {
			buf.append(Character.toLowerCase(str.charAt(0)));
		}
		buf.append(str.substring(1));
		return buf.toString();
	}

	public static String toUpperCase(String str, String def) {
		if (str == null)
			return def;
		return str.toUpperCase();
	}

	public static String toUpperCase(String str) {
		return toUpperCase(str, "");
	}

	public static String toLowerCase(String str, String def) {
		if (str == null)
			return def;
		return str.toLowerCase();
	}

	public static String toLowerCase(String str) {
		return toLowerCase(str, "");
	}

	public static String capsule(String pre, Object dst, String after) {
		if (ObjectUtil.isEmpty(dst))
			return "";
		return String.valueOf(pre) + dst + after;
	}

	public static String strRepeat(String input, int multiplier) {
		StringBuffer sBuf = new StringBuffer();
		try {
			for (int i = 0; i < multiplier; i++)
				sBuf.append(input);
		} catch (Exception e) {
			return null;
		}
		return sBuf.toString();
	}

	public static String toCamelCase(String columnName) {
		return convert2CamelCase(columnName);
	}

	public static String convert2CamelCase(String underScore) {
		if (underScore.indexOf('_') < 0)
			return underScore;
		StringBuilder result = new StringBuilder();
		boolean nextUpper = false;
		int len = underScore.length();
		for (int i = 0; i < len; i++) {
			char currentChar = underScore.charAt(i);
			if (currentChar == '_') {
				nextUpper = true;
			} else if (nextUpper) {
				result.append(Character.toUpperCase(currentChar));
				nextUpper = false;
			} else {
				result.append(Character.toLowerCase(currentChar));
			}
		}
		return result.toString();
	}

	public static int countLines(String str) {
		if (str != null) {
			String[] lines = str.split("\r\n|\r|\n");
			return lines.length;
		}
		return 0;
	}

	public static String nvl(String value) {
		return nvl(value, "");
	}

	public static int nvl(int value) {
		return nvl(Integer.valueOf(value), 0);
	}

	public static String nvl(String value, String defaultValue) {
		if (value == null || value.equals("") || value.equals("null"))
			return defaultValue;
		return value;
	}

	public static int nvl(String value, int defaultValue) {
		if (value == null || value.equals("") || value.equals("null"))
			return defaultValue;
		return Integer.parseInt(value);
	}

	public static String nvl(Object value) {
		return nvl(value, "");
	}

	public static String nvl(Object value, String defaultValue) {
		if (value == null || value.toString().equals("null"))
			return defaultValue;
		if (value.toString().equals(""))
			return defaultValue;
		return value.toString();
	}

	public static int nvl(Object value, int defaultValue) {
		if (value == null)
			return defaultValue;
		if (value.toString().equals(""))
			return defaultValue;
		return Integer.parseInt(value.toString());
	}

	public static String isNull(String str, String setstr) {
		return isNull(str, setstr, (String) null);
	}

	public static String isNull(String str, String setstr, String setstr2) {
		String result = null;
		if (str == null) {
			result = setstr;
		} else if (setstr2 == null) {
			result = str;
		} else {
			result = setstr2;
		}
		return result;
	}

	public static boolean splitExistYn(String source, String sepe_str, String compare) {
		boolean result1 = false;
		String[] result = split(source, sepe_str);
		if ("".equals(compare))
			return false;
		for (int index = 0; index < result.length; index++) {
			if (nvl(result[index]).trim().equalsIgnoreCase(compare.trim())) {
				result1 = true;
				break;
			}
		}
		return result1;
	}

	public static boolean splitExistYn(String[] source, String compare) {
		boolean result1 = false;
		String[] result = source;
		if ("".equals(compare))
			return false;
		for (int index = 0; index < result.length; index++) {
			if (nvl(result[index]).trim().equalsIgnoreCase(compare.trim())) {
				result1 = true;
				break;
			}
		}
		return result1;
	}

	public static String[] split(String str, String sepe_str) {
		int index = 0;
		String[] result = new String[search(str, sepe_str) + 1];
		String strCheck = new String(str);
		while (strCheck.length() != 0) {
			int begin = strCheck.indexOf(sepe_str);
			if (begin == -1) {
				result[index] = strCheck;
				break;
			}
			int end = begin + sepe_str.length();
			result[index++] = strCheck.substring(0, begin);
			strCheck = strCheck.substring(end);
			if (strCheck.length() == 0) {
				result[index] = strCheck;
				break;
			}
		}
		return result;
	}

	public static String[] split(String str) {
		return split(str, ",");
	}

	public static int search(String strTarget, String strSearch) {
		int result = 0;
		String strCheck = new String(strTarget);
		for (int i = 0; i < strTarget.length();) {
			int loc = strCheck.indexOf(strSearch);
			if (loc == -1)
				break;
			result++;
			i = loc + strSearch.length();
			strCheck = strCheck.substring(i);
		}
		return result;
	}

	public static String unSplit(String[] str) {
		return unSplit(str, ",");
	}

	public static String unSplit(String[] str, String sepe_str) {
		int index = 0;
		String result = "";
		if (str != null)
			for (int i = 0; i < str.length; i++) {
				if (i != str.length - 1) {
					result = String.valueOf(result) + str[i] + sepe_str;
				} else {
					result = String.valueOf(result) + str[i];
				}
			}
		return result;
	}

	public static List<String> unSplitList(String[] str) {
		String result = "";
		List<String> list = new ArrayList<>();
		for (int i = 0; i < str.length; i++) {
			result = str[i];
			list.add(result);
		}
		return list;
	}

	public static List<String> unSplitList(String str, String sep) {
		return unSplitList(split(str, sep));
	}

	public static List<String> unSplitList(String str) {
		return unSplitList(split(str, ","));
	}

	public static String getRandomString(int length) {
		StringBuffer buffer = new StringBuffer();
		Random random = new Random();
		String[] chars = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,!,@,#,$,%,^,&,(,),*"
				.split(",");
		for (int i = 0; i < length; i++)
			buffer.append(chars[random.nextInt(chars.length)]);
		return buffer.toString();
	}

	public static double getValueNum(String val) {
		if (val == null)
			return 0.0D;
		String retValue = val.equals("") ? "0" : val;
		retValue = retValue.replaceAll(",", "");
		return Double.parseDouble(retValue);
	}

	public static String amountFormater(String in) {
		Double amount = Double.valueOf(Double.parseDouble(in));
		NumberFormat nf = NumberFormat.getInstance();
		return nf.format(amount);
	}

	public static String getUrlEncode(String url) {
		if (url != null) {
			try {
				url = url.replaceAll(" ", "*20");
				url = URLEncoder.encode(url, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			url = url.replace('%', '*');
		}
		return url;
	}

	public static String getUrlDecode(String url) {
		if (url != null) {
			url = url.replace('*', '%');
			try {
				url = URLDecoder.decode(url, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return url;
	}

	public static String fixTextSize(String strText, char cSpace, int iTotalSize) {
		if (strText == null)
			strText = "";
		if (strText.length() < iTotalSize) {
			char[] carraySpace = new char[iTotalSize - strText.length()];
			Arrays.fill(carraySpace, cSpace);
			String strSpace = new String(carraySpace);
			return String.valueOf(strSpace) + strText;
		}
		return strText.substring(strText.length() - iTotalSize, strText.length());
	}

	public static String getString(HttpServletRequest request, String strParameterName) {
		return trim(request.getParameter(strParameterName), "");
	}

	public static String getString(HttpServletRequest request, String strParameterName, String sDefaultValue) {
		return trim(request.getParameter(strParameterName), sDefaultValue);
	}

	public static String[] getStringArr(HttpServletRequest request, String strParameterName) {
		String[] arrTemp = request.getParameterValues(strParameterName);
		if (arrTemp != null)
			for (int i = 0; i < arrTemp.length; i++) {
				if (arrTemp[i] != null) {
					arrTemp[i] = trim(arrTemp[i], "");
				} else {
					arrTemp[i] = "";
				}
			}
		return arrTemp;
	}

	public static String toWEB_BOX(String str) {
		try {
			str = str.replace("<br>", "\r\n");
			str = str.replace("&amp;", "&&");
			str = str.replace("&lt;", "<");
			str = str.replace("&gt;", ">");
			str = str.replace("&quot;", "\\\"");
			str = str.replace("&#039;", "\\'");
			str = str.replace("&#092;", "\\\\");
		} catch (Exception exception) {
		}
		return str;
	}

	public static String convertToHtmlTag(String str) {
	    if (str == null)
	      return ""; 
	    str = str.replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;").replaceAll("&#8226;", "•").replaceAll("&#8228;", "•");
	    return str;
	  }

	public static String convertToHtmlTag2(String str) {
		if (str == null)
			return "";
		str = str.replaceAll("\r\n", "<br>").replaceAll("\n", "<br>");
		return str;
	}

	public static String removeTag(String html) {
		if (html == null || "".equals(html))
			return "";
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	public String RemoveHTMLTag(String changeStr) {
		if (changeStr != null && !changeStr.equals("")) {
			changeStr = changeStr.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		} else {
			changeStr = "";
		}
		return changeStr;
	}

	public static String addLinebreaks(String input, int maxCharInLine) {
		StringTokenizer tok = new StringTokenizer(input, "");
		StringBuilder output = new StringBuilder(input.length());
		int lineLen = 0;
		while (tok.hasMoreTokens()) {
			String word = tok.nextToken();
			while (word.length() > maxCharInLine) {
				output.append(String.valueOf(word.substring(0, maxCharInLine - lineLen)) + "\n");
				word = word.substring(maxCharInLine - lineLen);
				lineLen = 0;
			}
			if (lineLen + word.length() > maxCharInLine) {
				output.append("\n");
				lineLen = 0;
			}
			output.append(String.valueOf(word) + " ");
			lineLen += word.length() + 1;
		}
		return output.toString();
	}

	public static String getStrFixLength(String str, int length) {
		char[] strArr = new char[length];
		int len = 0;
		if (str.length() > length) {
			len = length;
		} else {
			len = str.length();
		}
		System.arraycopy(str.toCharArray(), 0, strArr, 0, len);
		return new String(strArr);
	}

	public static Boolean checkByteLength(String sourceStr, Integer maxLength) {
		Integer byteLen = Integer.valueOf(0);
		Boolean flag = Boolean.valueOf(true);
		if (maxLength.intValue() < 0)
			return flag;
		for (Integer idx = Integer.valueOf(0); idx.intValue() < sourceStr.length(); idx = Integer
				.valueOf(idx.intValue() + 1)) {
			char ch = sourceStr.charAt(idx.intValue());
			Integer len = Integer.valueOf((ch >> 11 > 11) ? 3 : ((ch >> 7 > 7) ? 2 : 1));
			byteLen = Integer.valueOf(byteLen.intValue() + len.intValue());
			if (byteLen.intValue() > maxLength.intValue())
				flag = Boolean.valueOf(false);
		}
		return flag;
	}

	public static String parseKeyValue(String sourceStr, String key) {
		if ("".equals(nvl(sourceStr)) || "".equals(nvl(sourceStr)))
			return "";
		String rv = "";
		KeyValuePairParser kv = new KeyValuePairParser(sourceStr);
		rv = kv.find(key);
		return rv;
	}

	/*
	public static List<String> parseKeyValueList(String sourceStr, String key) {
		if ("".equals(nvl(sourceStr)) || "".equals(nvl(sourceStr)))
			return null;
		KeyValuePairParser kv = new KeyValuePairParser(sourceStr);
		Iterable<String> values = kv.findAll(key);
		List<String> list = new ArrayList<>();
		for (String item1 : values)
			list.add(item1);
		return list;
	}
	*/

	public static String convertTextAreaToStringCRLF(String sOrgString) {
		StringBuffer sbRet = new StringBuffer();
		for (int i = 0; i < sOrgString.length(); i++) {
			switch (sOrgString.charAt(i)) {
			case '\n':
				sbRet.append("<br>");
				if (i + 1 < sOrgString.length() && sOrgString.charAt(i + 1) == '\r')
					i++;
				break;
			default:
				if ((sOrgString.charAt(i) & 0x80) > 0) {
					if (i + 1 >= sOrgString.length())
						break;
					sbRet.append(sOrgString.charAt(i));
					i++;
				}
				sbRet.append(sOrgString.charAt(i));
				break;
			}
		}
		return sbRet.toString();
	}

	public static String[] getXssValues(String[] values) {
		if (values == null)
			return null;
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++)
			encodedValues[i] = cleanXSS(values[i]);
		return encodedValues;
	}

	public static String cleanXSS(String value) {
		value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
		value = value.replaceAll("'", "& #39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"");
		return value;
	}

	public static String[] getXssScript(String[] values) {
		if (values == null)
			return null;
		int count = values.length;
		String[] encodedValues = new String[count];
		for (int i = 0; i < count; i++)
			encodedValues[i] = cleanXssScript(values[i]);
		return encodedValues;
	}

	private static String cleanXssScript(String value) {
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"");
		return value;
	}

	public static boolean equalsAny(String src, String... compare) {
		if (src == null || compare == null)
			return false;
		boolean eq = false;
		byte b;
		int i;
		String[] arrayOfString;
		for (i = (arrayOfString = compare).length, b = 0; b < i;) {
			String str = arrayOfString[b];
			if (src.equals(str)) {
				eq = true;
				break;
			}
			b++;
		}
		return eq;
	}

	public static String toCamel(String value) {
		return capitalize(lowerCase(value));
	}

	public static String toCamel(String value, String devide) {
		String s = "";
		byte b;
		int i;
		String[] arrayOfString;
		for (i = (arrayOfString = split(value, devide)).length, b = 0; b < i;) {
			String str = arrayOfString[b];
			s = String.valueOf(s) + toCamel(str);
			b++;
		}
		return s;
	}

	public static String camelToUnderscore(String value) {
		return uncapitalize(value).replaceAll("([A-Z])", "_$1").replaceAll("__", "_");
	}

	public static String[] firstAdd(String[] valueList, String value) {
		String[] result = new String[valueList.length + 1];
		result[0] = value;
		for (int index = 1; index < valueList.length + 1; index++)
			result[index] = valueList[index - 1];
		return result;
	}

	public static String[] lastAdd(String[] valueList, String value) {
		String[] result = new String[valueList.length + 1];
		for (int index = 0; index < valueList.length; index++)
			result[index] = valueList[index];
		result[valueList.length] = value;
		return result;
	}

	public static boolean isNotExist(String[] valueList, String value) {
		if (value == null)
			return true;
		for (int index = 0; index < valueList.length; index++) {
			if (value.equals(valueList[index]))
				return false;
		}
		return true;
	}

	public static String nullToString(String str) {
		return nullToString(str, "");
	}

	public static String nullToString(String str, String str1) {
		return isNotEmpty(str) ? str : (isNotEmpty(str1) ? str1 : "");
	}

	public static boolean stringYnToBoolean(String str) {
		return !(!"Y".equalsIgnoreCase(str) && !"true".equalsIgnoreCase(str));
	}

	public static String booleanToStringYn(boolean bool) {
		return bool ? "Y" : "N";
	}

	public static String substringBytes(String str, int start, int end) {
		if (str == null)
			return "";
		String tmp = str;
		int chrIdx = 0, byteLength = 0;
		if ((tmp.getBytes()).length > end - 1) {
			while (byteLength + 1 < end - 1) {
				char chr = tmp.charAt(chrIdx);
				byteLength++;
				chrIdx++;
				if (chr > '')
					byteLength += 2;
			}
			tmp = tmp.substring(start, chrIdx);
		}
		return tmp;
	}

	public static String calcMath(String strMode, double nCalcVal, int nDigit) {
		if ("CEIL".equals(strMode)) {
			if (nDigit < 0) {
				nDigit = -nDigit;
				nCalcVal = Math.ceil(nCalcVal / Math.pow(10.0D, nDigit)) * Math.pow(10.0D, nDigit);
			} else {
				nCalcVal = Math.ceil(nCalcVal * Math.pow(10.0D, nDigit)) / Math.pow(10.0D, nDigit);
			}
		} else if ("FLOOR".equals(strMode)) {
			if (nDigit < 0) {
				nDigit = -nDigit;
				nCalcVal = Math.floor(nCalcVal / Math.pow(10.0D, nDigit)) * Math.pow(10.0D, nDigit);
			} else {
				nCalcVal = Math.floor(nCalcVal * Math.pow(10.0D, nDigit)) / Math.pow(10.0D, nDigit);
			}
		} else if (nDigit < 0) {
			nDigit = -nDigit;
			nCalcVal = Math.round(nCalcVal / Math.pow(10.0D, nDigit)) * Math.pow(10.0D, nDigit);
		} else {
			nCalcVal = Math.round(nCalcVal * Math.pow(10.0D, nDigit)) / Math.pow(10.0D, nDigit);
		}
		return String.valueOf(nCalcVal);
	}

	public static String formatDate(String str, String oFormat, String nFormat) {
		if (isNull(str, "").equals(""))
			return "";
		SimpleDateFormat formatter = new SimpleDateFormat(oFormat, Locale.KOREA);
		Date date = null;
		try {
			date = formatter.parse(str);
		} catch (ParseException e) {
			System.out.println(e.toString());
		}
		formatter.applyPattern(nFormat);
		return formatter.format(date);
	}

	public static String formatBizNumber(String str) {
		if (isNull(str, "").equals(""))
			return "";
		int len = str.length();
		if (len != 10)
			return str;
		String message = "{0}-{1}-{2}";
		Object[] args = { str.substring(0, 3), str.substring(3, 5), str.substring(5, 10) };
		return MessageFormat.format(message, args);
	}

	public static String formatPhoneNumber(String str) {
		if (isNull(str, "").equals(""))
			return "";
		if (str == null)
			return "";
		int len = str.length();
		if (len < 9)
			return str;
		String message = "{0}-{1}-{2}";
		String[] arrayOfString = new String[3];
		String body = null;
		if (str.startsWith("01")) {
			arrayOfString[0] = str.substring(0, 3);
			body = str.substring(3);
		} else if (str.startsWith("02")) {
			arrayOfString[0] = str.substring(0, 2);
			body = str.substring(2);
		} else {
			arrayOfString[0] = str.substring(0, 3);
			body = str.substring(3);
		}
		if (body.length() == 7) {
			arrayOfString[1] = body.substring(0, 3);
			arrayOfString[2] = body.substring(3);
		} else if (body.length() == 8) {
			arrayOfString[1] = body.substring(0, 4);
			arrayOfString[2] = body.substring(4);
		} else {
			message = "{0}-{1}";
			arrayOfString[1] = body;
		}
		return MessageFormat.format(message, (Object[]) arrayOfString);
	}

	public static String formatPostNumber(String str) {
		if (isNull(str, "").equals(""))
			return "";
		int len = str.length();
		if (len != 6)
			return str;
		String message = "{0}-{1}";
		String[] arrayOfString = new String[2];
		arrayOfString[0] = str.substring(0, 3);
		arrayOfString[1] = str.substring(3);
		return MessageFormat.format(message, (Object[]) arrayOfString);
	}
}