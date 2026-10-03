package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class StatisticsDAO {

    Connection con;

    private int getCount(String sql) {

        int count = 0;

        try {

            con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                count = rs.getInt(1);

            }

        } catch(Exception e){

            e.printStackTrace();

        }

        return count;
    }

    public int totalUsers(){

        return getCount("SELECT COUNT(*) FROM users");

    }

    public int totalDocuments(){

        return getCount("SELECT COUNT(*) FROM documents");

    }

    public int totalNotes(){

        return getCount("SELECT COUNT(*) FROM notes");

    }

    public int publicDocuments(){

        return getCount("SELECT COUNT(*) FROM documents WHERE visibility='PUBLIC'");

    }

    public int privateDocuments(){

        return getCount("SELECT COUNT(*) FROM documents WHERE visibility='PRIVATE'");

    }

}