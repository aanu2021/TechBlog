package com.tech.blog.servlets;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        String email = req.getParameter("user_email");
        String password = req.getParameter("user_password");
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        User user = userDao.getUserByEmailPassword(email, password);
        if(user == null){
            Message msg = new Message("Invalid details...try again","error","alert-danger");
            HttpSession session = req.getSession();
            session.setAttribute("message",msg);
            resp.sendRedirect("login.jsp");
        }
        else{
            HttpSession session = req.getSession();
            session.setAttribute("currentUser", user);
            resp.sendRedirect("profile.jsp");
        }
    }
    
}
