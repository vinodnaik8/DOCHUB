package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewProfilePicServlet")
public class ViewProfilePicServlet extends HttpServlet {

    private static final String PROFILE_PATH =
            "C:\\DOCHUB_DATA\\profilePics";

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");

        if(fileName==null){

            response.sendError(404);
            return;

        }

        File file = new File(PROFILE_PATH, fileName);

        if(!file.exists()){

            response.sendError(404);
            return;

        }

        response.setContentType(
                Files.probeContentType(file.toPath()));

        FileInputStream fis = new FileInputStream(file);

        OutputStream os = response.getOutputStream();

        byte[] buffer = new byte[4096];

        int len;

        while((len=fis.read(buffer))!=-1){

            os.write(buffer,0,len);

        }

        fis.close();
        os.close();

    }

}