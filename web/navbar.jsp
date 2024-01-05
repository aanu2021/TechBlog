<%@page import="com.tech.blog.entities.User"%>
<%

    User user = (User) session.getAttribute("currentUser");

%>

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

            <%   if (user == null) {

            %> 
            <li class="nav-item">
                <a class="nav-link" href="register.jsp"><span class="fa fa-user-plus"></span> Signup</a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="login.jsp"><span class="fa fa-user-circle"></span> Login</a>
            </li>
            
            <%   } else {
            %> 
            <li class="nav-item">
                <a class="nav-link" href="favourites.jsp"><span class="fa fa-star"></span> Favourites</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
            </li>
            <%
                }
            %>

        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>