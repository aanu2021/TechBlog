<%@page import="com.tech.blog.dao.FollowDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<%@page import="com.tech.blog.entities.User" %>
<%

    User user = (User) session.getAttribute("currentUser");

    boolean currentUserProfile = true;
    int userId = 0;
    int preSelectedCategoryId = 0;
    User searchedUser = null;
    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
    FollowDao followDao = new FollowDao(ConnectionProvider.getConnection());

    if (request.getParameter("userId") != null) {
        userId = Integer.parseInt(request.getParameter("userId"));
        currentUserProfile = false;
        searchedUser = userDao.getUserDetailsByUserId(userId);
    }

    if (request.getParameter("categoryId") != null) {
        preSelectedCategoryId = Integer.parseInt(request.getParameter("categoryId"));
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
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
            body{
                background : url("images/bg.jpeg");
                background-size : cover;
                background-attachment: fixed;
            }
            .name-class{
                font-weight: bold;
                font-size : 20px;
            }
            .para-class{
                font-weight : 600;
                font-size : 15px;
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

        <!--Success Message/ Danger Message--> 

        <%
            Message msg = (Message) session.getAttribute("message");
            if (msg != null) {
        %>
        <div class="alert <%= msg.getCssClass()%> alert-dismissible fade show" role="alert">
            <strong><%= msg.getContent()%></strong>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                session.removeAttribute("message");
            }
        %>


        <!--Main body of the page--> 

        <main>
            <div class="container">
                <!--User profile structure--> 
                <div class="row mt-5">
                    <%
                        if (currentUserProfile == false) {
                            int blogsCount = postDao.postCountsByUserId(userId);
                            int totalLikesCount = likeDao.likeCountsByUserId(userId);
                            int totalFollowersCount = followDao.followersCount(searchedUser.getId());
                    %>
                    <div class="col-md-4 offset-md-4">
                        <!--User Profile, along with like counts and blog counts--> 
                        <div class="card mb-3">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-4">
                                        <img class="card-img-top" src="pics/<%= searchedUser.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width:80px;max-height:85px;" alt="Card image caption" />                                        
                                    </div>
                                    <div class="col-md-8">
                                        <p class="name-class"><%= searchedUser.getName()%></p>
                                        <p class="para-class"><%= searchedUser.getEmail()%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="para-class"><span class="name-class"><%= blogsCount%></span> blogs</p>        
                                    </div>
                                    <div class="col-md-6">
                                        <p class="para-class"><span class="name-class"><%= totalLikesCount%></span> likes</p>  
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="para-class"><span class="name-class"><%= totalFollowersCount%></span> followers</p>  
                                    </div>
                                    <div class="col-md-6">
                                        <%
                                            if (user != null) {
                                                if (followDao.isFollowedByUserId(user.getId(), searchedUser.getId()) == true) {
                                        %>  
                                        <a href="#!" onclick="doUnFollow(<%= user.getId()%>, <%= searchedUser.getId()%>)" class="btn btn-md btn-outline-primary">Unfollow</a>
                                        <%
                                        } else {
                                        %> 
                                        <a href="#!" onclick="doFollow(<%= user.getId()%>, <%= searchedUser.getId()%>)" class="btn btn-md btn-primary">Follow</a>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <a href="login.jsp" class="btn btn-md btn-primary">Follow</a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>    
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <!--All the categories available--> 
                <div class="row mt-5">
                    <div class="col-md-2 mt-3">
                        <!--Categories--> 
                        <div class="list-group">
                            <a href="#!" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">
                                All posts
                            </a>
                            <%
                                ArrayList<Category> list = postDao.getAllCategories();
                                for (Category c : list) {
                            %>
                            <a href="#!" id="<%=c.getCid()%>" onclick="getPosts(<%= c.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= c.getName()%></a>
                            <%
                                }
                            %> 
                        </div>
                    </div>
                    <div class="col-md-9">
                        <!--Posts--> 
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>
                        <div class="container-fluid" id="post-container">

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--End of main body of the page--> 


        <%
            if (user
                    != null) {
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
        <script src="js/myjs2.js"></script>
        <script src="js/myjs3.js"></script>

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


        <!--Loading post using ajax-->
        <script>

            function getPosts(catId, temp) {
                let flag = <%= currentUserProfile%>;
                $("#loader").show();
                $("#post-container").hide();
                $(".c-link").removeClass("active");

                if (flag == true) {
                    $.ajax({
                        url: "load_posts.jsp",
                        data: {cid: catId},
                        success: function (data, textStatus, jqXHR) {
                            $("#loader").hide();
                            $("#post-container").show();
                            $('#post-container').html(data);
                            $(temp).addClass('active');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        },
                    });
                } else {
                    let uid = <%= userId%>;
                    $.ajax({
                        url: "load_posts.jsp",
                        data: {cid: catId, userId: uid},
                        success: function (data, textStatus, jqXHR) {
                            $("#loader").hide();
                            $("#post-container").show();
                            $('#post-container').html(data);
                            $(temp).addClass('active');
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        },
                    });
                }
            }
            ;

            $(document).ready(function (e) {
                let allPostReference = $(".c-link")[0];
                let currentCategoryId = <%= preSelectedCategoryId%>;

                if (currentCategoryId !== 0) {
                    allPostReference = $("#" + currentCategoryId);
                    getPosts(currentCategoryId, allPostReference);
                } else {
                    getPosts(0, allPostReference);
                }
            }
            );
        </script>
    </body>
</html>
