package com.tech.blog.servlets;
import com.tech.blog.dao.FollowDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class FollowServlet extends HttpServlet{

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();
        int followerId = Integer.parseInt(req.getParameter("followerId"));
        int followingId = Integer.parseInt(req.getParameter("followingId"));
        String operation = req.getParameter("operation");
        System.out.println(followerId);
        System.out.println(followingId);
        System.out.println(operation);
        FollowDao followDao = new FollowDao(ConnectionProvider.getConnection());
        if(operation.equals("follow")){
            boolean isPossible = followDao.addFollowerFollowing(followerId, followingId);
            if(isPossible == true){
                out.println("done");
            }
            else{
                out.println("error");
            }
        }
        else if(operation.equals("unfollow")){
            boolean isPossible = followDao.removeFollowerFollowing(followerId, followingId);
            if(isPossible == true){
                out.println("done");
            }
            else{
                out.println("error");
            }
        }
        else{
            out.println("error");
        }
    }
    
}
