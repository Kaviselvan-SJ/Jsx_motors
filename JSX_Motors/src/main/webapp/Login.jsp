<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login - JSX Motors</title>
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
      .basic-form input,
      .basic-form textarea {
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
        color: rgb(224, 216, 98);
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
      }
  </style>
</head>
<body>
  <form class="basic-form" action="login" method="POST">
    <h2>Login</h2>

    <label>Email:</label>
    <input type="email" name="email" required />

    <label>Password:</label>
    <input type="password" name="password" required />

    <button type="submit">Login</button>
    <a href="SignUp.jsp">Don't have an account? Sign up</a>
  </form>
</body>
</html>
