<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - Lunettes</title>
    <link rel="shortcut icon" type="x-icon" href="images/logo.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    
    <style>
        body {
             background-color: var(--light);
    color: var(--text);
    line-height: 1.6;
        }
        
        /* Main Container */
        .policy-container {
            max-width: 1000px;
             margin: 0 auto 0;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }3
        
        /* Header */
        .policy-header {
      	    margin:70px auto auto auto;
            padding: 40px 30px;
            text-align: center;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
        }
        
        .policy-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        
        .policy-header p {
            opacity: 0.9;
            font-size: 1.1rem;
            font-weight: 400;
        }
        
        /* Content */
        .policy-content {
            padding: 40px;
        }
        
        .policy-section {
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid #eee;
        }
        
        .policy-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .policy-section h2 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: #2c3e50;
            font-weight: 600;
            position: relative;
            padding-bottom: 8px;
        }
        
        .policy-section h2:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(90deg, #6a11cb 0%, #2575fc 100%);
            border-radius: 3px;
        }
        
        .policy-section p {
            margin-bottom: 16px;
            line-height: 1.7;
            color: #555;
            font-size: 1.02rem;
        }
        
        .policy-section ul {
            margin: 16px 0;
            padding-left: 24px;
        }
        
        .policy-section li {
            margin-bottom: 10px;
            color: #555;
            line-height: 1.6;
        }
        
        /* Footer */
        .policy-footer {
            text-align: center;
            padding: 24px;
            background: #f1f3f5;
            font-size: 0.9rem;
            color: #666;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .policy-container {
                margin: 20px;
                border-radius: 8px;
            }
            
            .policy-header {
                padding: 30px 20px;
            }
            
            .policy-header h1 {
                font-size: 2rem;
            }
            
            .policy-content {
                padding: 30px;
            }
        }
        
        @media (max-width: 480px) {
            .policy-header {
                padding: 24px 16px;
            }
            
            .policy-header h1 {
                font-size: 1.8rem;
            }
            
            .policy-content {
                padding: 24px 16px;
            }
            
            .policy-section h2 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="policy-container">
        <div class="policy-header">
            <h1>Privacy Policy</h1>
            <p>Last Updated: January 1, 2023</p>
        </div>
        
        <div class="policy-content">
            <div class="policy-section">
                <h2>1. Introduction</h2>
                <p>Welcome to our Privacy Policy. Your privacy is critically important to us. This privacy policy document describes how we collect, use, and protect any information that you provide when you use our website.</p>
            </div>
            
            <div class="policy-section">
                <h2>2. Information We Collect</h2>
                <p>We may collect the following information:</p>
                <ul>
                    <li>Name and contact information including email address</li>
                    <li>Demographic information such as postcode, preferences and interests</li>
                    <li>Other information relevant to customer surveys and/or offers</li>
                    <li>Technical data including IP address, browser type and version</li>
                </ul>
            </div>
            
            <div class="policy-section">
                <h2>3. How We Use Your Information</h2>
                <p>We require this information to understand your needs and provide you with better service, and in particular for the following reasons:</p>
                <ul>
                    <li>Internal record keeping</li>
                    <li>Improving our products and services</li>
                    <li>Sending promotional emails about new products, special offers or other information</li>
                    <li>Customizing the website according to your interests</li>
                </ul>
            </div>
            
            <div class="policy-section">
                <h2>4. Security</h2>
                <p>We are committed to ensuring that your information is secure. In order to prevent unauthorized access or disclosure, we have put in place suitable physical, electronic and managerial procedures to safeguard and secure the information we collect online.</p>
            </div>
            
            <div class="policy-section">
                <h2>5. Cookies</h2>
                <p>We use cookies to analyze web traffic and improve our website. A cookie is a small file which asks permission to be placed on your computer's hard drive. You can choose to accept or decline cookies.</p>
            </div>
            
            <div class="policy-section">
                <h2>6. Links to Other Websites</h2>
                <p>Our website may contain links to other websites of interest. However, once you have used these links to leave our site, you should note that we do not have any control over that other website.</p>
            </div>
            
            <div class="policy-section">
                <h2>7. Controlling Your Personal Information</h2>
                <p>You may choose to restrict the collection or use of your personal information in the following ways:</p>
                <ul>
                    <li>Whenever you are asked to fill in a form on the website, look for the box that you can click to indicate that you do not want the information to be used for direct marketing purposes</li>
                    <li>If you have previously agreed to us using your personal information for direct marketing purposes, you may change your mind at any time by contacting us</li>
                </ul>
            </div>
        </div>
        
        <div class="policy-footer">
            <p>© 2023 Lunettes. All rights reserved.</p>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>