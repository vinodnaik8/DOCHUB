package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;
import util.DBConnection;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    Connection con;

    // Register User
    public boolean registerUser(User user) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "INSERT INTO users(fullname,username,email,password,bio,profile_pic,visibility) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getBio());
            ps.setString(6, user.getProfilePic());
            ps.setString(7, user.getVisibility());

            int rows = ps.executeUpdate();

            System.out.println("Rows Inserted = " + rows);

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {

            System.out.println("========== SQL ERROR ==========");
            e.printStackTrace();

        }

        return status;
    }

    // Login User
    public User loginUser(String email, String password) {

        User user = null;

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setBio(rs.getString("bio"));
                user.setProfilePic(rs.getString("profile_pic"));
                user.setVisibility(rs.getString("visibility"));
                user.setProfession(rs.getString("profession"));
                user.setSkills(rs.getString("skills"));
                user.setGithub(rs.getString("github"));
                user.setLinkedin(rs.getString("linkedin"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return user;
    }
    public boolean changePassword(int id,String oldPass,String newPass){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="UPDATE users SET password=? WHERE id=? AND password=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,newPass);
            ps.setInt(2,id);
            ps.setString(3,oldPass);

            int i=ps.executeUpdate();

            if(i>0){

                status=true;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
    public boolean deleteAccount(int id){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="DELETE FROM users WHERE id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,id);

            int i=ps.executeUpdate();

            if(i>0){

                status=true;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
 // Get All Users
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM users ORDER BY created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setBio(rs.getString("bio"));
                user.setProfilePic(rs.getString("profile_pic"));
                user.setVisibility(rs.getString("visibility"));
                user.setProfession(rs.getString("profession"));
                user.setSkills(rs.getString("skills"));
                user.setGithub(rs.getString("github"));
                user.setLinkedin(rs.getString("linkedin"));
                list.add(user);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
 // Delete User
    public boolean deleteUser(int id) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "DELETE FROM users WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public User getUserByEmail(String email){

        User user = null;

        try{

            con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1,email);

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
                user.setProfession(rs.getString("profession"));
                user.setSkills(rs.getString("skills"));
                user.setGithub(rs.getString("github"));
                user.setLinkedin(rs.getString("linkedin"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return user;

    }
    public boolean resetPassword(String email,String password){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="UPDATE users SET password=? WHERE email=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,password);
            ps.setString(2,email);

            int i=ps.executeUpdate();

            if(i>0){

                status=true;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
 // Update Profile
    public boolean updateProfile(User user) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql = "UPDATE users SET fullname=?, username=?, bio=?, profile_pic=?, visibility=?, profession=?, skills=?, github=?, linkedin=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getBio());
            ps.setString(4, user.getProfilePic());
            ps.setString(5, user.getVisibility());
            ps.setString(6, user.getProfession());
            ps.setString(7, user.getSkills());
            ps.setString(8, user.getGithub());
            ps.setString(9, user.getLinkedin());
            ps.setInt(10, user.getId());

            int rows = ps.executeUpdate();

            if (rows > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }
 // ==========================
 // Get User By ID
 // ==========================

    public User getUserById(int id){

        User user = null;

        try{

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

                // NEW
                user.setProfession(rs.getString("profession"));
                user.setSkills(rs.getString("skills"));
                user.setGithub(rs.getString("github"));
                user.setLinkedin(rs.getString("linkedin"));

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return user;

    }
    public List<User> searchUsers(String keyword, int loggedUserId) {

        List<User> list = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT id, fullname, username, email, profile_pic, visibility " +
                "FROM users " +
                "WHERE id <> ? " +
                "AND (fullname LIKE ? OR username LIKE ?) " +
                "ORDER BY fullname";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            String searchValue = "%" + keyword + "%";

            ps.setInt(1, loggedUserId);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setProfilePic(rs.getString("profile_pic"));
                user.setVisibility(rs.getString("visibility"));

                list.add(user);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }
}