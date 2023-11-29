package com.team1.careercanvas.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class CreateCookie {
    public static void createCookie(HttpServletResponse response) {
        LocalDateTime now = LocalDateTime.now();  // 현재 시간
        LocalDateTime tomorrowMidnight = LocalDateTime.of(now.toLocalDate().plusDays(1), LocalTime.MIDNIGHT);  // 다음날 0시 0분

        // 현재 시간과 다음날 0시 사이의 시간 차이(초 단위)
        long maxAge = Duration.between(now, tomorrowMidnight).getSeconds();

        Cookie cookie = new Cookie("today", "check");
        cookie.setMaxAge((int) maxAge);  // 쿠키의 만료 시간 설정
        response.addCookie(cookie);
    }
}
