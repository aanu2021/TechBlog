package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        // fetch all for data from register screen...
        String check = req.getParameter("check");
        if (check == null) {
            out.println("Box is not checked...");
        } else {
            // proceed further
            String name = req.getParameter("user_name");
            String email = req.getParameter("user_email");
            String password = req.getParameter("user_password");
            String gender = req.getParameter("gender");
            String about = req.getParameter("about");
            User user = new User(name, email, password, gender, about);
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean isUpdateDone = userDao.saveUser(user);
            if (isUpdateDone == true) {
                out.println("done");
            } else {
                boolean isEmailExist = userDao.isEmailPresent(email);
                if(isEmailExist == false){
                    out.println("Something went wrong !!!");   
                }
                else{
                    out.println("Email is already taken, please try with another one... !!!");
                }
            }
        }
    }

}
