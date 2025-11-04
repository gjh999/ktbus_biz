package egovframework.let.cmm.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

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
public class DateUtil {
	public static final int REAL = 1;

	public static final int FIRST = 2;

	public static final int LAST = 3;

	public static String getTodayStr() {
		return dateToStr(new Date(), "ddMMyyyy");
	}

	public static String getTodayStr(String dateFormat) {
		return dateToStr(new Date(), dateFormat);
	}

	public static String getTodayISOStr(String dateFormat) {
		DateTime dtISO = DateTime.now();
		DateTimeFormatter dtf = DateTimeFormat.forPattern(dateFormat);
		return dtISO.toString(dtf);
	}

	public static String dateToStr(Date isoDate, String dateFormat) {
		if (isoDate == null)
			return "";
		return convertWithLocale(isoDate, dateFormat);
	}

	public static Date strToDate(String isoDateStr, String dateFormat) throws ParseException {
		if (StringUtil.isEmpty(isoDateStr))
			return null;
		SimpleDateFormat formatter = new SimpleDateFormat(dateFormat);
		Date date = formatter.parse(isoDateStr);
		return convertWithLocale(date);
	}

	public static boolean isDateFormat(String isoDateStr, String format) {
		boolean isDateStr = true;
		try {
			strToDate(isoDateStr, format);
		} catch (ParseException e) {
			isDateStr = false;
		}
		return isDateStr;
	}

	public static String changeFormat(String dateStr, String beforeFormat, String afterFormat) throws ParseException {
		if (dateStr == null || "".equals(dateStr))
			return null;
		SimpleDateFormat srcSdf = new SimpleDateFormat(beforeFormat);
		Date date = srcSdf.parse(dateStr);
		SimpleDateFormat targetSdf = new SimpleDateFormat(afterFormat);
		return targetSdf.format(date);
	}

	public static Date addHHmmss(Date date) throws ParseException {
		String today = DateTime.now().toString(DateTimeFormat.forPattern("HHmmss"));
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(11, Integer.parseInt(today.substring(0, 2)));
		cal.set(12, Integer.parseInt(today.substring(2, 4)));
		cal.set(13, Integer.parseInt(today.substring(4, 6)));
		return cal.getTime();
	}

	public static Date addDays(int days) {
		return addDays(new Date(), days);
	}

	public static Date addDays(Date date, int days) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(5, days);
		return cal.getTime();
	}

	public static Date addMonth(int month) {
		return addMonth(new Date(), month);
	}

	public static Date addMonth(Date date, int month) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(2, month);
		return cal.getTime();
	}

	public static Date getStartOfDay(Date strtDt) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strtDt);
		cal.set(11, 0);
		cal.set(12, 0);
		cal.set(13, 0);
		cal.set(14, 0);
		return cal.getTime();
	}

	public static Date getStartOfDay(Date strtDt, Date defaultDate) {
		return getStartOfDay((strtDt == null) ? defaultDate : strtDt);
	}

	public static Date getEndOfDay(Date endDt) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(endDt);
		cal.set(11, 23);
		cal.set(12, 59);
		cal.set(13, 59);
		cal.set(14, 999);
		return cal.getTime();
	}

	public static Date getEndOfDay(Date endDt, Date defaultDate) {
		return getEndOfDay((endDt == null) ? defaultDate : endDt);
	}

	public static Date convertToGregorian(String dateStr, String format) {
		if (StringUtil.length(dateStr) == 8 && "ddMMyyyy HH:mm:ss".equals(format))
			dateStr = String.valueOf(dateStr) + " 00:00:00";
		DateTimeFormatter formatter = DateTimeFormat.forPattern(format);
		DateTime dtEthiopic = formatter.parseDateTime(dateStr);
		return dtEthiopic.toDate();
	}

	public static Date convertWithLocale(Date isoDate) {
		DateTime dtISO = new DateTime(isoDate);
		return dtISO.toDate();
	}

	public static String convertWithLocale(Date isoDate, String format) {
		DateTime dtISO = new DateTime(isoDate);
		DateTimeFormatter dtf = DateTimeFormat.forPattern(format);
		String nowStr = dtISO.toString(dtf);
		return nowStr;
	}

	public static final String getDateToString(Date dt, String format) {
		DateFormat df = new SimpleDateFormat(format);
		String strDate = "";
		if (df != null)
			strDate = df.format(dt);
		return strDate;
	}

	public static final String getDateTimeOfGMT(String timeZone, String format, Date date) {
		DateFormat df = new SimpleDateFormat(format);
		TimeZone tz = TimeZone.getTimeZone(timeZone);
		df.setTimeZone(tz);
		String gmtDate = df.format(date);
		return gmtDate;
	}

	public static final Date AddMinute(Date dt, int minutes) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(12, minutes);
		return cal.getTime();
	}

	public static final Date AddSecond(Date dt, int seconds) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(13, seconds);
		return cal.getTime();
	}

	public static final Date AddDay(Date dt, int days) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(5, days);
		return cal.getTime();
	}

	public static final String getYYYYMMDD(Date dt) {
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		String strDate = df.format(dt);
		return strDate;
	}

	public static Date getAddMonth(Date dt, int amount) throws ParseException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(2, amount);
		return cal.getTime();
	}

	public static Date getAddYear(Date dt, int amount) throws ParseException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(1, amount);
		return cal.getTime();
	}

	public static Date getAddHour(Date dt, int amount) throws ParseException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(11, amount);
		return cal.getTime();
	}

	public static Date getAddDate(Date dt, int amount) throws ParseException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(5, amount);
		return cal.getTime();
	}

	public static int getYear(Date dt) {
		Calendar cal = Calendar.getInstance(Locale.FRANCE);
		cal.setTime(dt);
		int i = cal.get(1);
		return i;
	}

	public static int getMonth(Date dt) {
		Calendar cal = Calendar.getInstance(Locale.FRANCE);
		cal.setTime(dt);
		int i = cal.get(2);
		return i;
	}

	public static Date getLastDayOfMon(Date dt) {
		Calendar cal = Calendar.getInstance();
		cal.set(dt.getYear(), dt.getMonth(), 1);
		dt.setDate(cal.getActualMaximum(5));
		return dt;
	}

	public static final String getDateParamEvaluation(Date dt, String calcMethod, String intervalType, int interval, String outputDBFormat) throws ParseException {
	    Date toDate = new Date();
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(dt);
	    int intervalUnit = 5;
	    int intervalCount = 1;
	    String str;
	    switch ((str = intervalType).hashCode()) {
	      case -1034488570:
	        if (!str.equals("1분:1mi"))
	          break; 
	        intervalUnit = 12;
	        intervalCount = 1;
	        break;
	      case 47940426:
	        if (!str.equals("시:h"))
	          break; 
	        intervalUnit = 10;
	        intervalCount = 1;
	        break;
	      case 48916807:
	        if (!str.equals("월:m"))
	          break; 
	        intervalUnit = 2;
	        intervalCount = 1;
	        break;
	      case 92104076:
	        if (!str.equals("30분:30mi"))
	          break; 
	        intervalUnit = 12;
	        intervalCount = 30;
	        break;
	      case 379830186:
	        if (!str.equals("년도기준:yyyy"))
	          break; 
	        intervalUnit = 1;
	        intervalCount = 1;
	        break;
	      case 901391120:
	        if (!str.equals("10분:10mi"))
	          break; 
	        intervalUnit = 12;
	        intervalCount = 10;
	        break;
	      case 1043947034:
	        if (!str.equals("15분:15mi"))
	          break; 
	        intervalUnit = 12;
	        intervalCount = 15;
	        break;
	      case 1570464254:
	        if (!str.equals("일자:d"))
	          break; 
	        intervalUnit = 5;
	        intervalCount = 1;
	        break;
	    } 
	    cal.add(intervalUnit, interval * intervalCount);
	    toDate = cal.getTime();
	    if (calcMethod.equals("2:첫번째일")) {
	      switch (intervalUnit) {
	        case 1:
	          toDate = getToDate(getToString(toDate, "YYYY"), "YYYY");
	          break;
	        case 2:
	          toDate = getToDate(getToString(toDate, "YYYYMM"), "YYYYMM");
	          break;
	        case 5:
	          toDate = getToDate(getToString(toDate, "YYYYMMDD"), "YYYYMMDD");
	          break;
	        case 10:
	          toDate = getToDate(getToString(toDate, "YYYYMMDDHH"), "YYYYMMDDHH");
	          break;
	        case 12:
	          toDate = getToDate(getToString(toDate, "YYYYMMDDHHMI"), "YYYYMMDDHHMI");
	          break;
	      } 
	      cal.setTime(toDate);
	      while (cal.get(intervalUnit) % intervalCount != 0)
	        cal.add(intervalUnit, -1); 
	      toDate = cal.getTime();
	    }else if(calcMethod.equals("3:마지막일")) {switch(intervalUnit)

	{
	        case 1:
	          toDate = getToDate(String.valueOf(getToString(toDate, "YYYY")) + "1231235959", "YYYYMMDDHHMISS");
	          break;
	        case 2:
	          toDate = getToDate(String.valueOf(getToString(toDate, "YYYYMM")) + "01235959", "YYYYMMDDHHMISS");
	          break;
	        case 5:
	          toDate = getToDate(String.valueOf(getToString(toDate, "YYYYMMDD")) + "235959", "YYYYMMDDHHMISS");
	          break;
	        case 10:
	          toDate = getToDate(String.valueOf(getToString(toDate, "YYYYMMDDHH")) + "5959", "YYYYMMDDHHMISS");
	          break;
	        case 12:
	          toDate = getToDate(String.valueOf(getToString(toDate, "YYYYMMDDHHMI")) + "59", "YYYYMMDDHHMISS");
	          break;
	      }cal.setTime(toDate);if(cal.get(intervalUnit)+1%intervalCount!=0)
	{
		cal.add(intervalUnit, 1);
		while (cal.get(intervalUnit) % intervalCount != 0)
			cal.add(intervalUnit, 1);
		cal.add(intervalUnit, -1);
	}if(intervalUnit==2)cal.set(5,cal.getActualMaximum(5));toDate=cal.getTime();
	}return getToString(toDate,outputDBFormat);}

	public static final String getToString(Date dt, String DBFormat) {
		String toFormat = DBFormat;
		toFormat = toFormat.replace("YYYY", "yyyy");
		toFormat = toFormat.replace("MM", "MM");
		toFormat = toFormat.replace("DD", "dd");
		toFormat = toFormat.replace("HH", "HH");
		toFormat = toFormat.replace("MI", "mm");
		toFormat = toFormat.replace("SS", "ss");
		DateFormat df = new SimpleDateFormat(toFormat);
		String strDate = df.format(dt);
		return strDate;
	}

	public static final Date getToDate(String StringDate, String DBFormat) throws ParseException {
		String toFormat = DBFormat;
		toFormat = toFormat.replace("YYYY", "yyyy");
		toFormat = toFormat.replace("MM", "MM");
		toFormat = toFormat.replace("DD", "dd");
		toFormat = toFormat.replace("HH", "HH");
		toFormat = toFormat.replace("MI", "mm");
		toFormat = toFormat.replace("SS", "ss");
		DateFormat df = new SimpleDateFormat(toFormat);
		if (StringDate.length() > DBFormat.length())
			StringDate = StringDate.substring(0, DBFormat.length() - 1);
		Date dt = df.parse(StringDate);
		return dt;
	}

	public static String getYyyymmdd(Calendar cal) {
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyyMMdd";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(cal.getTime());
	}

	public static GregorianCalendar getGregorianCalendar(String yyyymmdd) {
		int yyyy = Integer.parseInt(yyyymmdd.substring(0, 4));
		int mm = Integer.parseInt(yyyymmdd.substring(4, 6));
		int dd = Integer.parseInt(yyyymmdd.substring(6));
		GregorianCalendar calendar = new GregorianCalendar(yyyy, mm - 1, dd, 0, 0, 0);
		return calendar;
	}

	public static String getCurrentDateTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyyMMddHHmmss";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today);
	}

	public static String getCurrentYear() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyy";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today);
	}

	public static int getCurrentYear(int year) {
		Calendar now = Calendar.getInstance();
		int iYear = now.get(1) + year;
		return iYear;
	}

	public static String getCurrentMonth() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "MM";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today);
	}

	public static String getCurrentDay() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "dd";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today);
	}

	public static String getCurrentTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "HHmmss";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
		return formatter.format(today);
	}

	public static String getCurrentYyyymmdd() {
		return getCurrentDateTime().substring(0, 8);
	}

	public static String getWeekToDay(String yyyymm, int week, String pattern) {
		Calendar cal = Calendar.getInstance(Locale.FRANCE);
		int new_yy = Integer.parseInt(yyyymm.substring(0, 4));
		int new_mm = Integer.parseInt(yyyymm.substring(4, 6));
		int new_dd = 1;
		cal.set(new_yy, new_mm - 1, new_dd);
		if (cal.get(7) == 1)
			week--;
		cal.add(5, (week - 1) * 7 + cal.getFirstDayOfWeek() - cal.get(7));
		SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.FRANCE);
		return formatter.format(cal.getTime());
	}

	public static String getOpDate(int field, int amount, String date) {
		GregorianCalendar calDate = getGregorianCalendar(date);
		if (field == 1) {
			calDate.add(1, amount);
		} else if (field == 2) {
			calDate.add(2, amount);
		} else {
			calDate.add(5, amount);
		}
		return getYyyymmdd(calDate);
	}

	public static int getWeek(String yyyymmdd, int addDay) {
		Calendar cal = Calendar.getInstance(Locale.FRANCE);
		int new_yy = Integer.parseInt(yyyymmdd.substring(0, 4));
		int new_mm = Integer.parseInt(yyyymmdd.substring(4, 6));
		int new_dd = Integer.parseInt(yyyymmdd.substring(6, 8));
		cal.set(new_yy, new_mm - 1, new_dd);
		cal.add(5, addDay);
		int week = cal.get(7);
		return week;
	}

	public static int getLastDayOfMon(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, 1);
		return cal.getActualMaximum(5);
	}

	public static int getLastDayOfMon(String yyyymm) {
		Calendar cal = Calendar.getInstance();
		int yyyy = Integer.parseInt(yyyymm.substring(0, 4));
		int mm = Integer.parseInt(yyyymm.substring(4)) - 1;
		cal.set(yyyy, mm, 1);
		return cal.getActualMaximum(5);
	}

	public static boolean isCorrect(String yyyymmdd) {
		boolean flag = false;
		if (yyyymmdd.length() < 8)
			return false;
		try {
			int yyyy = Integer.parseInt(yyyymmdd.substring(0, 4));
			int mm = Integer.parseInt(yyyymmdd.substring(4, 6));
			int dd = Integer.parseInt(yyyymmdd.substring(6));
			flag = isCorrect(yyyy, mm, dd);
		} catch (Exception ex) {
			return false;
		}
		return flag;
	}

	public static boolean isCorrect(int yyyy, int mm, int dd) {
		if (yyyy < 0 || mm < 0 || dd < 0)
			return false;
		if (mm > 12 || dd > 31)
			return false;
		int i = yyyy;
		String month = "00" + mm;
		String year_str = String.valueOf(i) + month.substring(month.length() - 2);
		int endday = getLastDayOfMon(year_str);
		if (dd > endday)
			return false;
		return true;
	}

	public static String getThisDay(String type) {
		Date date = new Date();
		SimpleDateFormat sdf = null;
		try {
			if (type.toLowerCase().equals("yyyymmdd")) {
				sdf = new SimpleDateFormat("yyyyMMdd");
				return sdf.format(date);
			}
			if (type.toLowerCase().equals("yyyymmddhh")) {
				sdf = new SimpleDateFormat("yyyyMMddHH");
				return sdf.format(date);
			}
			if (type.toLowerCase().equals("yyyymmddhhmm")) {
				sdf = new SimpleDateFormat("yyyyMMddHHmm");
				return sdf.format(date);
			}
			if (type.toLowerCase().equals("yyyymmddhhmmss")) {
				sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				return sdf.format(date);
			}
			if (type.toLowerCase().equals("yyyymmddhhmmssms")) {
				sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				return sdf.format(date);
			}
			sdf = new SimpleDateFormat(type);
			return sdf.format(date);
		} catch (Exception e) {
			return "[ ERROR ]: parameter must be 'YYYYMMDD', 'YYYYMMDDHH', 'YYYYMMDDHHSS'or 'YYYYMMDDHHSSMS'";
		}
	}

	public static String changeDateFormat(String yyyymmdd) {
	    String rtnDate = null;
	    String yyyy = yyyymmdd.substring(0, 4);
	    String mm = yyyymmdd.substring(4, 6);
	    String dd = yyyymmdd.substring(6, 8);
	    rtnDate = String.valueOf(yyyy) + " 년" + mm + " 월" + dd + " 일";
	    return rtnDate;
	  }

	public static long getDifferDays(String startDate, String endDate) {
		GregorianCalendar StartDate = getGregorianCalendar(startDate);
		GregorianCalendar EndDate = getGregorianCalendar(endDate);
		long difer = (EndDate.getTime().getTime() - StartDate.getTime().getTime()) / 86400000L;
		return difer;
	}

	public static int getDayOfWeek() {
		Calendar rightNow = Calendar.getInstance();
		int day_of_week = rightNow.get(7);
		return day_of_week;
	}

	public static int getWeekOfYear() {
		Locale LOCALE_COUNTRY = Locale.KOREA;
		Calendar rightNow = Calendar.getInstance(LOCALE_COUNTRY);
		int week_of_year = rightNow.get(3);
		return week_of_year;
	}

	public static int getWeekOfMonth() {
		Locale LOCALE_COUNTRY = Locale.KOREA;
		Calendar rightNow = Calendar.getInstance(LOCALE_COUNTRY);
		int week_of_month = rightNow.get(4);
		return week_of_month;
	}

	public static Calendar getCalendarInstance(String p_date) {
		Locale LOCALE_COUNTRY = Locale.FRANCE;
		Calendar retCal = Calendar.getInstance(LOCALE_COUNTRY);
		if (p_date != null && p_date.length() == 8) {
			int year = Integer.parseInt(p_date.substring(0, 4));
			int month = Integer.parseInt(p_date.substring(4, 6)) - 1;
			int date = Integer.parseInt(p_date.substring(6));
			retCal.set(year, month, date);
		}
		return retCal;
	}

	public static String getAddDate(int amount) {
		Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.add(5, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(month);
		buf.append(day);
		return buf.toString();
	}

	public static String getAddMonth(int amount) {
		Calendar cal = Calendar.getInstance(Locale.getDefault());
		cal.add(2, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(month);
		buf.append(day);
		return buf.toString();
	}

	public static String getAddDate(String date, int amount) throws ParseException {
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
		Date dt = fommatter.parse(date);
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(5, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(month);
		buf.append(day);
		return buf.toString();
	}

	public static String getAddMonth(String date, int amount) throws ParseException {
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
		Date dt = fommatter.parse(date);
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(2, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(month);
		buf.append(day);
		return buf.toString();
	}

	public static String getAddMonth(String date, int amount, String delimiter) throws ParseException {
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
		Date dt = fommatter.parse(date.replaceAll(delimiter, ""));
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(2, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(String.valueOf(delimiter) + month);
		buf.append(String.valueOf(delimiter) + day);
		return buf.toString();
	}

	public static String getAddDate(String date, int amount, String delimiter) throws ParseException {
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
		Date dt = fommatter.parse(date.replaceAll(delimiter, ""));
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		cal.add(5, amount);
		StringBuffer buf = new StringBuffer();
		buf.append(Integer.toString(cal.get(1)));
		String month = Integer.toString(cal.get(2) + 1);
		if (month.length() == 1)
			month = "0" + month;
		String day = Integer.toString(cal.get(5));
		if (day.length() == 1)
			day = "0" + day;
		buf.append(String.valueOf(delimiter) + month);
		buf.append(String.valueOf(delimiter) + day);
		return buf.toString();
	}

	public static String getNowNextMonth() {
		SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
		Calendar calendar = Calendar.getInstance();
		calendar.add(2, 1);
		return fommatter.format(calendar.getTime());
	}

	public static long getCurTimeMili() {
		Calendar cal = Calendar.getInstance();
		long toDate = cal.getTimeInMillis();
		return toDate;
	}

	public static long getTimeMili(String datetime) {
		Timestamp timestamp = null;
		long value = 0L;
		try {
			if (datetime != null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
				Date date = sdf.parse(datetime);
				value = date.getTime();
			} else {
				return 0L;
			}
		} catch (ParseException parseException) {
		}
		return value;
	}

	public static String getConvertDate(String date, String type) {
		return getConvertDate(date, type, "-");
	}

	public static String getConvertDate(String date, String type, String delimeter) {
		if (date == null)
			return "";
		date = date.trim();
		if (date.length() == 6 && type.equals("5"))
			return String.valueOf(date.substring(0, 4)) + delimeter + date.substring(4, 6);
		if (date.length() != 14)
			return date;
		if (type.equals("1"))
			return String.valueOf(date.substring(0, 4)) + delimeter + date.substring(4, 6) + delimeter
					+ date.substring(6, 8);
		if (type.equals("2"))
			return String.valueOf(date.substring(0, 4)) + delimeter + date.substring(4, 6) + delimeter
					+ date.substring(6, 8) + " " + date.substring(8, 10);
		if (type.equals("3"))
			return String.valueOf(date.substring(0, 4)) + delimeter + date.substring(4, 6) + delimeter
					+ date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12);
		if (type.equals("4"))
			return String.valueOf(date.substring(0, 4)) + delimeter + date.substring(4, 6) + delimeter
					+ date.substring(6, 8) + " " + date.substring(8, 10) + ":" + date.substring(10, 12) + ":"
					+ date.substring(12, 14);
		return date;
	}

	public static String[] getDiffMonth(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(sdf.parse(fromDate));
		} catch (Exception exception) {
		}
		int count = getDiffDayCount(fromDate, toDate);
		cal.add(2, -1);
		List<String> list = new ArrayList();
		for (int i = 0; i <= count; i++) {
			cal.add(2, 1);
			list.add(sdf.format(cal.getTime()));
		}
		String[] result = new String[list.size()];
		list.toArray(result);
		return result;
	}

	public static int getDiffDayCount(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		try {
			return (int) ((sdf.parse(toDate).getTime() - sdf.parse(fromDate).getTime()) / 1000L / 60L / 60L / 24L);
		} catch (Exception e) {
			return 0;
		}
	}

	public static Date StringToDate(String str_date) {
		Date date = null;
		try {
			date = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S")).parse(str_date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static String currentTimeMillDate() {
		long time = System.currentTimeMillis();
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String strDT = dayTime.format(new Date(time));
		return strDT;
	}

	public static String getFormattedDate(String strDate, String strFormat) {
		if (strDate == null || strDate.equals("") || (strDate.length() != 8 && strDate.length() != 14))
			return strDate;
		StringBuffer sbufferFormattedDay = new StringBuffer("");
		sbufferFormattedDay.append(strDate.substring(0, 4));
		sbufferFormattedDay.append(strFormat);
		String strMonth = strDate.substring(4, 6);
		sbufferFormattedDay.append(strMonth);
		sbufferFormattedDay.append(strFormat);
		String strDay = strDate.substring(6, 8);
		sbufferFormattedDay.append(strDay);
		return sbufferFormattedDay.toString();
	}

	public static String getFormattedTime(String strTime, String strFormat) {
		StringBuffer str = new StringBuffer();
		if (strTime != null && !strTime.equals("")) {
			str.append(strTime.substring(0, 2));
			str.append(strFormat);
			str.append(strTime.substring(2, 4));
			str.append(strFormat);
			str.append(strTime.substring(4, 6));
		}
		return str.toString();
	}

	public static String getCurrentDateTimeFormat(String format) {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		SimpleDateFormat formatter = new SimpleDateFormat(format, currentLocale);
		return formatter.format(today);
	}

	public static Long getDifferenceDate(String type, String startDate, String endDate, String dateFormat)
			throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
		Calendar startCal = Calendar.getInstance();
		startCal.setTime(simpleDateFormat.parse(startDate));
		Calendar endCal = Calendar.getInstance();
		endCal.setTime(simpleDateFormat.parse(endDate));
		if (type != null && !"".equals(type)) {
			if ("Y".equals(type.toUpperCase()))
				return Long.valueOf((((endCal.get(1) - startCal.get(1)) * 12 + endCal.get(2) - startCal.get(2)) / 12));
			if ("M".equals(type.toUpperCase()))
				return Long.valueOf((endCal.get(1) - startCal.get(1)) * 12L + (endCal.get(2) - startCal.get(2)));
			if ("D".equals(type.toUpperCase()))
				return Long.valueOf((endCal.getTimeInMillis() - startCal.getTimeInMillis()) / 1000L / 60L / 60L / 24L);
			return Long.valueOf(0L);
		}
		return Long.valueOf(0L);
	}

	public static String currentDateStr() throws ParseException {
		String[] weekDay = { "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" };
		String retStr = "";
		Calendar date = Calendar.getInstance();
		retStr = String.valueOf(date.get(1)) + "" + (date.get(2) + 1) + "" + date.get(5) + ""
				+ weekDay[date.get(7) - 1];
		return retStr;
	}
}