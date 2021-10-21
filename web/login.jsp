<%@page import="loginapppackage.*"%>

<%
String exit = request.getParameter("exit");

if (exit != null) {
    session.setAttribute("user_id", null);
}
    
if (null != session.getAttribute("user_id")) {
    response.sendRedirect("loginsuccess.jsp");
}
%>

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
                        <span class="login100-form-title-1">Sign In</span>
                    </div>

                    <%
                    Boolean fail_entry = Operations.checkFailEntry(request.getParameter("fail_entry"));

                    if (fail_entry) {
                        out.println("<div style='text-align: center; margin-top: 19px;'>User does not exist</div>");
                    }
                    %>

                    <form id="loginform" action="<%=request.getContextPath()%>/login" method="post" class="login100-form -validate-form">
                        <div class="wrap-input100 validate-input m-b-26">
                            <span class="label-input100">Username</span>
                            <input type="text" name="username" minlength="2" class="input100" placeholder="Enter username" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="username-error" class="error" for="username"></label>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Password</span>
                            <input type="password" name="password" class="input100" placeholder="Enter password" required>
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="password-error" class="error" for="password"></label>
                            </div>
                        </div>

                        <div class="flex-sb-m w-full p-b-30">
                            <div>
                                <a href="<%=request.getContextPath()%>/registration.jsp" class="txt1">Registration</a> | <a href="<%=request.getContextPath()%>/forgetpassword.jsp" class="txt1">Forgot Password?</a>
                            </div>
                        </div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                            
        <script>
            $(document).ready(function() {
                $("#loginform").validate();
            });
        </script>
        
        <jsp:include page="common/footer.jsp"></jsp:include>
    </body>
</html>