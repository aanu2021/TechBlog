<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Load Posts</title>
        <!--Bootstrap CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .background-white{
                background : white !important;
            }
        </style>
    </head>
    <body>

        <%
            User user = (User) session.getAttribute("currentUser");

            int userId = 0;
            boolean currentUserProfile = true;

            if (request.getParameter("userId") != null) {
                currentUserProfile = false;
                userId = Integer.parseInt(request.getParameter("userId"));
            }

        %>

        <div class="row">
            <%                Thread.sleep(350);
                PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                int catId = Integer.parseInt(request.getParameter("cid"));

                ArrayList<Post> posts = null;

                if (userId == 0) {
                    if (catId == 0) {
                        posts = postDao.getAllPosts();
                    } else {
                        posts = postDao.getPostsByCatId(catId);
                    }
                } else {
                    if (catId == 0) {
                        posts = postDao.getAllPostsByUserId(userId);
                    } else {
                        posts = postDao.getPostsByCatIdAndUserId(catId, userId);
                    }
                }
                if (posts.size() == 0) {
                    out.println("<h3 class='display-4 text-center'>No posts related to this category...</h3>");
                    return;
                } else {
                    for (Post p : posts) {
            %>
            <div class="col-md-6 mt-4">
                <div class="card">
                    <img class="card-img-top" src="pics/<%= p.getpPic()%>" alt="Card image caption" />
                    <div class="card-body">
                        <b><%= p.getpTitle()%></b>
                    </div>    
                    <%
                        LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                        CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
                    %>
                    <%
                        if (user != null) {
                    %>
                    <div class="card-footer text-center background-white">
                        <%
                            if (likeDao.isLikedByUser(p.getPid(), user.getId()) == true) {

                        %>
                        <a href="#!" onclick="doUnLike(<%= p.getPid()%>, <%= user.getId()%>, this)" class="btn btn-small btn-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(p.getPid())%></span></a>
                                <%
                                } else {
                                %>
                        <a href="#!" onclick="doLike(<%= p.getPid()%>, <%= user.getId()%>, this)" class="btn btn-small btn-outline-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(p.getPid())%></span></a>
                                <%
                                    }
                                %> 
                        <a href="show_blog_page.jsp?postId=<%= p.getPid()%>" class="btn btn-small btn-outline-primary">Read More...</a>
                        <a href="#!" class="btn btn-small btn-outline-primary"><i class="fa fa-commenting-o"></i><span class="comment-loader"> <%= commentDao.commentsCount(p.getPid())%></span></a>
                    </div>
                    <%
                    } else {
                    %>
                    <div class="card-footer text-center background-white">
                        <a href="login.jsp" class="btn btn-small btn-outline-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(p.getPid())%></span></a>
                        <a href="show_blog_page.jsp?postId=<%= p.getPid()%>" class="btn btn-small btn-outline-primary">Read More...</a>
                        <a href="login.jsp" class="btn btn-small btn-outline-primary"><i class="fa fa-commenting-o"></i><span class="comment-loader"> <%= commentDao.commentsCount(p.getPid())%></span></a>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>

        <!--Bootstrap js--> 
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs2.js"></script>

    </body>
</html>
