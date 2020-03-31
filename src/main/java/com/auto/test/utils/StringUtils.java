package com.auto.test.utils;

public class StringUtils extends org.apache.commons.lang3.StringUtils {
	
	public static boolean isNull(String str) {
		return str == null;
	}
	
	public static boolean isNotNull(String str) {
		return !isNull(str);
	}
	
	public static boolean isEmpty(String str) {
		return str.isEmpty();
	}
	
	/**
	 * <p>Checks if a String is null or empty.</p>
	 * @param str
	 * @return
	 */
	public static boolean isNullOrEmpty(String str) {
		return isNull(str) || isEmpty(str); 
	}

	/**
	 * <p>Checks if a String is not null or empty.</p>
	 * @param str
	 * @return
	 */
	public static boolean isNotNullOrEmpty(String str) {
		return !isNullOrEmpty(str);
	}
	
	/**
	 * <p>Checks if a String is empty, null and whitespace only.</p>
	 * @param str
	 * @return true/false flag
	 */
	/*public static boolean isBlank(String str) {
		return org.apache.commons.lang3.StringUtils.isBlank(str);
	}*/
	
	/**
	 * <p>Checks if a String is not empty, not null and not whitespace only.</p>
	 * @param str
	 * @return true/false flag
	 */
	public static boolean isNotBlank(String str) {
		return org.apache.commons.lang3.StringUtils.isNotBlank(str);
	}
	
	/**
	 * @param obj
	 * @param regex
	 * @param replacement
	 * @return resulting <tt>String</tt>
	 */
	public static String replaceLast(Object obj, String regex, String replacement) {
		return obj.toString().replaceAll("["+regex+"$]", replacement);
	}

	/**
	 * @param str
	 * @param regex
	 * @param replacement
	 * @return resulting <tt>String</tt>
	 */
	public static String replaceLast(String str, String regex, String replacement) {
		return str.replaceAll("["+regex+"$]", replacement);
	}
	
	/**
	 * @param integer
	 * @param strLength
	 * @param leadingPrefix
	 * @return resulting <tt>String</tt>
	 */
	public static String parseToString(int integer, int strLength, String leadingPrefix) {
		return String.format("%".concat(String.format("%s%s", leadingPrefix, strLength)).concat("d"), integer);
	}
	
	/**
	 * @param str to capitalize
	 * @return resulting <tt>String</tt>
	 */
	public static String capitalizeFirst(String str) {
		char c[] = str.toCharArray();
		c[0] = Character.toUpperCase(c[0]);
		return new String(c);
	}
	
	/**
	 * @param str to decapitalize 
	 * @return resulting <tt>String</tt>
	 */
	public static String decapitalizeFirst(String str) {
		char c[] = str.toCharArray();
		c[0] = Character.toLowerCase(c[0]);
		return new String(c);
	}

	public static boolean isInteger(Object object) {
		if(object instanceof Integer) {
			return true;
		} else {
			String string = object.toString();

			try {
				Integer.parseInt(string);
				return true;
			} catch(Exception e) {
				return false;
			}
		}

	}

	public static boolean isDouble(Object object) {
		if(object instanceof Double) {
			return true;
		} else {
			String string = object.toString();
			try {
				Double.parseDouble(string);
				return true;
			} catch(Exception e) {
				return false;
			}
		}

	}

	public static boolean isValidOperator(String actualResponse , String expectedResponse) {
		if(isDouble(actualResponse)){
			if(expectedResponse.contains(">") && !expectedResponse.contains("=")){
			return Double.parseDouble(actualResponse) > Double.parseDouble(expectedResponse.split(">")[1].trim());

			}else if(expectedResponse.contains("=>") || expectedResponse.contains(">=")){
				return Double.parseDouble(actualResponse) >= (expectedResponse.contains("=>") ? Double.parseDouble(expectedResponse.split("=>")[1].trim()) : Double.parseDouble(expectedResponse.split(">=")[1].trim()));
			}else if(expectedResponse.contains("<") && !expectedResponse.contains("=")){
				return	Double.parseDouble(actualResponse) < Double.parseDouble(expectedResponse.split(">")[1].trim());

			}else if(expectedResponse.contains("=<") || expectedResponse.contains("<=")){
				return Double.parseDouble(actualResponse) <= (expectedResponse.contains("=<") ? Double.parseDouble(expectedResponse.split("=<")[1].trim()) : Double.parseDouble(expectedResponse.split("<=")[1].trim()));

			}else if(expectedResponse.contains("=")){
				return Double.parseDouble(actualResponse) == Double.parseDouble(expectedResponse.split("=")[1].trim());
			}
		}
		return false;

	}


}
