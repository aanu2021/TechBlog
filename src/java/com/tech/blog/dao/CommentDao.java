package com.tech.blog.dao;
import com.tech.blog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;

public class CommentDao {
    private Connection con;
    public CommentDao(Connection con){
        this.con = con;
    }
    public boolean addComment(int pid, int uid, String content){
        boolean f = false;
        try{
            String query = "insert into comments(pid,uid,content) values(?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,uid);
            pstmt.setString(3,content);
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public int commentsCount(int pid){
        int count = 0;
        try{
            String query = "select count(*) from comments where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return count;
    }
    public ArrayList<Comment> getAllComments(int pid){
        ArrayList<Comment> list = new ArrayList<>();
        try{
            String query = "select * from comments where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                int cid = rs.getInt(1);
                pid = rs.getInt(2);
                int uid = rs.getInt(3);
                String content = rs.getString(4);
                Comment comment = new Comment(cid, pid, uid, content);
                list.add(comment);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return list;
    }
}
