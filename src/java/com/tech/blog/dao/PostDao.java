package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;

public class PostDao {

    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    // fetch all the categories...
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String query = "select * from categories";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                Category category = new Category(cid, name, description);
                list.add(category);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    // saving a post inside a Database...
    public boolean savePost(Post post) {
        boolean flag = false;
        try {
            String query = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, post.getpTitle());
            pstmt.setString(2, post.getpContent());
            pstmt.setString(3, post.getpCode());
            pstmt.setString(4, post.getpPic());
            pstmt.setInt(5, post.getCatId());
            pstmt.setInt(6, post.getUserId());
            pstmt.executeUpdate();
            flag = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return flag;
    }

    // fetch all the posts from the database...
    public ArrayList<Post> getAllPosts() {
        ArrayList<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts order by pid desc";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    // fetch all the posts belonging to a certain category from the database...
    public ArrayList<Post> getPostsByCatId(int catId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where catId = " + catId + "";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    // fetch all the posts by userId from the database...
    public ArrayList<Post> getAllPostsByUserId(int userId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where userId = ? order by pid desc";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    // fetch all the posts belonging to a certain category, and to a certain user from the database...
    public ArrayList<Post> getPostsByCatIdAndUserId(int catId, int userId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            String query = "select * from posts where catId = ? and userId = ? order by pid desc";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, catId);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                catId = rs.getInt("catId");
                userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    // fetch particular post by their postId
    public Post getPostByPostId(int id) {
        Post post = null;
        try {
            String query = "select * from posts where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return post;
    }
    
    // fetch blogs/ posts counts by the user...
    public int postCountsByUserId(int userId){
        int count = 0;
        try{
            String query = "select count(*) from posts where userId = ?";
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
