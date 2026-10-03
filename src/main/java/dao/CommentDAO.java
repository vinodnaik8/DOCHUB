package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Comment;
import util.DBConnection;

public class CommentDAO {

    Connection con;

    // Add Comment

    public boolean addComment(Comment c){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="INSERT INTO comments(user_id,document_id,comment) VALUES(?,?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,c.getUserId());
            ps.setInt(2,c.getDocId());
            ps.setString(3,c.getComment());

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    // Get Comments

    public List<Comment> getComments(int docId){

        List<Comment> list=new ArrayList<>();

        try{

            con=DBConnection.getConnection();

            String sql="SELECT c.*,u.fullname,u.username,u.profile_pic FROM comments c JOIN users u ON c.user_id=u.id WHERE c.document_id=? ORDER BY c.created_at DESC";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,docId);

            ResultSet rs=ps.executeQuery();

            while(rs.next()){

                Comment c=new Comment();

                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setDocId(rs.getInt("document_id"));
                c.setComment(rs.getString("comment"));
                c.setFullName(rs.getString("fullname"));
                c.setUsername(rs.getString("username"));
                c.setProfilePic(rs.getString("profile_pic"));
                c.setCreatedAt(rs.getString("created_at"));

                list.add(c);

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return list;

    }

    // Count Comments

    public int getCommentCount(int docId){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM comments WHERE document_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,docId);

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
 // Delete Comment
 // ==========================

 public boolean deleteComment(int commentId,int userId){

     boolean status=false;

     try{

         con=DBConnection.getConnection();

         String sql="DELETE FROM comments WHERE id=? AND user_id=?";

         PreparedStatement ps=con.prepareStatement(sql);

         ps.setInt(1,commentId);
         ps.setInt(2,userId);

         status=ps.executeUpdate()>0;

     }catch(Exception e){

         e.printStackTrace();

     }

     return status;

 }
//==========================
//Get Comment By ID
//==========================

public Comment getCommentById(int id){

  Comment c=null;

  try{

      con=DBConnection.getConnection();

      String sql="SELECT * FROM comments WHERE id=?";

      PreparedStatement ps=con.prepareStatement(sql);

      ps.setInt(1,id);

      ResultSet rs=ps.executeQuery();

      if(rs.next()){

          c=new Comment();

          c.setId(rs.getInt("id"));
          c.setUserId(rs.getInt("user_id"));
          c.setDocId(rs.getInt("document_id"));
          c.setComment(rs.getString("comment"));

      }

  }catch(Exception e){

      e.printStackTrace();

  }

  return c;

}
public int getTotalComments(){

    int count=0;

    try{

        con=DBConnection.getConnection();

        String sql="SELECT COUNT(*) FROM comments";

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