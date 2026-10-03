package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DBConnection;

public class ProfileDAO {

    Connection con;

 // Update Profile
    public boolean updateProfile(User user) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "UPDATE users SET fullname=?, username=?, bio=?, visibility=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getBio());
            ps.setString(4, user.getVisibility());
            ps.setInt(5, user.getId());

            int i = ps.executeUpdate();

            if(i > 0){
                status = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }
    public User getUserById(int id) {

        User user = null;

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setBio(rs.getString("bio"));
                user.setProfilePic(rs.getString("profile_pic"));
                user.setVisibility(rs.getString("visibility"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return user;

    }
    public User getPublicUser(int id){

        User user = null;

        try{

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1,id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                if(rs.getString("visibility").equals("PUBLIC")){

                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setUsername(rs.getString("username"));
                    user.setBio(rs.getString("bio"));
                    user.setProfilePic(rs.getString("profile_pic"));
                    user.setVisibility(rs.getString("visibility"));

                }

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return user;

    }

}