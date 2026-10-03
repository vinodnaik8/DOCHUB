package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class BookmarkDAO {

    Connection con;

    // ==========================
    // Check Bookmark
    // ==========================

    public boolean isBookmarked(int userId, int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT * FROM bookmarks WHERE user_id=? AND document_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

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
    // Bookmark Document
    // ==========================

    public boolean addBookmark(int userId,int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="INSERT INTO bookmarks(user_id,document_id) VALUES(?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
    // ==========================
    // Remove Bookmark
    // ==========================

    public boolean removeBookmark(int userId,int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="DELETE FROM bookmarks WHERE user_id=? AND document_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    // ==========================
    // Get Bookmark Count
    // ==========================

    public int getBookmarkCount(int userId){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM bookmarks WHERE user_id=?";

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
    // Get User Bookmarks
    // ==========================

    public java.util.List<model.Document> getBookmarks(int userId) {

        java.util.List<model.Document> list =
                new java.util.ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT d.*, " +
                "u.fullname, u.username, u.profile_pic, " +
                "u.visibility AS account_visibility " +
                "FROM bookmarks b " +
                "INNER JOIN documents d ON b.document_id = d.doc_id " +
                "INNER JOIN users u ON d.user_id = u.id " +
                "WHERE b.user_id=? " +
                "ORDER BY b.created_at DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                model.Document d =
                        new model.Document();

                d.setDocId(
                        rs.getInt("doc_id")
                );

                d.setUserId(
                        rs.getInt("user_id")
                );

                d.setTitle(
                        rs.getString("title")
                );

                d.setDescription(
                        rs.getString("description")
                );

                d.setCategory(
                        rs.getString("category")
                );

                d.setFileName(
                        rs.getString("file_name")
                );

                // Account visibility
                d.setVisibility(
                        rs.getString("account_visibility")
                );

                d.setFullName(
                        rs.getString("fullname")
                );

                d.setUsername(
                        rs.getString("username")
                );

                d.setProfilePic(
                        rs.getString("profile_pic")
                );

                list.add(d);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }
    public int getTotalBookmarks(){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM bookmarks";

            PreparedStatement ps=con.prepareStatement(sql);

            ResultSet rs=ps.executeQuery();

            if(rs.next()){

                count=rs.getInt(1);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return count;

    }
}