package com.tech.blog.dao;
import java.sql.*;
import java.util.ArrayList;

public class FollowDao {
    private Connection con;
    public FollowDao(Connection con){
        this.con = con;
    }
    public int followersCount(int uid){
        int count = 0;
        try{
            String query = "select count(*) from followers where following = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, uid);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return count;
    }
    public boolean isFollowedByUserId(int followerId, int followingId){
        boolean f = false;
        try{
            String query = "select * from followers where follower = ? and following = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, followerId);
            pstmt.setInt(2, followingId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                f = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public boolean addFollowerFollowing(int followerId, int followingId){
        boolean f = false;
        try{
            String query = "insert into followers(follower,following) values(?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,followerId);
            pstmt.setInt(2,followingId);
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public boolean removeFollowerFollowing(int followerId, int followingId){
        boolean f = false;
        try{
            String query = "delete from followers where follower = ? and following = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,followerId);
            pstmt.setInt(2,followingId);
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    public ArrayList<Integer> getFollowingByFollowerId(int followerId){
        ArrayList<Integer> list = new ArrayList<>();
        try{
            String query = "select following from followers where follower = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1,followerId);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                list.add(rs.getInt(1));
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return list;
    }
}
