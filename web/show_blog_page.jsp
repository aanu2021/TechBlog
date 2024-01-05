<%@page import="com.tech.blog.entities.Comment"%>
<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>

<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("currentUser");
    int pId = Integer.parseInt(request.getParameter("postId"));
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
    CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());
    Post post = postDao.getPostByPostId(pId);
%>    


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getpTitle()%></title>
        <!--Bootstrap CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .background-white{
                background : white !important;
            }
            .post-title{
                font-weight:300 ;
                font-size : 30px;
            }
            .post-content{
                font-weight: 100;
                font-size : 16px;
            }
            .post-user-info{
                font-weight : 600 !important;
            }
            .post-date-time{
                font-style : italic;
                font-weight : bold;
            }
            .row-user{
                border : 1.5px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background : url("images/bg.jpeg");
                background-size : cover;
                background-attachment: fixed;
            }
            .comment-container{
                border : 2px solid #e2e2e2;
            }
            .comment-btn{
                display:flex;
                align-items:center;
            }
            .profile-pic{
                display : flex;
                flex-direction: column;
                justify-content: center;
            }
        </style>
    </head>
    <body>

        <!--Navbar--> 

        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk fa-spin"> </span> TechBlog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span> Home <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">DSA</a>
                            <a class="dropdown-item" href="#"> OOPS</a>
                            <a class="dropdown-item" href="#">OS</a>
                            <a class="dropdown-item" href="#">CN</a>
                            <a class="dropdown-item" href="#"> DBMS</a>
                        </div>
                    </li>

                    <%                        if (user == null) {
                    %> 
                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp"><span class="fa fa-user-plus"></span> Signup</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp"><span class="fa fa-user-circle"></span> Login</a>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="favourites.jsp"><span class="fa fa-star"></span> Favourites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-edit"></span> Add post</a>
                    </li>
                    <%
                        }
                    %>

                </ul>
                <%
                    if (user != null) {
                %> 
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user"></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
                    </li>
                </ul>
                <%
                    }
                %>    
            </div>
        </nav>

        <!--End of Navbar--> 



        <!--Main content of the body-->  

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= post.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top my-3" src="pics/<%= post.getpPic()%>" alt="Card image caption" />
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                        int userId = post.getUserId();
                                        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                                        User postedByUser = userDao.getUserDetailsByUserId(userId);
                                    %>
                                    <p class="post-user-info"><a href="profile.jsp?userId=<%= post.getUserId()%>"><%= postedByUser.getName()%></a> has posted</p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date-time"><%= DateFormat.getDateTimeInstance().format(post.getpDate())%></p>
                                </div>
                            </div>
                            <p class="post-content"><%= post.getpContent()%></p>
                            <br/>
                            <div class="post-code">
                                <pre><%= post.getpCode()%></pre>
                            </div>
                        </div>
                        <div class="card-footer background-white">
                            <%
                                if (user != null) {

                                    if (likeDao.isLikedByUser(post.getPid(), user.getId()) == true) {

                            %>
                            <a href="#!" onclick="doUnLike(<%= post.getPid()%>, <%= user.getId()%>, this)" class="btn btn-small btn-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(post.getPid())%></span></a>
                                    <%
                                    } else {
                                    %>
                            <a href="#!" onclick="doLike(<%= post.getPid()%>, <%= user.getId()%>, this)" class="btn btn-small btn-outline-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(post.getPid())%></span></a>
                                    <%
                                        }
                                    } else {
                                    %> 
                            <a href="login.jsp" class="btn btn-small btn-outline-primary"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%= likeDao.likeCounts(post.getPid())%></span></a>
                                    <%
                                        }
                                    %>
                            <a href="login.jsp" class="btn btn-small btn-outline-primary"><i class="fa fa-commenting-o"></i><span class="comment-counter"> <%= commentDao.commentsCount(post.getPid())%></span></a>


                            <!--show all comments-->
                            <%
                                ArrayList<Comment> comments = commentDao.getAllComments(pId);
                                for (Comment comment : comments) {
                                    User commentedUser = userDao.getUserDetailsByUserId(comment.getUid());
                            %>
                            <div class="container-fluid mt-3 mb-2 comment-container">
                                <div class="row">
                                    <div class="col-md-2 text-center profile-pic">
                                        <img src="pics/<%= commentedUser.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width:35px;min-height:35px;max-height:40px;" />
                                    </div>
                                    <div class="col-md-10">
                                        <p class="mt-2 display-5"><%= comment.getContent()%></p>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>

                            <%
                                if (user != null) {
                            %>
                            <!--Post some comments-->
                            <div class="container-fluid mt-4 p-4 pt-5 comment-container">
                                <form id="comment-form" action="CommentServlet" method="post">
                                    <div class="row">
                                        <div class="col-md-10"><div class="form-group">
                                                <input name="content" type="text" class="form-control" id="content" aria-describedby="emailHelp" placeholder="Post your comment...">
                                            </div></div>
                                        <div class="col-md-2"> <button type="submit" class="btn btn-primary">Comment</button></div>
                                    </div>
                                </form>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--End of the main content of the body--> 



        <%
            if (user != null) {
        %> 

        <!--Profile Modal--> 

        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width:150px;" />
                            <br/>
                            <h5 class="modal-title mt-3"><%= user.getName()%></h5>
                            <!--User Details...--> 
                            <div id="profile-details"> 
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td><%= user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Registered on :</th>
                                            <td><%= user.getDateTime().toLocaleString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--Profile Edit--> 
                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2 display-5">Please edit carefully...</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Name :</th>
                                            <td><input class="form-control" type="text" name="user_name" value="<%= user.getName()%>" /></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><input class="form-control" type="email" name="user_email" value="<%= user.getEmail()%>" /></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Password </th>
                                            <td><input class="form-control" type="password" name="user_password" value="<%= user.getPassword()%>" /></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>
                                        </tr> 
                                        <tr>
                                            <th scope="row">Status :</th>
                                            <td>
                                                <textarea class="form-control" name="user_about" rows="3"><%= user.getAbout()%></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Photo :</th>
                                            <td>
                                                <input type="file" name="image" class="form-control" />
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div> 

        <!--End of Profile Modal-->


        <!--Add post modal--> 

        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form  id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>--Select Category--</option>
                                    <%

                                        ArrayList<Category> list = postDao.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control" />
                            </div>
                            <div class="form-group">
                                <textarea name="pContent" class="form-control" rows="5" placeholder="Enter your content"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea name="pCode" class="form-control" rows="3" placeholder="Enter your program (if any)"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="post-pic">Select your pic...</label>
                                <input name="pPic" id="post-pic" type="file" class="form-control" />
                            </div>
                            <div class="container text-center mt-3 mb-3">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--End of add post modal-->

        <%
            }
        %>



        <!--Bootstrap js--> 
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js"></script>
        <script>
                                $(document).ready(function () {
                                    let editStatus = false;
                                    $("#edit-profile-button").on("click", function () {
                                        if (editStatus === false) {
                                            $("#profile-details").hide();
                                            $("#profile-edit").show();
                                            editStatus = true;
                                            $(this).text("Back");
                                        } else {
                                            $("#profile-details").show();
                                            $("#profile-edit").hide();
                                            editStatus = false;
                                            $(this).text("Edit");
                                        }
                                    });
                                });
        </script>   
        <!--now add post js--> 
        <script>
            $(document).ready(function (e) {
                $("#add-post-form").on("submit", function (event) {
                    // after form submission...            
                    event.preventDefault();
                    let form = new FormData(this);
                    // send to add post servlet
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.trim() === 'done') {
                                swal("Good job!", "Post uploaded successfully", "success")
                                        .then((value) => {
                                            window.location = "profile.jsp";
                                        });
                            } else {
                                swal("Oops!", "Something went wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Oops!", "Something went wrong", "error");
                        },
                        // below two fields need to be false, to send photos to the server.
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>   
        <!--now add comment js--> 
        <script>
            $(document).ready(function () {
                $('#comment-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    form.append('pid', <%= post.getPid()%>);
                    form.append('uid', <%= user.getId()%>);
                    //send to comment servlet:
                    $.ajax({
                        url: "CommentServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);

                            if (data.trim() === 'done')
                            {
                                swal("Comment posted successfully...")
                                        .then((value) => {
                                            window.location = "show_blog_page.jsp?postId=" + <%= post.getPid()%> + "";
                                        });
                            } else
                            {
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("something went wrong..try again");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
