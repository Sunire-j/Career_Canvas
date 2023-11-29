package com.team1.careercanvas.util;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

public class OCRTemplate {
    public static String OCR(String filename) {
        String apiURL = "https://18xvoekb16.apigw.ntruss.com/custom/v1/26628/5b2b7bfe9d5913712a6ce76dd287efea4a7c9377f22d183c4479078c13232312/infer";
        String secretKey = "S1dwdWZTZkVQTXliTk1ibVhsaURkQnBhaldadlp2b2g=";
        String imageFile = filename;
        String format = imageFile.substring(imageFile.lastIndexOf(".")+1);
        StringBuffer response = null;

        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoInput(true);
            con.setDoOutput(true);
            con.setReadTimeout(30000);
            con.setRequestMethod("POST");
            String boundary = "----" + UUID.randomUUID().toString().replaceAll("-", "");
            con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
            con.setRequestProperty("X-OCR-SECRET", secretKey);

            JSONObject json = new JSONObject();
            json.put("version", "V2");
            json.put("requestId", UUID.randomUUID().toString());
            json.put("timestamp", System.currentTimeMillis());
            JSONObject image = new JSONObject();
            image.put("format", format);
            image.put("name", "demo");
            JSONArray images = new JSONArray();
            images.put(image);
            json.put("images", images);
            String postParams = json.toString();

            con.connect();
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            long start = System.currentTimeMillis();
            File file = new File(imageFile);
            writeMultiPart(wr, postParams, file, boundary);
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            return String.valueOf(response);
        } catch (Exception e) {
            System.out.println(e);
        }
        return String.valueOf(response);
    }

    private static void writeMultiPart(OutputStream out, String jsonMessage, File file, String boundary) throws
            IOException {
        String sb = "--" + boundary + "\r\n" +
                "Content-Disposition:form-data; name=\"message\"\r\n\r\n" +
                jsonMessage +
                "\r\n";

        out.write(sb.getBytes(StandardCharsets.UTF_8));
        out.flush();

        if (file != null && file.isFile()) {
            out.write(("--" + boundary + "\r\n").getBytes(StandardCharsets.UTF_8));
            String fileString = "Content-Disposition:form-data; name=\"file\"; filename=" +
                    "\"" + file.getName() + "\"\r\n" +
                    "Content-Type: application/octet-stream\r\n\r\n";
            out.write(fileString.getBytes(StandardCharsets.UTF_8));
            out.flush();

            try (FileInputStream fis = new FileInputStream(file)) {
                byte[] buffer = new byte[8192];
                int count;
                while ((count = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, count);
                }
                out.write("\r\n".getBytes());
            }

            out.write(("--" + boundary + "--\r\n").getBytes(StandardCharsets.UTF_8));
        }
        out.flush();
    }
}
