package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/profile-image")
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fileName=request.getParameter("file");

        if(fileName==null){

            fileName="default.png";

        }

        String path="C:\\DOCHUB_DATA\\profilePics\\"+fileName;

        File file=new File(path);

        if(!file.exists()){

            file=new File("C:\\DOCHUB_DATA\\profilePics\\default.png");

        }

        String type=getServletContext().getMimeType(file.getName());

        response.setContentType(type);

        FileInputStream fis=new FileInputStream(file);

        OutputStream os=response.getOutputStream();

        byte[] buffer=new byte[4096];

        int bytes;

        while((bytes=fis.read(buffer))!=-1){

            os.write(buffer,0,bytes);

        }

        fis.close();

        os.close();

    }

}