package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class EditServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String userName = req.getParameter("user_name");
        String userEmail = req.getParameter("user_email");
        String userPassword = req.getParameter("user_password");
        String userAbout = req.getParameter("user_about");

        Part part = req.getPart("image");
        String imageName = part.getSubmittedFileName();

        HttpSession s = req.getSession();
        User user = (User) s.getAttribute("currentUser");
        user.setEmail(userEmail);
        user.setName(userName);
        user.setPassword(userPassword);
        user.setAbout(userAbout);

        String oldFile = user.getProfile();
        user.setProfile(imageName);

        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        boolean isUpdated = userDao.updateUser(user);
        if (isUpdated) {
            String path = req.getRealPath("/") + "pics" + File.separator + user.getProfile();
            String pathOldFile = req.getRealPath("/") + "pics" + File.separator + oldFile;
//            if (!oldFile.equals("default.png")) {
//                Helper.deleteFile(pathOldFile);
//            }
            if (Helper.saveFile(part.getInputStream(), path) == true) {
                Message msg = new Message("Profiles details successfully updated inside database...", "success", "alert-success");
                s.setAttribute("message", msg);
                out.println("updated to db...");
            } else {
                Message msg = new Message("Something went wrong!!!", "error", "alert-danger");
                s.setAttribute("message", msg);
                out.println("File is not saved successfully...");
            }
        } else {
            Message msg = new Message("Something went wrong!!!", "error", "alert-danger");
            s.setAttribute("message", msg);
            out.println("something went wrong...");
        }

        resp.sendRedirect("profile.jsp");
    }

}
