<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vista Task</title>
        <link rel="stylesheet" href="style.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
            function redirectToRegister() {
                window.location.href = 'register.jsp';
            }
        </script> 
    </head>
    <body>
        <div class="reg-container" style="background-color: #aed3d4; margin: 0 auto; margin-top: 50px; border-radius: 10px; display: table;">
            
            
            <div class="title-form">
                <h1>Vista Task Login</h1>
            </div>
            <form id="dataForm" method="post" action="loginProcess.jsp">
                <div class="registration-form" style="margin: 10px; padding: 10px; display: flex; flex-direction: column; align-content: flex-start; justify-content: space-evenly; flex-wrap: wrap;">
                    <div class="field-form">
                        <label for="name" style="margin: 2px">User Name</label>
                        <input type="text" id="name" name="username" required>
                    </div>
                    <div class="field-form">
                        <label for="password" style="margin: 2px">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                </div>
                <div class="field-form button">
                    <div>
                        <button type="submit" id="loginButton" class="add" style="height: 100%;">Login</button>
                    </div>
                    <div>
                    <button type="button" id="registerButton" class="add" style="height: 100%;" onclick="redirectToRegister()">Register</button>   
                </div> 
                </div>
                <hr style="width: 80%; border: 1px solid white; margin: 20px auto;">
            </form>
            <div id="dataDisplay"></div>
        </div>
    </body>
</html>
