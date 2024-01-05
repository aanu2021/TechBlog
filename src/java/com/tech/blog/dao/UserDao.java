package com.tech.blog.dao;
import java.sql.*;
import com.tech.blog.entities.User;

public class UserDao {
    private Connection con;
    public UserDao(Connection con){
        this.con = con;
    }
    // Method to insert user into Database...
    public boolean saveUser(User user){
        boolean flag = false;
        try{
            // user -> database
            String query = "insert into users(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getGender());
            pstmt.setString(5,user.getAbout());
            pstmt.executeUpdate();
            flag = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return flag;
    }
    // Method to fetch user by their (email, password)
    public User getUserByEmailPassword(String email, String password){
        User user = null;
        try{
            String query = "select * from users where email = ? and password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,email);
            pstmt.setString(2,password);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDateTime(rs.getTimestamp("rdate"));
                user.setProfile(rs.getString("profile"));
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return user;
    }
    // Method to check is entered email is already existing or not
    public boolean isEmailPresent(String email){
        boolean flag = false;
        try{
            String query = "select * from users where email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,email);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                flag = true;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return flag;
    }
    // Method to update user details...
    public boolean updateUser(User user){
        boolean f = false;
        try{
            String query = "update users set name=? , email=? , password=? , about=? , profile=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getAbout());
            pstmt.setString(5,user.getProfile());
            pstmt.setInt(6, user.getId());
            pstmt.executeUpdate();
            f = true;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return f;
    }
    // Method to fetch user details using userId...
    public User getUserDetailsByUserId(int id){
        User user = null;
        try{
            String query = "select * from users where id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
                id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String gender = rs.getString("gender");
                String about = rs.getString("about");
                Timestamp rDate = rs.getTimestamp("rDate");
                String profile = rs.getString("profile");
                user = new User();
                user.setId(id);
                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                user.setGender(gender);
                user.setAbout(about);
                user.setDateTime(rDate);
                user.setProfile(profile);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return user;
    }
}
