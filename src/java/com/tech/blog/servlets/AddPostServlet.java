package com.tech.blog.servlets;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.Post;
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
public class AddPostServlet extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        int cid = Integer.parseInt(req.getParameter("cid"));
        String pTitle = req.getParameter("pTitle");
        String pContent = req.getParameter("pContent");
        String pCode = req.getParameter("pCode");
        Part part = req.getPart("pPic");
        String pPic = part.getSubmittedFileName();
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("currentUser");
        int userId = user.getId();
        Post post = new Post(pTitle, pContent, pCode, pPic, cid, userId);
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        boolean isPostSaved = postDao.savePost(post);
        if(isPostSaved == true){
            String path = req.getRealPath("/") + "pics" + File.separator + post.getpPic();
            if (Helper.saveFile(part.getInputStream(), path) == true) {
                out.println("done");
            } else {
                out.println("error");
            }
        }
        else{
            out.println("error");
        }
    }
    
}
