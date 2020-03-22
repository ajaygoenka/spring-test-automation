package com.experian.test.utils;

import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class DateUtils {

    public SimpleDateFormat getSimpleDateFormat(String pattern, String timeZone) {
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
        return new SimpleDateFormat(pattern);
    }

    public String getToday() {
        SimpleDateFormat todaySDF =  getSimpleDateFormat("yyyy-MM-dd", "UTC");
        return todaySDF.format(new Date());
    }


    public String getModifiedDate(SimpleDateFormat date,String plusOrMinus, int numOfDays) {
        Date modifiedDate = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(modifiedDate);

        switch (plusOrMinus) {
            case "+":
                c.add(Calendar.DATE, numOfDays);
                break;
            case "-":
                c.add(Calendar.DATE, -numOfDays);
                break;
            default:
                break;
        }

        return date.format(c.getTime());
    }

    public String getRequestedDateFromJson(String requestJson) {
        Matcher regexMatcher = Pattern.compile("(today)\\s*([+-])\\s*([0-9]+)").matcher(requestJson);
        if (regexMatcher.find()) {
            String entireMatch = regexMatcher.group(0);
            String plusOrMinus = regexMatcher.group(2);
            int numOfDays = Integer.parseInt(regexMatcher.group(3));
            requestJson = requestJson.replace(entireMatch, getModifiedDate(getSimpleDateFormat("yyyy-MM-dd", "UTC"), plusOrMinus, numOfDays));
        }
        else {
            requestJson = requestJson.replace("today", getToday());
        }
        return requestJson;
    }
}
