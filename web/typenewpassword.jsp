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
                        <span class="login100-form-title-1">NEW PASSWORD</span>
                    </div>
  
                    <form id="new-password" action="" method="post" enctype="application/x-www-form-urlencoded" class="login100-form -validate-form">
                        <div class="wrap-input100 validate-input m-b-26">
                            <span class="label-input100">New password</span>
                            <input type="password" id="new_password" name="new_password" value="" minlength="2" class="input100" placeholder="Enter new password" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="new_password-error" class="error" for="new_password"></label>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Confirm new password</span>
                            <input type="password" id="confirm_new_password" name="confirm_new_password" value="" class="input100" placeholder="Enter password confirmation" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="confirm_new_password-error" class="error" for="confirm_new_password"></label>
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
                $("#new-password").validate({
                    rules: {
                        confirm_new_password: {
                            equalTo: "#new_password"
                        }
                    },

                    submitHandler: function(form) {
                        var new_password = $("#new_password").val();
                        var confirm_new_password = $("#confirm_new_password").val();
                        var id = <%= request.getParameter("id") %>;

                        $.ajax({
                            type: "post",
                            url: "SaveNewPasswordServlet",
                            data: {new_password:new_password, confirm_new_password:confirm_new_password, id: id},
                            success: function(result) {
                                if (result == 1) {
                                    window.location.href = "<%=request.getContextPath()%>/login.jsp";
                                } else if (result == -1) {
                                    alert("Some problem");
                                } else if (result == 3) {
                                    alert("Passwords do not match");
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