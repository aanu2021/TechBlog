<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.tech.blog.entities.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tech Blog</title>
        <!--Bootstrap CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                /*               clip-path: polygon(0 0, 100% 0, 100% 98%, 74% 85%, 34% 100%, 0 84%);*/
                /*                clip-path: polygon(0 0, 100% 0, 100% 98%, 74% 91%, 35% 98%, 0 88%);*/
                clip-path: polygon(0 0, 100% 0, 100% 100%, 100% 88%, 55% 100%, 0 87%);
            }
        </style>
    </head>
    <body>

        <!--Navbar-->
        <%@include file="navbar.jsp" %>

        <!--Banner-->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background">
                <div class="container">
                    <h3 class="display-3">Welcome to TechBlog</h3>
                    <p>TechBlog is your one stop destination for interview preparation, does not matter whether you are a fresher or an experienced guy. You can find out blogs on Data structures, Algorithms, Database Management System, Operating Systems, Computer Networking and a lot more.............. </p>
                    <%                        if (user == null) {
                    %>
                    <a class="btn btn-lg btn-outline-light" href="register.jsp"><span class="fa fa-user-plus"> </span>  Start! its free</a>
                    <a class="btn btn-lg btn-outline-light" href="login.jsp"><span class="fa fa-user-circle"> </span>  Login</a>
                    <%
                    } else {
                    %> 
                    <a class="btn btn-lg btn-outline-light" href="LogoutServlet"><span class="fa fa-sign-out"> </span>  Logout</a>
                    <%
                        }
                    %> 

                </div>
            </div>
        </div>

        <!--Cards-->
        <div class="container">
            <div class="row">
                <%
                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                    ArrayList<Category> list = postDao.getAllCategories();
                    for (Category c : list) {
                %> 
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= c.getName()%></h5>
                            <p class="card-text"><%= c.getDescription()%></p>
                            <a href="profile.jsp?categoryId=<%= c.getCid() %>" class="btn btn-primary">Visit now</a>
                        </div>
                    </div>  
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!--Bootstrap js--> 
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
