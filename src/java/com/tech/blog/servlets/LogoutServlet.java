package com.tech.blog.servlets;

import com.tech.blog.entities.Message;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        HttpSession session = req.getSession();
        session.removeAttribute("currentUser");
        Message msg = new Message("Logout successful...", "success", "alert-success");
        session.setAttribute("message", msg);
        resp.sendRedirect("login.jsp");
    }

}
