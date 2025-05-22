<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glasses Shipping Information</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --glass-white: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.3);
            --glass-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --primary-color: #4a6fa5;
            --secondary-color: #ff7e5f;
            --accent-color: #6b8cff;
            --text-dark: #2d3748;
            --text-light: #f8f9fa;
            --gradient-bg: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--gradient-bg);
            color: var(--text-dark);
            line-height: 1.7;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            max-width: 1200px;
            margin: 6rem auto 0;
            padding: 2rem;
            flex: 1;
        }
        
        .glass-card {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: 16px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--glass-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            overflow: hidden;
            position: relative;
        }
        
        .glass-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }
        
        header.glass-card {
            text-align: center;
            padding: 5rem 2rem;
            background: linear-gradient(rgba(74, 111, 165, 0.8), rgba(74, 111, 165, 0.9)), 
                        url('https://images.unsplash.com/photo-1556306535-0f09a537f0a3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center/cover;
            color: var(--text-light);
            border: none;
        }
        
        header.glass-card h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            letter-spacing: 1px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            font-weight: 700;
        }
        
        header.glass-card p {
            font-size: 1.3rem;
            max-width: 700px;
            margin: 0 auto;
            opacity: 0.9;
        }
        
        .shipping-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }
        
        .shipping-option {
            padding: 2rem;
            text-align: center;
            position: relative;
        }
        
        .shipping-option h3 {
            color: var(--primary-color);
            margin-top: 0;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .shipping-option .price {
            font-weight: bold;
            color: var(--secondary-color);
            font-size: 1.5rem;
            margin: 1rem 0;
            display: inline-block;
            padding: 0.5rem 1.5rem;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 50px;
        }
        
        .shipping-option p {
            color: var(--text-dark);
            margin-bottom: 1.5rem;
        }
        
        .shipping-option i {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            display: block;
        }
        
        .faq {
            padding: 2rem;
        }
        
        .faq h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: var(--primary-color);
            font-size: 2rem;
            position: relative;
            display: inline-block;
            left: 50%;
            transform: translateX(-50%);
        }
        
        .faq h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 3px;
        }
        
        .faq-item {
            margin-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            padding-bottom: 1rem;
        }
        
        .faq-question {
            font-weight: 600;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            font-size: 1.1rem;
            color: var(--text-dark);
        }
        
        .faq-question span {
            font-size: 1.3rem;
        }
        
        .faq-answer {
            padding: 0 0 1rem;
            color: #555;
            display: none;
            padding-left: 1rem;
            border-left: 3px solid var(--secondary-color);
        }
        
        .faq-answer.show {
            display: block;
        }
        
        .contact-section {
            text-align: center;
            padding: 3rem 2rem;
        }
        
        .contact-section h2 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
        }
        
        .contact-btn {
            background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(74, 111, 165, 0.3);
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .contact-btn i {
            font-size: 1.2rem;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            header.glass-card {
                padding: 3rem 1rem;
            }
            
            header.glass-card h1 {
                font-size: 2.5rem;
            }
            
            header.glass-card p {
                font-size: 1.1rem;
            }
            
            .shipping-options {
                grid-template-columns: 1fr;
            }
            
            .faq h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
	<jsp:include page="header.jsp" />
	
    <div class="container">
        <header class="glass-card">
            <h1>Shipping Information</h1>
            <p>How we deliver your glass products safely to your doorstep</p>
        </header>
        
        <div class="shipping-options">
            <div class="glass-card shipping-option">
                <i class="fas fa-truck"></i>
                <h3>Standard Shipping</h3>
                <p>Reliable delivery with careful handling</p>
                <p>3-5 business days</p>
                <p class="price">$8.99</p>
            </div>
            
            <div class="glass-card shipping-option">
                <i class="fas fa-bolt"></i>
                <h3>Express Shipping</h3>
                <p>Priority handling for faster delivery</p>
                <p>1-2 business days</p>
                <p class="price">$14.99</p>
            </div>
            
            <div class="glass-card shipping-option">
                <i class="fas fa-gem"></i>
                <h3>Premium Glass Shipping</h3>
                <p>White-glove delivery with extra protection</p>
                <p>Signature required</p>
                <p class="price">$29.99</p>
            </div>
        </div>
        
        <div class="glass-card faq">
            <h2>Frequently Asked Questions</h2>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleAnswer(this)">
                    How do you package glass items for shipping?
                    <span>+</span>
                </div>
                <div class="faq-answer">
                    All glass products are wrapped in bubble wrap, secured with foam corners, and shipped in double-walled boxes with fragile labeling. Our premium shipping includes additional protective layers and custom foam inserts.
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" onclick="toggleAnswer(this)">
                    Is all the product manufactured in Nepal?
                    <span>+</span>
                </div>
                <div class="faq-answer">
                    We proudly support local craftsmanship - some of our glasses are manufactured by Nepali companies to promote domestic brands. We also carry a curated selection of international designer eyewear to offer diverse options to our customers.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleAnswer(this)">
                    What if my item arrives damaged?
                    <span>+</span>
                </div>
                <div class="faq-answer">
                    We offer a 100% satisfaction guarantee. If your item arrives damaged, contact us within 48 hours with photos and we'll replace it immediately at no additional cost. Our customer service team is available 24/7 to assist with any issues.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleAnswer(this)">
                    Do you ship internationally?
                    <span>+</span>
                </div>
                <div class="faq-answer">
                    Yes! We ship to most countries worldwide. We offer free international shipping on orders over $1500. International orders typically arrive within 7-14 business days depending on destination and customs processing.
                </div>
            </div>
        </div>
        
        <div class="contact-section glass-card">
            <h2>Need Help With Shipping?</h2>
            <p>Our dedicated shipping team is ready to assist you</p>
            <button class="contact-btn">
                <i class="fas fa-paper-plane"></i> Contact Shipping Team
            </button>
        </div>
    </div>
    
    <script>
        function toggleAnswer(question) {
            const answer = question.nextElementSibling;
            const icon = question.querySelector('span');
            
            if (answer.classList.contains('show')) {
                answer.classList.remove('show');
                icon.textContent = '+';
            } else {
                answer.classList.add('show');
                icon.textContent = '-';
            }
        }
    </script>
    
    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>