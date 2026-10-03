package test;

import java.sql.Connection;

import util.DBConnection;

public class TestConnection {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {

            System.out.println("Connection Successful");

        } else {

            System.out.println("Connection Failed");

        }

    }

}