package com.tech.blog.servlets;
import com.tech.blog.dao.CommentDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class CommentServlet extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        int pid = Integer.parseInt(req.getParameter("pid"));
        int uid = Integer.parseInt(req.getParameter("uid"));
        String content = req.getParameter("content");
        CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
        boolean ok = commentDao.addComment(pid, uid, content);
        if(ok == true){
            out.println("done");
        }
        else{
            out.println("error");
        }
    }
    
}
