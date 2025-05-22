<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return And Exchange Policy</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    <style>
        :root {
            --glass-white: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(247, 237, 237, 0.9);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            --primary-color: #0066cc;
            --text-dark: #222;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('images/gucci.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            position: relative;
            color: var(--text-dark);
        }

        /* Optional overlay to darken background for better text contrast */
        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: -1;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            padding: 2rem;
        }

        .glass-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            box-shadow: var(--glass-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        h1, h2 {
            color: var(--primary-color);
        }

        ul {
            padding-left: 1.2rem;
        }

        li {
            margin-bottom: 0.5rem;
        }

        a {
            color: var(--primary-color);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        
        .glass-card button {
    /* Button base styles */
    background: rgba(64, 158, 255, 0.3);  /* Semi-transparent blue */
	border: 1px solid rgba(64, 158, 255, 0.5);
    color: blue;
    padding: 12px 30px;
    font-size: 1rem;
    font-weight: 500;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    backdrop-filter: blur(5px);
    margin-top: 1rem;
   }


        .center {
            text-align: center;
        }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" />
	
    <div class="overlay"></div>

    <div class="container">
        <div class="glass-card center">
            <h1>Return And Exchange Policy</h1>
            <p>Your satisfaction is our priority. Here's how returns work.</p>
        </div>

        <div class="glass-card">
            <h2>Return Period</h2>
            <ul>
                <li>Return your item within <strong>30 days</strong> of purchase.</li>
                <li>Holiday season (Nov 1 to Dec 31): return until <strong>Feb 1, 2024</strong>.</li>
            </ul>
        </div>

        <div class="glass-card">
            <h2>Eligible Returns</h2>
            <ul>
                <li>Items must be <strong>unused, undamaged, and in original packaging</strong>.</li>
                <li><strong>Final sale items</strong> (e.g., discounts or limited editions) are not returnable.</li>
            </ul>
        </div>

        <div class="glass-card">
            <h2>How to Return</h2>
            <ul>
                <li>Start your return on our <a href="${pageContext.request.contextPath}/returnitem">Returns Portal</a>.</li>
                <li>For specific products like OOFOS, contact us at <a href="https://mail.google.com/mail/u/">lunettes@gmail.com</a>.</li>
            </ul>
        </div>

        <div class="glass-card">
            <h2>Refund Process</h2>
            <ul>
                <li>Refunds processed within <strong>3 to 5 business days</strong> after inspection.</li>
                <li>Refunds go back to your original payment method or store credit.</li>
            </ul>
        </div>

        <div class="glass-card">
            <h2>International Orders</h2>
            <ul>
                <li>We currently <strong>do not accept international returns</strong>.</li>
            </ul>
        </div>

        <div class="glass-card center">
            <h2>Need More Help?</h2>
            <p>Email our team anytime and we will help you sort things out.</p>
            <a href="${pageContext.request.contextPath}/contact">
  			<button>Contact Support</button>
			</a>
        </div>
    </div>
    
    <!-- Include Footer -->
        <jsp:include page="footer.jsp" />
</body>
</html>
