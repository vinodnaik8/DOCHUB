package model;

public class SavedDocument {

    private int id;
    private int userId;
    private int docId;

    public SavedDocument() {}

    public SavedDocument(int userId,int docId){

        this.userId=userId;
        this.docId=docId;

    }

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id=id;
    }

    public int getUserId(){
        return userId;
    }

    public void setUserId(int userId){
        this.userId=userId;
    }

    public int getDocId(){
        return docId;
    }

    public void setDocId(int docId){
        this.docId=docId;
    }

}