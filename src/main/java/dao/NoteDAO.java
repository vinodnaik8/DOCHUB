package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Note;
import util.DBConnection;

public class NoteDAO {

    Connection con;

public boolean createNote(Note note){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "INSERT INTO notes(user_id,title,content,color) VALUES(?,?,?,?)";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, note.getUserId());
     ps.setString(2, note.getTitle());
     ps.setString(3, note.getContent());
     ps.setString(4, note.getColor());

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Get User Notes
//==========================

public List<Note> getNotesByUser(int userId){

 List<Note> list = new ArrayList<>();

 try{

     con = DBConnection.getConnection();

     String sql =
     "SELECT * FROM notes WHERE user_id=? AND is_archived=0 ORDER BY is_pinned DESC, created_at DESC";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, userId);

     ResultSet rs = ps.executeQuery();

     while(rs.next()){

         Note note = new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));
         note.setUpdatedAt(rs.getString("updated_at"));

         list.add(note);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return list;

}
//==========================
//Get Note By ID
//==========================

public Note getNoteById(int noteId){

 Note note = null;

 try{

     con = DBConnection.getConnection();

     String sql =
     "SELECT * FROM notes WHERE note_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, noteId);

     ResultSet rs = ps.executeQuery();

     if(rs.next()){

         note = new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));
         note.setUpdatedAt(rs.getString("updated_at"));

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return note;

}
//==========================
//Update Note
//==========================
public boolean updateNote(Note note){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "UPDATE notes SET title=?, content=?, color=? WHERE note_id=? AND user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setString(1, note.getTitle());
     ps.setString(2, note.getContent());
     ps.setString(3, note.getColor());
     ps.setInt(4, note.getNoteId());
     ps.setInt(5, note.getUserId());

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Delete Note
//==========================
public boolean deleteNote(int noteId,int userId){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "DELETE FROM notes WHERE note_id=? AND user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, noteId);
     ps.setInt(2, userId);

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Pin Note
//==========================
public boolean pinNote(int noteId,int userId){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "UPDATE notes SET is_pinned = NOT is_pinned WHERE note_id=? AND user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, noteId);
     ps.setInt(2, userId);

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Favorite Note
//==========================
public boolean favoriteNote(int noteId,int userId){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "UPDATE notes SET is_favorite = NOT is_favorite WHERE note_id=? AND user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, noteId);
     ps.setInt(2, userId);

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Archive Note
//==========================
public boolean archiveNote(int noteId,int userId){

 boolean status = false;

 try{

     con = DBConnection.getConnection();

     String sql = "UPDATE notes SET is_archived = NOT is_archived WHERE note_id=? AND user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, noteId);
     ps.setInt(2, userId);

     int rows = ps.executeUpdate();

     if(rows > 0){

         status = true;

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Search Notes
//==========================
public List<Note> searchNotes(int userId,String keyword){

 List<Note> list = new ArrayList<>();

 try{

     con = DBConnection.getConnection();

     String sql =
     "SELECT * FROM notes WHERE user_id=? AND is_archived=0 AND (title LIKE ? OR content LIKE ?) ORDER BY is_pinned DESC, created_at DESC";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, userId);
     ps.setString(2, "%" + keyword + "%");
     ps.setString(3, "%" + keyword + "%");

     ResultSet rs = ps.executeQuery();

     while(rs.next()){

         Note note = new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));
         note.setUpdatedAt(rs.getString("updated_at"));

         list.add(note);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return list;

}
//==========================
//Get Archived Notes
//==========================

public List<Note> getArchivedNotes(int userId){

 List<Note> list = new ArrayList<>();

 try{

     con = DBConnection.getConnection();

     String sql =
     "SELECT * FROM notes WHERE user_id=? AND is_archived=1 ORDER BY updated_at DESC";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1,userId);

     ResultSet rs = ps.executeQuery();

     while(rs.next()){

         Note note = new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));
         note.setUpdatedAt(rs.getString("updated_at"));

         list.add(note);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return list;

}
//==========================
//Get Favorite Notes
//==========================

public List<Note> getFavoriteNotes(int userId){

 List<Note> list = new ArrayList<>();

 try{

     con = DBConnection.getConnection();

     String sql =
     "SELECT * FROM notes WHERE user_id=? AND is_favorite=1 AND is_archived=0 ORDER BY is_pinned DESC, updated_at DESC";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1,userId);

     ResultSet rs = ps.executeQuery();

     while(rs.next()){

         Note note=new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));
         note.setUpdatedAt(rs.getString("updated_at"));

         list.add(note);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return list;

}
//Count Archived Notes
public int getArchivedCount(int userId){

 int count = 0;

 try{

     con = DBConnection.getConnection();

     String sql = "SELECT COUNT(*) FROM notes WHERE user_id=? AND is_archived=1";

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
//==========================
//Get All Notes
//==========================

public List<Note> getAllNotes(){

 List<Note> list=new ArrayList<>();

 try{

     con=DBConnection.getConnection();

     String sql=
     "SELECT n.*,u.fullname " +
     "FROM notes n " +
     "INNER JOIN users u ON n.user_id=u.id " +
     "ORDER BY n.created_at DESC";

     PreparedStatement ps=con.prepareStatement(sql);

     ResultSet rs=ps.executeQuery();

     while(rs.next()){

         Note note=new Note();

         note.setNoteId(rs.getInt("note_id"));
         note.setUserId(rs.getInt("user_id"));
         note.setTitle(rs.getString("title"));
         note.setContent(rs.getString("content"));
         note.setColor(rs.getString("color"));

         note.setPinned(rs.getBoolean("is_pinned"));
         note.setFavorite(rs.getBoolean("is_favorite"));
         note.setArchived(rs.getBoolean("is_archived"));

         note.setCreatedAt(rs.getString("created_at"));

         note.setFullName(rs.getString("fullname"));

         list.add(note);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return list;

}
//==========================
//==========================

public boolean deleteNote(int noteId){

 boolean status=false;

 try{

     con=DBConnection.getConnection();

     String sql="DELETE FROM notes WHERE note_id=?";

     PreparedStatement ps=con.prepareStatement(sql);

     ps.setInt(1,noteId);

     status=ps.executeUpdate()>0;

 }catch(Exception e){

     e.printStackTrace();

 }

 return status;

}
//==========================
//Total Notes
//==========================

public int getTotalNotes(){

 int count=0;

 try{

     con=DBConnection.getConnection();

     String sql="SELECT COUNT(*) FROM notes";

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
//Total Notes By User
//==========================
public int getTotalNotes(int userId) {

 int count = 0;

 try {

     con = DBConnection.getConnection();

     String sql =
         "SELECT COUNT(*) FROM notes " +
         "WHERE user_id=? AND is_archived=0";

     PreparedStatement ps =
         con.prepareStatement(sql);

     ps.setInt(1, userId);

     ResultSet rs = ps.executeQuery();

     if (rs.next()) {
         count = rs.getInt(1);
     }

 } catch (Exception e) {

     e.printStackTrace();

 }

 return count;
}
}
