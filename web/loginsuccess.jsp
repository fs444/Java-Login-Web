<%@page import="java.util.HashMap"%>
<%@page import="loginapppackage.*"%>

<%@page import="java.sql.*"%>
<%@page import="jakarta.servlet.ServletException"%>
<%@page import="jakarta.servlet.http.HttpServlet"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int user_id = (Integer) session.getAttribute("user_id");
    
    HashMap <String, String> userInfo = new HashMap<String, String>();

    try {
        Connection con = MySQL.connection();

        PreparedStatement preparedStatement = con.prepareStatement("SELECT * from login JOIN details ON login.id = details.user_id WHERE login.id = ?");

        preparedStatement.setInt(1, user_id);

        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            userInfo.put("username", rs.getString("username"));
            userInfo.put("firstName", rs.getString("first_name") == null ? "" : rs.getString("first_name"));
            userInfo.put("lastName", rs.getString("last_name") == null ? "" : rs.getString("last_name"));
            userInfo.put("email", rs.getString("email") == null ? "" : rs.getString("email"));
        }
    } catch (Exception e) {
        System.out.println(e);
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login V15</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <jsp:include page="common/header.jsp"></jsp:include>
    </head>
    
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-form-title" style="background-image: url(images/bg-01.jpg);">
                        <span class="login100-form-title-1"><%=userInfo.get("username") %> <a href="<%=request.getContextPath()%>/login.jsp?exit=1">[ exit ]</a></span>
                    </div>
  
                    <form id="user_info" action="" method="post" enctype="application/x-www-form-urlencoded" class="login100-form -validate-form">
                        <div class="wrap-input100 validate-input m-b-26">
                            <span class="label-input100">First name</span>
                            <input type="text" id="first_name" name="first_name" value="<%=userInfo.get("firstName") %>" class="input100" placeholder="Enter first name" />
                            <span class="focus-input100"></span>
                        </div>
 
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Last name</span>
                            <input type="text" id="last_name" name="last_name" value="<%=userInfo.get("lastName") %>" class="input100" placeholder="Enter last name" />
                            <span class="focus-input100"></span>
                        </div>
                        
                        <div class="wrap-input100 validate-input m-b-18">
                            <span class="label-input100">Email</span>
                            <input type="email" id="email" name="email" value="<%=userInfo.get("email") %>" class="input100" placeholder="Enter email" />
                            <span class="focus-input100"></span>
                            <div class="validate-message-show">
                                <label id="email-error" class="error" for="email"></label>
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
                $("#user_info").validate({
                    submitHandler: function(form) {
                        var user_id = <%=user_id %>;
                        var name = $("#first_name").val();
                        var last_name = $("#last_name").val();
                        var email = $("#email").val();

                        $.ajax({
                            type: "post",
                            url: "AjaxControllerServlet",
                            data: {user_id: user_id, name: name, last_name: last_name, email: email},
                            success: function(result) {
                                if (result == 1) {
                                    alert("ok");
                                } else if (result == 2) {
                                    alert("Some problem");
                                } else if (result == 3) {
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