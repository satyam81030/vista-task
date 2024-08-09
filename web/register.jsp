<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
        <link rel="stylesheet" href="style.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script>
            function redirectToRegister() {
                window.location.href = 'index.jsp';
            }
        </script>
    </head>
    <body>
        <div class="reg-container" style="background-color: #aed3d4; margin: 0 auto; margin-top: 50px; border-radius: 10px; display: table;">
            <div class="title-form">
                <h1>Vista Task Register</h1>
            </div>
            <form id="dataForm" method="post" action="registerProcess.jsp">
                <div class="registration-form" style="margin: 10px; padding: 10px; display: flex; flex-direction: column; align-content: flex-start; justify-content: space-evenly; flex-wrap: wrap;">
                    <div class="field-form">
                        <label for="name" style="margin: 2px">Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="field-form">
                        <label for="email" style="margin: 2px">Email ID</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="field-form">
                        <label for="phone" style="margin: 2px">Phone Number</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>
                    <div class="field-form">
                        <label for="number" style="margin: 2px">Aadhar Number</label>
                        <input type="number" id="aadhar" name="aadhar" required>
                    </div>
                </div>
                <div class="field-form button">
                    <div>
                        <button type="submit" id="addButton" class="add" style="height: 100%;">Register</button>
                    </div> 
                    <div>
                        <button type="button" id="addButton" class="add" style="height: 100%;" onclick="redirectToRegister()">Login </button>   
                    </div> 
                </div>
                <hr style="width: 80%; border: 1px solid white; margin: 20px auto;">
            </form>
            <div id="dataDisplay"></div>
        </div>
    </body>
</html>
