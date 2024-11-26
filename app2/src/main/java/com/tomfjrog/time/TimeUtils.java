package com.tomfjrog.time;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class TimeUtils {

    // Function to return current system time
    public static String getCurrentSystemTime() {
        ZonedDateTime currentTime = ZonedDateTime.now();
        return currentTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z"));
    }

    public static String getAppName() {
        return "I'm ECU_2";
    }

    // Function to return the current system time in a given time zone
    public static String getCurrentTimeInTimeZone(String timeZone) {
        try {
            ZoneId zoneId = ZoneId.of(timeZone);
            ZonedDateTime currentTimeInZone = ZonedDateTime.now(zoneId);
            return currentTimeInZone.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss z"));
        } catch (Exception e) {
            return "Invalid time zone: " + timeZone;
        }
    }
}
