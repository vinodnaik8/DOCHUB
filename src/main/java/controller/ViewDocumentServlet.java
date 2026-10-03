package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import dao.DocumentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Document;

@WebServlet("/ViewDocumentServlet")
public class ViewDocumentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_PATH = "C:\\DOCHUB_UPLOADS";

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Document ID is required.");

            return;

        }

        int docId = Integer.parseInt(id);

        DocumentDAO dao = new DocumentDAO();

        Document doc = dao.getDocumentById(docId);

        if (doc == null) {

            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Document not found.");

            return;

        }

        File file = new File(UPLOAD_PATH + File.separator + doc.getFileName());
        System.out.println("[" + doc.getFileName() + "]");
        System.out.println("Length = " + doc.getFileName().length());
        System.out.println(file.getAbsolutePath());
        System.out.println(file.exists());
        File folder = new File(UPLOAD_PATH);

        System.out.println("Folder exists : " + folder.exists());
        System.out.println("Folder path   : " + folder.getAbsolutePath());

        File[] files = folder.listFiles();

        if(files == null){

            System.out.println("No files found or folder cannot be read.");

        }else{

            System.out.println("Files inside folder:");

            for(File f : files){

                System.out.println(f.getName());

            }

        }

        if (!file.exists()) {

            response.sendError(HttpServletResponse.SC_NOT_FOUND,
                    "Physical file not found.");

            return;

        }

        String contentType = Files.probeContentType(file.toPath());

        if (contentType == null) {

            contentType = "application/octet-stream";

        }

        response.setContentType(contentType);

        response.setContentLengthLong(file.length());

        // IMPORTANT: inline = preview in browser
        response.setHeader(
                "Content-Disposition",
                "inline; filename=\"" + doc.getFileName() + "\"");

        FileInputStream fis = new FileInputStream(file);

        OutputStream os = response.getOutputStream();

        byte[] buffer = new byte[4096];

        int bytesRead;

        while ((bytesRead = fis.read(buffer)) != -1) {

            os.write(buffer, 0, bytesRead);

        }

        fis.close();
        os.close();

    }

}