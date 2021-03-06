/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlet;

import com.dao.BlogDAO;
import com.database.DBConnect;
import com.detail.BlogDetail;
import com.detail.UserDetail;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author chetan
 */
@MultipartConfig
public class AddBlogServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            HttpSession session = request.getSession();
            if(session.getAttribute("userLogin")==null){
                return;
            }
            UserDetail ud = (UserDetail) session.getAttribute("userLogin");
            String title = request.getParameter("title").trim();
            String content = request.getParameter("content").trim();
            Part part = request.getPart("image");
            String fileName = part.getSubmittedFileName();
            StringBuilder sb = new StringBuilder();
            for(int i = fileName.length()-1;i>0;i--){
                if(fileName.charAt(i)=='.'){
                    break;
                }
                sb.insert(0, fileName.charAt(i));
            }
            BlogDetail bd= new BlogDetail();
            bd.setUserId(ud.getId());
            bd.setTitle(title);
            bd.setContent(content);
            BlogDAO dao = new BlogDAO(DBConnect.getConn());
            String f = dao.insertBlog(bd, new String(sb));
            
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                if (!f.equals("no")) {
                    InputStream is = part.getInputStream();
                    byte[] data = new byte[is.available()];
                    is.read(data);
                    String path = request.getRealPath("/")+"img"+File.separator+"BlogThumbnail"+File.separator+f;
                    try (FileOutputStream fos = new FileOutputStream(path)) {
                        fos.write(data);
                    }
                    out.println("done");
                } else {
                    out.println("no");
                }
            }
        } catch(IOException | ServletException e ) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
