package com.tech.blog.servlets;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LikeServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        int pid = Integer.parseInt(req.getParameter("pid"));
        int uid = Integer.parseInt(req.getParameter("uid"));
        String operation = req.getParameter("operation");
        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
        boolean isLiked = likeDao.isLikedByUser(pid, uid);
        if (operation.equals("like")) {
            if (isLiked == false) {
                out.println("done");
                likeDao.addLike(pid, uid);
            } else {
                out.println("Something went wrong...");
            }
        } else {
            if (isLiked == true) {
                out.println("done");
                likeDao.removeLike(pid, uid);
            } else {
                out.println("Something went wrong...");
            }
        }
    }

}
