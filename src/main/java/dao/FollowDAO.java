package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class FollowDAO {

    Connection con;

    // ==========================
    // Check Following
    // ==========================

    public boolean isFollowing(int followerId,int followingId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT * FROM followers WHERE follower_id=? AND following_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,followerId);
            ps.setInt(2,followingId);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                status=true;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    // ==========================
    // Follow User
    // ==========================

    public boolean followUser(int followerId,int followingId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="INSERT INTO followers(follower_id,following_id) VALUES(?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,followerId);
            ps.setInt(2,followingId);

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
    // ==========================
    // Unfollow User
    // ==========================

    public boolean unfollowUser(int followerId,int followingId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="DELETE FROM followers WHERE follower_id=? AND following_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,followerId);
            ps.setInt(2,followingId);

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    // ==========================
    // Followers Count
    // ==========================

    public int getFollowersCount(int userId){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM followers WHERE following_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                count=rs.getInt(1);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return count;

    }

    // ==========================
    // Following Count
    // ==========================

    public int getFollowingCount(int userId){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM followers WHERE follower_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                count=rs.getInt(1);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return count;

    }

    // ==========================
    // Followers List
    // ==========================

    public java.util.List<model.User> getFollowers(int userId){

        java.util.List<model.User> list=
                new java.util.ArrayList<>();

        try{

            con=DBConnection.getConnection();

            String sql=
            "SELECT u.* FROM followers f " +
            "INNER JOIN users u ON f.follower_id=u.id " +
            "WHERE f.following_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                model.User u=new model.User();

                u.setId(rs.getInt("id"));
                u.setFullname(rs.getString("fullname"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setBio(rs.getString("bio"));
                u.setProfilePic(rs.getString("profile_pic"));

                list.add(u);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }

    // ==========================
    // Following List
    // ==========================

    public java.util.List<model.User> getFollowing(int userId){

        java.util.List<model.User> list=
                new java.util.ArrayList<>();

        try{

            con=DBConnection.getConnection();

            String sql=
            "SELECT u.* FROM followers f " +
            "INNER JOIN users u ON f.following_id=u.id " +
            "WHERE f.follower_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                model.User u=new model.User();

                u.setId(rs.getInt("id"));
                u.setFullname(rs.getString("fullname"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setBio(rs.getString("bio"));
                u.setProfilePic(rs.getString("profile_pic"));

                list.add(u);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }

}