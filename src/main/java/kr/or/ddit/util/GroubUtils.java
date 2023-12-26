package kr.or.ddit.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class GroubUtils {
 	private static String dateFormat = "yyyy-MM-dd";
 	private static String dateFormat2 = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 날짜 데이터의 시간 부분을 지우고 yyyy-MM-dd 형태로 바꿔줌
	 *
	 * @param year 바꿀 날짜 데이터
	 * @return yyyy-MM-dd 형태의 문자열 날짜
	 */
	public static String yearToString(Date year) {
		SimpleDateFormat sDateFor = new SimpleDateFormat(dateFormat);
		String result = sDateFor.format(year);
		return result;
	};

	public static String yearToString2(Date year) {
		SimpleDateFormat sDateFor = new SimpleDateFormat(dateFormat2);
		String result = sDateFor.format(year);
		return result;
	};

}


