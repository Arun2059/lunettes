<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4bb543;
            --error-color: #ff3333;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            color: var(--dark-color);
            line-height: 1.6;
        }

        .login-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            padding: 40px;
            width: 150%;
            max-width: 600px;
            text-align: center;
            animation: fadeIn 0.6s ease;
            position: relative;
            overflow: hidden;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        .logo {
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
        }

        .logo i {
            font-size: 60px;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .logo:hover i {
            transform: scale(1.05);
            color: var(--secondary-color);
        }

        h1 {
            color: var(--dark-color);
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: 700;
            position: relative;
            display: inline-block;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background-color: var(--accent-color);
            border-radius: 3px;
        }

        .input-group {
            margin-bottom: 22px;
            text-align: left;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        input {
            width: 100%;
            padding: 14px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            font-family: 'Poppins', sans-serif;
        }

        input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        input:hover {
            border-color: #bbbbbb;
        }

        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 14px 20px;
            width: 100%;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
        }

        button:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4);
        }

        button:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(67, 97, 238, 0.3);
        }

        .forgot-password {
            display: block;
            margin-top: 18px;
            color: var(--primary-color);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .forgot-password:hover {
            color: var(--secondary-color);
            transform: translateY(-1px);
        }

        .divider {
            margin: 30px 0;
            color: #ddd;
            display: flex;
            align-items: center;
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #ddd;
        }

        .divider-text {
            padding: 0 15px;
            color: #777;
            font-size: 14px;
            font-weight: 500;
        }

        .signup-link {
            margin-top: 25px;
            font-size: 15px;
            color: #555;
        }

        .signup-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .signup-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        /* Social login buttons - optional */
        .social-login {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 20px;
        }

        .social-btn {
            flex: 1;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background-color: white;
            color: #555;
        }

        .social-btn i {
            margin-right: 8px;
        }

        .social-btn.google {
            color: #DB4437;
        }

        .social-btn.facebook {
            color: #4267B2;
        }

        .social-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Styled message boxes */
        .message {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
            animation: fadeInMessage 0.5s ease;
            position: relative;
            padding-right: 35px;
        }

        @keyframes fadeInMessage {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-message {
            background-color: rgba(255, 51, 51, 0.1);
            color: var(--error-color);
            border: 1px solid var(--error-color);
        }

        .success-message {
            background-color: rgba(75, 181, 67, 0.1);
            color: var(--success-color);
            border: 1px solid var(--success-color);
        }

        .message::before {
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
        }

        .error-message::before {
            content: "\f071"; /* Warning icon */
            color: var(--error-color);
        }

        .success-message::before {
            content: "\f00c"; /* Check icon */
            color: var(--success-color);
        }

        /* Improved checkbox styling */
        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 18px;
            position: relative;
            padding-left: 28px;
            cursor: pointer;
            user-select: none;
        }

        .remember-me input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
            height: 0;
            width: 0;
        }

        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: #eee;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .remember-me:hover input ~ .checkmark {
            background-color: #ddd;
        }

        .remember-me input:checked ~ .checkmark {
            background-color: var(--primary-color);
        }

        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        .remember-me input:checked ~ .checkmark:after {
            display: block;
        }

        .remember-me .checkmark:after {
            left: 7px;
            top: 3px;
            width: 5px;
            height: 10px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }

        .remember-me label {
            margin-left: 5px;
            margin-bottom: 0;
            font-weight: normal;
            font-size: 14px;
            color: #666;
        }

        /* Password visibility toggle */
        .password-container {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #888;
            transition: all 0.3s ease;
        }

        .toggle-password:hover {
            color: var(--primary-color);
        }

        /* Responsive tweaks */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px 20px;
            }
            
            h1 {
                font-size: 24px;
            }
            
            .social-login {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="logo">
            <i class="fas fa-user-circle"></i>
        </div>
        <h1>Welcome Back</h1>

        <!-- Display error message if any -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="message error-message">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <!-- Display success message if any -->
        <% if (request.getAttribute("message") != null) { %>
        <div class="message success-message">
            <%= request.getAttribute("message") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" placeholder="Enter your username or email" 
                       value="${username != null ? username : ''}" required>
            </div>

            <div class="input-group password-container">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <span class="toggle-password" onclick="togglePassword()">
                    <i class="far fa-eye" id="toggleIcon"></i>
                </span>
            </div>

            <label class="remember-me">
                <input type="checkbox" id="remember-me" name="rememberMe">
                <span class="checkmark"></span>
                Remember me
            </label>

            <button type="submit">Sign In</button>

            <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">Forgot password?</a>

            <div class="divider">
                <span class="divider-text">OR</span>
            </div>

            <div class="social-login">
                <button type="button" class="social-btn google">
                    <i class="fab fa-google"></i> Google
                </button>
                <button type="button" class="social-btn facebook">
                    <i class="fab fa-facebook-f"></i> Facebook
                </button>
            </div>

            <div class="signup-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Create an account</a>
            </div>
        </form>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>

</html>