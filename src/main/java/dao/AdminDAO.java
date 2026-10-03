package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Admin;
import util.DBConnection;

public class AdminDAO {

    Connection con;

    public Admin loginAdmin(String username,String password){

        Admin admin=null;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT * FROM admin WHERE username=? AND password=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,username);
            ps.setString(2,password);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                admin=new Admin();

                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return admin;

    }
 // ==========================
 // Get Admin By ID
 // ==========================

 public Admin getAdminById(int id){

     Admin admin=null;

     try{

         con=DBConnection.getConnection();

         String sql="SELECT * FROM admin WHERE admin_id=?";

         PreparedStatement ps=con.prepareStatement(sql);

         ps.setInt(1,id);

         ResultSet rs=ps.executeQuery();

         if(rs.next()){

             admin=new Admin();

             admin.setAdminId(rs.getInt("admin_id"));
             admin.setUsername(rs.getString("username"));
             admin.setPassword(rs.getString("password"));

         }

     }catch(Exception e){

         e.printStackTrace();

     }

     return admin;

 }
//==========================
//Change Password
//==========================

 public boolean changePassword(
	        int id,
	        String oldPass,
	        String newPass) {

	    boolean status = false;

	    try {

	        con = DBConnection.getConnection();

	        String sql =
	            "UPDATE admin SET password=? " +
	            "WHERE admin_id=? AND password=?";

	        PreparedStatement ps =
	            con.prepareStatement(sql);

	        ps.setString(1, newPass);
	        ps.setInt(2, id);
	        ps.setString(3, oldPass);

	        status =
	            ps.executeUpdate() > 0;

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return status;
	}
}