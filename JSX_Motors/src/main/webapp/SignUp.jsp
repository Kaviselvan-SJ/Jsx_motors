<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Signup - JSX Motors</title>
  <style>
   .basic-form {
        max-width: 400px;
        margin: 40px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-family: Arial, sans-serif;
      }
      .basic-form label {
        font-weight: bold;
      }
      .basic-form input {
        width: 100%;
        padding: 8px;
        margin: 6px 0 12px;
        border: 1px solid #ccc;
        border-radius: 3px;
        box-sizing: border-box;
        font-size: 14px;
      }
      .basic-form button {
        padding: 10px 20px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
      }
      #email-status {
        font-size: 13px;
        margin-top: -8px;
        margin-bottom: 10px;
        display: block;
      }
  </style>
  <script>
    function checkEmail() {
      var email = document.getElementById("email").value;
      if (email.trim() === "") return;

      var xhr = new XMLHttpRequest();
      xhr.open("POST", "checkEmail", true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var response = xhr.responseText.trim();
          var status = document.getElementById("email-status");
          if (response === "exists") {
            status.style.color = "red";
            status.innerHTML = "Email already registered!";
          } else {
            status.style.color = "green";
            status.innerHTML = "Email available.";
          }
        }
      };
      xhr.send("email=" + encodeURIComponent(email));
    }
  </script>
</head>
<body>
  <form class="basic-form" action="signup" method="POST">
    <h2>Sign Up</h2>

    <label>User ID:</label><br/>
    <input type="text" name="userId" required /><br/>

    <label>Name:</label><br/>
    <input type="text" name="name" required /><br/>

    <label>Email:</label><br/>
    <input type="email" name="email" id="email" onblur="checkEmail()" required />
    <span id="email-status"></span><br/>

    <label>Password:</label><br/>
    <input type="password" name="password" required /><br/>

    <label>Age:</label><br/>
    <input type="number" name="age" required /><br/>

    <button type="submit">Register</button><br/><br/>
    <a href="Login.jsp">Already have an account? Login</a>
  </form>
</body>
</html>
