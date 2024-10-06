package org.example;

import java.sql.DriverManager;

public class SqlDriverTest {

    public static void main(String[] args) throws Exception{
//        DriverManager
        Class.forName("com.mysql.cj.jdbc.Driver");
    }
}
