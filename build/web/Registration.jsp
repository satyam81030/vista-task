<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista Task</title>
    <link rel="stylesheet" href="style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="title-form">
            <h1>DATA ENTRY</h1>
        </div>
        <form id="dataForm" method="post" action="admin.jsp">
            <div class="student-form" id="studentForm">
                <div class="field-form">
                    <input type="text" name="Name1" placeholder="Enter data" class="dynamic-input" required>
                    <button type="button" class="deleteButton">Delete</button>
                </div>
            </div>

            <div class="field-form button">
                <div>
                    <button type="button" id="addButton" class="add">Add Box</button>
                </div>
                <div>
                    <button type="submit" class="add" name="action" value="insertData">Submit</button>
                </div>
                <div>
                    <button type="button" id="showDataButton" class="add">Show Data</button>
                </div>
                <div>
                    <button type="button" id="showUserDataButton" class="add">User Login</button>
                </div>
                <div>
                    <button type="button" id="showDetailsButton" class="add" onclick="location.href='showDetails.jsp'">Show Details</button>
                </div>
            </div>
            <div id="dataDisplay" style="display:none;"></div> <!-- Initially hidden -->
            <div id="userDataDisplay" style="display:none;"></div> <!-- Initially hidden -->
            <div id="detailsDisplay" style="display:none;"></div> <!-- Initially hidden -->
        </form>
    </div>

    <script>
        $(document).ready(function () {
            $('#showDataButton').click(function () {
                var $dataDisplay = $('#dataDisplay');
                if ($dataDisplay.is(':visible')) {
                    $dataDisplay.hide();
                } else {
                    $.ajax({
                        url: 'admin.jsp',
                        type: 'POST',
                        data: { action: 'showData' },
                        success: function (response) {
                            $dataDisplay.html(response).show();
                        },
                        error: function (xhr, status, error) {
                            console.error('AJAX Error: ', status, error);
                        }
                    });
                }
            });

            $('#addButton').click(function () {
                var studentForm = $('#studentForm');
                var newIndex = studentForm.find('input').length + 1;
                var newField = '<div class="field-form"><input type="text" name="Name' + newIndex + '" placeholder="Enter data" class="dynamic-input" required>\n\
                    <button type="button" class="deleteButton">Delete</button></div>';
                studentForm.append(newField);
            });

            $(document).on('click', '.deleteButton', function () {
                $(this).parent().remove();
            });

            $('#showUserDataButton').click(function () {
                var $userDataDisplay = $('#userDataDisplay');
                if ($userDataDisplay.is(':visible')) {
                    $userDataDisplay.hide();
                } else {
                    $.ajax({
                        url: 'admin.jsp',
                        type: 'POST',
                        data: { action: 'showUserData' },
                        success: function (response) {
                            $userDataDisplay.html(response).show();
                        },
                        error: function (xhr, status, error) {
                            console.error('AJAX Error: ', status, error);
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>
