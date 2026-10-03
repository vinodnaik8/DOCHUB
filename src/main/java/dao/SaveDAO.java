package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;

public class SaveDAO {

    Connection con;

    public boolean saveDocument(int userId,int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String check="SELECT * FROM saved_documents WHERE user_id=? AND doc_id=?";

            PreparedStatement ps=con.prepareStatement(check);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

            ResultSet rs=ps.executeQuery();

            if(!rs.next()){

                String sql="INSERT INTO saved_documents(user_id,doc_id) VALUES(?,?)";

                ps=con.prepareStatement(sql);

                ps.setInt(1,userId);
                ps.setInt(2,docId);

                status=ps.executeUpdate()>0;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    public boolean removeSaved(int userId,int docId){

        boolean status=false;

        try{

            con=DBConnection.getConnection();

            String sql="DELETE FROM saved_documents WHERE user_id=? AND doc_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

            status=ps.executeUpdate()>0;

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }

    public boolean isSaved(int userId,int docId){

        boolean saved=false;

        try{

            con=DBConnection.getConnection();

            String sql="SELECT * FROM saved_documents WHERE user_id=? AND doc_id=?";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);
            ps.setInt(2,docId);

            ResultSet rs=ps.executeQuery();

            saved=rs.next();

        }catch(Exception e){

            e.printStackTrace();

        }

        return saved;

    }

}