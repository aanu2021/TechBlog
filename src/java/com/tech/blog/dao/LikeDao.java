package com.tech.blog.dao;
import java.sql.*;

public class LikeDao {
    private Connection con;
    public LikeDao(Connection con){
        this.con = con;
    }
    public boolean addLike(int pid, int uid){
        boolean f = false;
        try{
            String query = "insert into likes(pid, uid) values(?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2,uid);
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public int likeCounts(int pid){
        int count = 0;
        try{
            String query = "select count(*) from likes where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return count;
    }
    public boolean isLikedByUser(int pid, int uid){
        boolean f = false;
        try{
            String query = "select * from likes where pid = ? and uid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,uid);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                f = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public boolean removeLike(int pid, int uid){
        boolean f = false;
        try{
            String query = "delete from likes where pid = ? and uid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2,uid);
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public int likeCountsByUserId(int userId){
        int count = 0;
        try{
            String query = "select count(*) from posts join likes on posts.pid = likes.pid where userId = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return count;
    }
}
