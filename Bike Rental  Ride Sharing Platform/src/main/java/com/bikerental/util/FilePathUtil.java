package com.bikerental.util;

import java.io.File;

public class FilePathUtil {
    // 💡 ඔයාගේ PC එකේ ඇත්තම පාර (D drive එකේ තියෙන විදිහට)
    private static final String BASE_PATH = "D:\\Project\\Bike Rental  Ride Sharing Platform\\src\\main\\webapp\\";

    // දත්ත (txt files) සේව් කරන පාර
    public static String getPath(String fileName) {
        String path = BASE_PATH + "data\\";
        checkDir(path);
        return path + fileName;
    }

    // ⭐ පින්තූර සේව් කරන පාර
    public static String getImagePath() {
        String path = BASE_PATH + "images\\bikes\\";
        checkDir(path);
        return path;
    }

    private static void checkDir(String path) {
        File directory = new File(path);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }
}