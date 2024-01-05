<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <%@include file="navbar.jsp" %>

        <main class="d-flex align-items-center primary-background banner-background" style="height:150vh;padding-bottom:40px">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-plus fa-3x"></span>
                                <br/>
                                <p>Register here</p>
                            </div>
                            <div class="card-body">
                                <form id="reg-form" action="RegisterServlet" method="post">
                                    <div class="form-group">
                                        <label for="user_name">User Name</label>
                                        <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label>
                                        <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label>
                                        <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Select gender</label>
                                        <br/>
                                        <input type="radio" id="gender" name="gender" value="Male">Male
                                        <input type="radio" id="gender" name="gender" value="Female">Female
                                    </div>
                                    <div class="form-group">
                                        <textarea name="about" class="form-control" id="about" rows="5" placeholder="Enter something about yourself"></textarea>
                                    </div>
                                    <div class="form-check">
                                        <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Agree terms & conditions</label>
                                    </div>
                                    <br/>
                                    <div class="container text-center" id="loader" style="display:none">
                                        <span class="fa fa-refresh fa-spin fa-4x"></span>
                                        <h4>Please wait..</h4>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                            <div class="card-footer">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <!--Bootstrap js--> 
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                console.log("loaded........");

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);

                    $("#sumbimt-btn").hide();
                    $("#loader").show();
                    //send to register servlet:
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);

                            $("#sumbimt-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'done')
                            {
                                swal("Registered successfully..We are going to redirect you to login page")
                                        .then((value) => {
                                            window.location = "login.jsp";
                                        });
                            } else
                            {
                                swal(data);
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#sumbimt-btn").show();
                            $("#loader").hide();
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
