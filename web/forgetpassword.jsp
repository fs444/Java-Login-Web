<%@page import="loginapppackage.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login V15</title>
        <jsp:include page="common/header.jsp"></jsp:include>
    </head>
    
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-form-title" style="background-image: url(images/bg-01.jpg);">
                        <span class="login100-form-title-1">Forget password</span>
                    </div>
  
                    <form id="forget-password-form" action="" method="post" enctype="application/x-www-form-urlencoded" class="login100-form -validate-form">
                        <div class="wrap-input100 validate-input m-b-26">
                            <span class="label-input100">Username</span>
                            <input type="text" id="user_name" name="user_name" value="" minlength="2" class="input100" placeholder="Enter username" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="user_name-error" class="error" for="user_name"></label>
                            </div>
                        </div>
 
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">First name</span>
                            <input type="text" id="first_name" name="first_name" value="" class="input100" placeholder="Enter first name" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="first_name-error" class="error" for="first_name"></label>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Last name</span>
                            <input type="text" id="last_name" name="last_name" value="" class="input100" placeholder="Enter last name" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="last_name-error" class="error" for="last_name"></label>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Email</span>
                            <input type="email" id="email" name="email" value="" class="input100" placeholder="Enter email" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="email-error" class="error" for="email"></label>
                            </div>
                        </div>

                        <div class="flex-sb-m w-full p-b-30"></div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn">Restore password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                            
        <script>
            $(document).ready(function() {
                $("#forget-password-form").validate({
                    submitHandler: function(form) {
                        var user_name = $("#user_name").val();
                        var first_name = $("#first_name").val();
                        var last_name = $("#last_name").val();
                        var email = $("#email").val();

                        $.ajax({
                            type: "post",
                            url: "ForgetPasswordServlet",
                            data: {user_name:user_name, first_name:first_name, last_name:last_name, email:email},
                            success: function(result) {
                                if (result > 0) {
                                    window.location.href = "<%=request.getContextPath()%>/typenewpassword.jsp?id=" + result;
                                } else if (result == 0) {
                                    alert("User not found");
                                } else {
                                    alert("Some problem");
                                }
                            }
                        });
                    }
                });
            });
        </script>
        
        <jsp:include page="common/footer.jsp"></jsp:include>
    </body>
</html>