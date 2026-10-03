package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Document;
import util.DBConnection;

public class DocumentDAO {

    Connection con;

    // ==========================
    // Upload Document
    // ==========================
    public boolean uploadDocument(Document doc) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                "INSERT INTO documents(" +
                "user_id,title,description,category,file_name" +
                ") VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, doc.getUserId());
            ps.setString(2, doc.getTitle());
            ps.setString(3, doc.getDescription());
            ps.setString(4, doc.getCategory());
            ps.setString(5, doc.getFileName());

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }
 // ==========================
 // Get Documents By User
 // ==========================

 public List<Document> getDocumentsByUser(int userId) {

     List<Document> list = new ArrayList<>();

     LikeDAO likeDAO = new LikeDAO();
     CommentDAO commentDAO = new CommentDAO();

     try {

         con = DBConnection.getConnection();

         String sql =
             "SELECT d.*, u.visibility AS account_visibility " +
             "FROM documents d " +
             "INNER JOIN users u ON d.user_id = u.id " +
             "WHERE d.user_id=? " +
             "ORDER BY d.uploaded_at DESC";

         PreparedStatement ps = con.prepareStatement(sql);

         ps.setInt(1, userId);

         ResultSet rs = ps.executeQuery();

         while (rs.next()) {

             Document d = new Document();

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

             // ==========================
             // Visibility
             // ==========================

             d.setVisibility(
                 rs.getString("account_visibility")
             );

             // ==========================
             // LIKE COUNT
             // ==========================

             d.setLikeCount(
                 likeDAO.getLikeCount(
                     d.getDocId()
                 )
             );

             // ==========================
             // COMMENT COUNT
             // ==========================

             d.setCommentCount(
                 commentDAO.getCommentCount(
                     d.getDocId()
                 )
             );

             list.add(d);
         }

     } catch (Exception e) {

         e.printStackTrace();

     }

     return list;
 }
 // Count Documents
    public int getDocumentCount(int userId){

        int count = 0;

        try{

            con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM documents WHERE user_id=?";

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
 // ==========================
 // Get All Public Documents
 // ==========================

 // ==========================
 // Get Community Documents
 // PUBLIC account  -> Everyone can see
 // PRIVATE account -> Only followers can see
 // Own documents   -> User can always see
 // ==========================

 public List<Document> getPublicDocuments(int loggedUserId) {

     List<Document> list = new ArrayList<>();

     LikeDAO likeDAO = new LikeDAO();
     CommentDAO commentDAO = new CommentDAO();
     BookmarkDAO bookmarkDAO = new BookmarkDAO();

     try {

         con = DBConnection.getConnection();

         String sql =
             "SELECT d.*, u.fullname, u.username, u.profile_pic, u.visibility AS account_visibility " +
             "FROM documents d " +
             "INNER JOIN users u ON d.user_id = u.id " +
             "WHERE " +
             "(d.user_id = ?) " +
             "OR " +
             "(u.visibility = 'PUBLIC') " +
             "OR " +
             "(u.visibility = 'PRIVATE' AND EXISTS (" +
                 "SELECT 1 FROM followers f " +
                 "WHERE f.follower_id = ? " +
                 "AND f.following_id = d.user_id" +
             ")) " +
             "ORDER BY d.uploaded_at DESC";

         PreparedStatement ps = con.prepareStatement(sql);

         ps.setInt(1, loggedUserId);
         ps.setInt(2, loggedUserId);

         ResultSet rs = ps.executeQuery();

         while (rs.next()) {

             Document d = new Document();

             d.setDocId(rs.getInt("doc_id"));
             d.setUserId(rs.getInt("user_id"));

             d.setTitle(rs.getString("title"));
             d.setDescription(rs.getString("description"));
             d.setCategory(rs.getString("category"));
             d.setFileName(rs.getString("file_name"));
             d.setVisibility(rs.getString("account_visibility"));

             d.setFullName(rs.getString("fullname"));
             d.setUsername(rs.getString("username"));
             d.setProfilePic(rs.getString("profile_pic"));

             // ==========================
             // Like Count
             // ==========================

             d.setLikeCount(
                 likeDAO.getLikeCount(d.getDocId())
             );

             // ==========================
             // Current User Like
             // ==========================

             d.setLiked(
                 likeDAO.isLiked(
                     loggedUserId,
                     d.getDocId()
                 )
             );

             // ==========================
             // Bookmark
             // ==========================

             d.setBookmarked(
                 bookmarkDAO.isBookmarked(
                     loggedUserId,
                     d.getDocId()
                 )
             );

             // ==========================
             // Comment Count
             // ==========================

             d.setCommentCount(
                 commentDAO.getCommentCount(
                     d.getDocId()
                 )
             );

             // ==========================
             // Comments
             // ==========================

             d.setComments(
                 commentDAO.getComments(
                     d.getDocId()
                 )
             );

             list.add(d);
         }

     } catch (Exception e) {

         e.printStackTrace();

     }

     return list;
 }
//==========================
//Search Public Documents
//==========================

//==========================
//Search Community Documents
//PUBLIC account  -> Everyone can see
//PRIVATE account -> Only followers can see
//Own documents   -> User can always see
//==========================

public List<Document> searchDocuments(
      String keyword,
      int loggedUserId) {

  List<Document> list = new ArrayList<>();

  LikeDAO likeDAO = new LikeDAO();
  CommentDAO commentDAO = new CommentDAO();
  BookmarkDAO bookmarkDAO = new BookmarkDAO();

  try {

      con = DBConnection.getConnection();

      String sql =
          "SELECT d.*, u.fullname, u.username, u.profile_pic, " +
          "u.visibility AS account_visibility " +
          "FROM documents d " +
          "INNER JOIN users u ON d.user_id = u.id " +
          "WHERE " +

          // ==========================
          // ACCOUNT PRIVACY
          // ==========================

          "(" +
              "d.user_id = ? " +

              "OR u.visibility = 'PUBLIC' " +

              "OR (" +
                  "u.visibility = 'PRIVATE' " +
                  "AND EXISTS (" +
                      "SELECT 1 FROM followers f " +
                      "WHERE f.follower_id = ? " +
                      "AND f.following_id = d.user_id" +
                  ")" +
              ")" +
          ") " +

          // ==========================
          // SEARCH
          // ==========================

          "AND (" +
              "d.title LIKE ? " +
              "OR d.category LIKE ? " +
              "OR u.fullname LIKE ? " +
              "OR u.username LIKE ?" +
          ") " +

          "ORDER BY d.uploaded_at DESC";

      PreparedStatement ps = con.prepareStatement(sql);

      ps.setInt(1, loggedUserId);
      ps.setInt(2, loggedUserId);

      String searchValue = "%" + keyword + "%";

      ps.setString(3, searchValue);
      ps.setString(4, searchValue);
      ps.setString(5, searchValue);
      ps.setString(6, searchValue);

      ResultSet rs = ps.executeQuery();

      while (rs.next()) {

          Document d = new Document();

          d.setDocId(rs.getInt("doc_id"));
          d.setUserId(rs.getInt("user_id"));

          d.setTitle(rs.getString("title"));
          d.setDescription(rs.getString("description"));
          d.setCategory(rs.getString("category"));
          d.setFileName(rs.getString("file_name"));
          d.setVisibility(rs.getString("account_visibility"));

          d.setFullName(rs.getString("fullname"));
          d.setUsername(rs.getString("username"));
          d.setProfilePic(rs.getString("profile_pic"));

          // ==========================
          // Likes
          // ==========================

          d.setLikeCount(
              likeDAO.getLikeCount(
                  d.getDocId()
              )
          );

          d.setLiked(
              likeDAO.isLiked(
                  loggedUserId,
                  d.getDocId()
              )
          );

          // ==========================
          // Bookmark
          // ==========================

          d.setBookmarked(
              bookmarkDAO.isBookmarked(
                  loggedUserId,
                  d.getDocId()
              )
          );

          // ==========================
          // Comments
          // ==========================

          d.setCommentCount(
              commentDAO.getCommentCount(
                  d.getDocId()
              )
          );

          d.setComments(
              commentDAO.getComments(
                  d.getDocId()
              )
          );

          list.add(d);
      }

  } catch (Exception e) {

      e.printStackTrace();

  }

  return list;
}
public List<Document> getPublicDocumentsByUser(int userId) {

    List<Document> list = new ArrayList<>();

    try {

        con = DBConnection.getConnection();

        String sql =
            "SELECT d.*, u.visibility AS account_visibility " +
            "FROM documents d " +
            "INNER JOIN users u ON d.user_id = u.id " +
            "WHERE d.user_id=? " +
            "AND u.visibility='PUBLIC' " +
            "ORDER BY d.uploaded_at DESC";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            Document d = new Document();

            d.setDocId(rs.getInt("doc_id"));
            d.setUserId(rs.getInt("user_id"));
            d.setTitle(rs.getString("title"));
            d.setDescription(rs.getString("description"));
            d.setCategory(rs.getString("category"));
            d.setFileName(rs.getString("file_name"));

            d.setVisibility(
                rs.getString("account_visibility")
            );

            list.add(d);
        }

    } catch (Exception e) {

        e.printStackTrace();

    }

    return list;
}
 // Get All Documents
public List<Document> getAllDocuments() {

    List<Document> list = new ArrayList<>();

    try {

        con = DBConnection.getConnection();

        String sql =
            "SELECT d.*, u.fullname, " +
            "u.visibility AS account_visibility " +
            "FROM documents d " +
            "INNER JOIN users u ON d.user_id = u.id " +
            "ORDER BY d.uploaded_at DESC";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            Document d = new Document();

            d.setDocId(rs.getInt("doc_id"));
            d.setUserId(rs.getInt("user_id"));
            d.setTitle(rs.getString("title"));
            d.setDescription(rs.getString("description"));
            d.setCategory(rs.getString("category"));
            d.setFileName(rs.getString("file_name"));

            d.setVisibility(
                rs.getString("account_visibility")
            );

            d.setFullName(
                rs.getString("fullname")
            );

            list.add(d);
        }

    } catch (Exception e) {

        e.printStackTrace();

    }

    return list;
}
 // Delete Document
    public boolean deleteDocument(int docId){

        boolean status = false;

        try{

            con = DBConnection.getConnection();

            String sql = "DELETE FROM documents WHERE doc_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, docId);

            int i = ps.executeUpdate();

            if(i>0){

                status = true;

            }

        }catch(Exception e){

            e.printStackTrace();

        }

        return status;

    }
    public Document getDocumentById(int docId) {

        Document doc = null;

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT d.*, u.visibility AS account_visibility " +
                "FROM documents d " +
                "INNER JOIN users u ON d.user_id = u.id " +
                "WHERE d.doc_id=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, docId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                doc = new Document();

                doc.setDocId(
                    rs.getInt("doc_id")
                );

                doc.setUserId(
                    rs.getInt("user_id")
                );

                doc.setTitle(
                    rs.getString("title")
                );

                doc.setDescription(
                    rs.getString("description")
                );

                doc.setCategory(
                    rs.getString("category")
                );

                doc.setFileName(
                    rs.getString("file_name")
                );

                doc.setVisibility(
                    rs.getString("account_visibility")
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return doc;
    }
 // ==========================
 // Update Document
 // ==========================
    public boolean updateDocument(Document doc) {

        boolean status = false;

        try {

            con = DBConnection.getConnection();

            String sql =
                "UPDATE documents " +
                "SET title=?, description=?, category=? " +
                "WHERE doc_id=? AND user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, doc.getTitle());
            ps.setString(2, doc.getDescription());
            ps.setString(3, doc.getCategory());
            ps.setInt(4, doc.getDocId());
            ps.setInt(5, doc.getUserId());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public int getPublicDocumentCount() {

        int count = 0;

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT COUNT(*) " +
                "FROM documents d " +
                "INNER JOIN users u ON d.user_id = u.id " +
                "WHERE u.visibility='PUBLIC'";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }
    public int getPrivateDocumentCount() {

        int count = 0;

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT COUNT(*) " +
                "FROM documents d " +
                "INNER JOIN users u ON d.user_id = u.id " +
                "WHERE u.visibility='PRIVATE'";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }
//==========================
//Get Private Documents By User
//==========================
    public List<Document> getPrivateDocumentsByUser(int userId) {

        List<Document> list = new ArrayList<>();

        try {

            con = DBConnection.getConnection();

            String sql =
                "SELECT d.*, u.visibility AS account_visibility " +
                "FROM documents d " +
                "INNER JOIN users u ON d.user_id = u.id " +
                "WHERE d.user_id=? " +
                "AND u.visibility='PRIVATE' " +
                "ORDER BY d.uploaded_at DESC";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Document d = new Document();

                d.setDocId(rs.getInt("doc_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setTitle(rs.getString("title"));
                d.setDescription(rs.getString("description"));
                d.setCategory(rs.getString("category"));
                d.setFileName(rs.getString("file_name"));

                d.setVisibility(
                    rs.getString("account_visibility")
                );

                list.add(d);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }
//==========================
//Total Downloads of User
//==========================
public int getTotalDownloads(int userId){

 int total = 0;

 try{

     con = DBConnection.getConnection();

     String sql = "SELECT SUM(downloads) FROM documents WHERE user_id=?";

     PreparedStatement ps = con.prepareStatement(sql);

     ps.setInt(1, userId);

     ResultSet rs = ps.executeQuery();

     if(rs.next()){

         total = rs.getInt(1);

     }

 }catch(Exception e){

     e.printStackTrace();

 }

 return total;

}
//==========================
//Get Account Visibility
//==========================

public String getUserVisibility(int userId) {

 String visibility = "PUBLIC";

 try {

     con = DBConnection.getConnection();

     String sql =
         "SELECT visibility FROM users WHERE id=?";

     PreparedStatement ps =
         con.prepareStatement(sql);

     ps.setInt(1, userId);

     ResultSet rs =
         ps.executeQuery();

     if (rs.next()) {

         visibility =
             rs.getString("visibility");
     }

 } catch (Exception e) {

     e.printStackTrace();
 }

 return visibility;
}
}