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
                        <span class="login100-form-title-1">Registration</span>
                    </div>
  
                    <form id="form_registration" action="" method="post" enctype="application/x-www-form-urlencoded" class="login100-form -validate-form">
                        <div class="wrap-input100 validate-input m-b-26">
                            <span class="label-input100">Username</span>
                            <input type="text" id="user_name" name="user_name" value="" minlength="2" class="input100" placeholder="Enter username" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="user_name-error" class="error" for="user_name"></label>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Password</span>
                            <input type="password" id="password" name="password" value="" class="input100" placeholder="Enter password" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="password-error" class="error" for="password"></label>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Confirm password</span>
                            <input type="password" id="confirm_password" name="confirm_password" value="" class="input100" placeholder="Enter password confirmation" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="confirm_password-error" class="error" for="confirm_password"></label>
                            </div>
                        </div>

                        <div class="flex-sb-m w-full p-b-30"></div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                            
        <script>
            $(document).ready(function() {
                $("#form_registration").validate({
                    rules: {
                        confirm_password: {
                            equalTo: "#password"
                        }
                    },

                    submitHandler: function(form) {
                        var user_name = $("#user_name").val();
                        var password = $("#password").val();
                        var confirm_password = $("#confirm_password").val();

                        $.ajax({
                            type: "post",
                            url: "AjaxRegistrationServlet",
                            data: {user_name:user_name, password:password, confirm_password:confirm_password},
                            success: function(result) {
                                if (result == 1) {
                                    alert("Type username");
                                } else if (result == 2) {
                                    alert("Type password");
                                } else if (result == 3) {
                                    alert("Type confirmation password");
                                } else if (result == 4) {
                                    alert("Password and confirmation does not equal");
                                } else if (result == 5) {
                                    window.location.href = "<%=request.getContextPath()%>/login.jsp";
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