<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String contextPath=request.getContextPath(); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Contact Us</title>
            <link rel="shortcut icon" type="x-icon" href="images/logo.png" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <section id="page-header" class="about-header">
                <h2>Let's Talk</h2>
                <p>LEAVE A MESSAGE, We love to hear from you!</p>
            </section>

            <section id="contact-details" class="contact-p1">
                <div class="details">
                    <span>GET IN TOUCH</span>
                    <h2>Visit one of our stores or contact us today</h2>
                    <h3>Head Office</h3>
                    <div>
                        <li>
                            <i>📍</i>
                            <p>Tinkune, Kathmandu, Nepal</p>
                        </li>
                        <li>
                            <i>✉️</i>
                            <p>lunettes@gmail.com</p>
                        </li>
                        <li>
                            <i>📞</i>
                            <p>+977 9815151515</p>
                        </li>
                        <li>
                            <i>🕒</i>
                            <p>Sunday to Friday: 10.00am to 8.00pm</p>
                        </li>
                    </div>
                </div>
                <div class="map">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d56524.975474686406!2d85.3213184!3d27.6922368!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb190025b8f8cb%3A0x31244c792d1f2e71!2sTinkune%20chowk!5e0!3m2!1sne!2snp!4v1744449517615!5m2!1sne!2snp"
                        allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </section>

            <section id="form-details">
   <form action="contact" method="post">
   <div style="color: red; font-size: 13px;">
                              <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </div>
         <div style="color: green; font-size: 13px;">
               <%= request.getAttribute("success") != null ? request.getAttribute("success") : "" %>
        </div>
               
   
        <span>LEAVE A MESSAGE</span>
        <h2>We love to hear from you</h2>

        <input type="text" placeholder="Your Name" name="name" required 
               value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>">
        <div style="color: red; font-size: 13px;">
            <%= request.getAttribute("nameError") != null ? request.getAttribute("nameError") : "" %>
        </div>

        <input type="email" placeholder="Email" name="email" required 
               value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
        <div style="color: red; font-size: 13px;">
            <%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %>
        </div>

        <input type="text" placeholder="Subject" name="subject" 
               value="<%= request.getAttribute("subject") != null ? request.getAttribute("subject") : "" %>">
        <div style="color: red; font-size: 13px;">
            <%= request.getAttribute("subjectError") != null ? request.getAttribute("subjectError") : "" %>
        </div>

        <textarea name="message" id="" cols="30" rows="10" placeholder="Your Message" required><%= 
            request.getAttribute("messageText") != null ? request.getAttribute("messageText") : "" 
        %></textarea>
        <div style="color: red; font-size: 13px;">
            <%= request.getAttribute("messageError") != null ? request.getAttribute("messageError") : "" %>
        </div>

        <button class="normal">Submit</button>
    </form>

                <div class="people">
                    <div>
                        <img src="resources/images/arun.jpg" alt="Team Member">
                        <p><span>Arun Kumar Sah</span>Fullstack Developer <br> Phone: +977 9898989898 <br> Email:
                            arun@gmail.com</p>
                    </div>
                    <div>
                        <img src="resources/images/ashok.jpeg" alt="Team Member">
                        <p><span>Ashok Basnet</span>Fullstack Developer <br> Phone: +977 9898989898 <br> Email:
                            ashok@gmail.com</p>
                    </div>
                    <div>
                        <img src="resources/images/yojana.jpeg" alt="Team Member">
                        <p><span>Yojana Subedi</span>Fullstack Developer <br> Phone: +977 9898989898 <br> Email:
                            yojana@gmail.com</p>
                    </div>
                    <div>
                        <img src="resources/images/pradip.jpg" alt="Team Member">
                        <p><span>Pradip Baniya</span>Fullstack Developer <br> Phone: +977 9898989898 <br> Email:
                            pradip@gmail.com</p>
                    </div>
                    <div>
                        <img src="resources/images/samriddha1.jpg" alt="Team Member">
                        <p><span>Samriddha Thapa</span>Fullstack Developer <br> Phone: +977 9898989898 <br> Email:
                            samriddha@gmail.com</p>
                    </div>
                </div>
            </section>
            <jsp:include page="footer.jsp" />

        </body>

        </html>