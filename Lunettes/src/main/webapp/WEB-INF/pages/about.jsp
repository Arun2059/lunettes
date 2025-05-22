<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String contextPath=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lunettes - Premium Eyewear</title>
            <link rel="shortcut icon" type="x-icon" href="images/logo.png" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
        </head>

        <body>
            <jsp:include page="header.jsp" />
            <!-- Hero Section -->
            <section class="hero">
                <div class="container">
                    <h1>About Lunettes</h1>
                    <p>Crafting premium sunglasses that combine cutting-edge protection with timeless style since 2012
                    </p>
                </div>
            </section>

            <!-- About Section -->
            <div class="container">
                <div class="section-title">
                    <h2>Our Story</h2>
                </div>

                <div class="about-content">
                    <div class="about-text">
                        <h3>Visionary Eyewear Since 2012</h3>
                        <p>Lunettes was born from a simple idea: sunglasses should be both exceptionally protective and
                            undeniably stylish. Founded in a small workshop, we've grown into a global brand without
                            losing
                            our commitment to handcrafted quality.</p>
                        <p>Each pair undergoes rigorous testing to ensure 100% UV protection while maintaining the
                            highest
                            fashion standards. We source only premium materials - from Italian acetates to
                            German-engineered
                            hinges.</p>
                        <p>Today, Lunettes sunglasses are worn by style-conscious individuals worldwide who appreciate
                            the
                            perfect blend of form and function.</p>
                    </div>
                    <div class="about-image">
                        <img src="resources/images/about_body.jpg" alt="Lunettes workshop">
                    </div>
                </div>
            </div>

            <!-- Team Section -->
            <section class="team-section">
                <div class="container">
                    <div class="section-title">
                        <h2>Meet Our Team</h2>
                    </div>

                    <div class="team-grid">
                        <!-- Team Member 1 -->
                        <div class="team-member">
                            <div class="member-image">
                                <img src="resources/images/arun.jpg" alt="Arun Kumar Sah">
                            </div>
                            <div class="member-info">
                                <h3>Arun Kumar Sah</h3>
                                <p class="position">Founder & Deveoper</p>
                                <p>"Success doesn't come from what you do occasionally, it comes from what you do
                                    consistently."</p>
                            </div>
                        </div>

                        <!-- Team Member 2 -->
                        <div class="team-member">
                            <div class="member-image">
                                <img src="resources/images/ashok.jpeg" alt="Ashok Basnet">
                            </div>
                            <div class="member-info">
                                <h3>Ashok Basnet</h3>
                                <p class="position">Founder & Developer</p>
                                <p>"Don't wait for the perfect moment. Take the moment and make it perfect."</p>
                            </div>
                        </div>

                        <!-- Team Member 5 (Claire Martin) - Centered -->
                        <div class="team-member center">
                            <div class="member-image">
                                <img src="resources/images/samriddha1.jpg" alt="Samriddha Thapa">
                            </div>
                            <div class="member-info">
                                <h3>Samriddha Thapa</h3>
                                <p class="position">Founder & Developer</p>
                                <p> "The harder you work for something, the greater you'll feel when you achieve it."
                                </p>
                            </div>
                        </div>

                        <!-- Team Member 3 -->
                        <div class="team-member">
                            <div class="member-image">
                                <img src="resources/images/pradip.jpg" alt="Pradip Baniya">
                            </div>
                            <div class="member-info">
                                <h3>Pradip Baniya</h3>
                                <p class="position"> Founder & Developer </p>
                                <p>"Believe in yourself and all that you are. Know that there is something inside you
                                    that
                                    is greater than any obstacle."</p>
                            </div>
                        </div>

                        <!-- Team Member 4 -->
                        <div class="team-member">
                            <div class="member-image">
                                <img src="resources/images/yojana.jpeg" alt="Yojana Subedi">
                            </div>
                            <div class="member-info">
                                <h3>Yojana Subedi</h3>
                                <p class="position">Founder & Marketing Manager</p>
                                <p>"The only limit to our realization of tomorrow is our doubts of today."</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Values Section -->
            <div class="container">
                <div class="section-title">
                    <h2>Our Values</h2>
                </div>

                <div class="values">
                    <div class="value-card">
                        <div class="value-icon">👓</div>
                        <h3>Optical Excellence</h3>
                        <p>Medical-grade UV protection in every lens, tested to exceed industry standards</p>
                    </div>

                    <div class="value-card">
                        <div class="value-icon">✋</div>
                        <h3>Handcrafted Quality</h3>
                        <p>Each frame receives 8+ hours of hand polishing for a flawless finish</p>
                    </div>

                    <div class="value-card">
                        <div class="value-icon">🌱</div>
                        <h3>Sustainable Materials</h3>
                        <p>Using bio-acetates and recycled metals whenever possible</p>
                    </div>

                    <div class="value-card">
                        <div class="value-icon">❤️</div>
                        <h3>Customer First</h3>
                        <p>2-year warranty with free adjustments for the perfect fit</p>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        </body>

        </html>