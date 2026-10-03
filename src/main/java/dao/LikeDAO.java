package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class LikeDAO {

    Connection con;

    // ==========================
    // Check Like
    // ==========================

    public boolean isLiked(int userId,int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT * FROM likes WHERE user_id=? AND document_id=?";

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
    // Total Likes
    // ==========================

    public int getLikeCount(int docId){

        int count=0;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT COUNT(*) FROM likes WHERE document_id=?";

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
 // Like Document
 // ==========================

 public boolean likeDocument(int userId,int docId){

     boolean status=false;

     try{

         con=DBConnection.getConnection();

         String sql="INSERT INTO likes(user_id,document_id) VALUES(?,?)";

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
 // Unlike Document
 // ==========================

 public boolean unlikeDocument(int userId,int docId){

     boolean status=false;

     try{

         con=DBConnection.getConnection();

         String sql="DELETE FROM likes WHERE user_id=? AND document_id=?";

         PreparedStatement ps=con.prepareStatement(sql);

         ps.setInt(1,userId);
         ps.setInt(2,docId);

         status=ps.executeUpdate()>0;

     }catch(Exception e){

         e.printStackTrace();

     }

     return status;

 }
 public int getTotalLikes(){

	    int count=0;

	    try{

	        con=DBConnection.getConnection();

	        String sql="SELECT COUNT(*) FROM likes";

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
//==========================
//Likes Received By User
//==========================
public int getLikesReceived(int userId){

int count = 0;

try{

    con = DBConnection.getConnection();

    String sql =
    "SELECT COUNT(*) " +
    "FROM likes l " +
    "INNER JOIN documents d ON l.document_id=d.doc_id " +
    "WHERE d.user_id=?";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setInt(1, userId);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        count = rs.getInt(1);

    }

}catch(Exception e){

    e.printStackTrace();

}

return count;

}

}