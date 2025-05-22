<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lunettes - Premium Eyewear</title>
        <link rel="shortcut icon" type="x-icon" href="images/logo.png" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    </head>

    <body>
        <jsp:include page="header.jsp" />


        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <div class="hero-text fade-in">
                    <h1>See the World with Clarity</h1>
                    <p>Discover our premium collection of eyewear designed for style, comfort, and unparalleled vision.
                    </p>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/product" class="btn">Shop Now</a>
                        <a href="${pageContext.request.contextPath}/about" class="btn btn-outline">Explore</a>
                    </div>
                </div>
                <div class="hero-image fade-in">
                    <img src="resources/images/Premium.jpg" alt="Premium Glasses" class="glasses-image">
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <div class="section-container">
                <div class="section-title fade-in">
                    <h2>Why Choose Lunettes</h2>
                    <p>We combine cutting-edge technology with timeless design to create eyewear that enhances your
                        vision and style.</p>
                </div>

                <div class="features-grid">
                    <div class="feature-card fade-in">
                        <div class="feature-icon">🏆</div>
                        <h3>Premium Quality</h3>
                        <p>Each frame is crafted with high-quality materials for durability and comfort.</p>
                    </div>

                    <div class="feature-card fade-in">
                        <div class="feature-icon">🎨</div>
                        <h3>Unique Designs</h3>
                        <p>Our collections feature exclusive designs you won't find anywhere else.</p>
                    </div>

                    <div class="feature-card fade-in">
                        <div class="feature-icon">❤️</div>
                        <h3>Perfect Fit</h3>
                        <p>Customizable options ensure your glasses fit perfectly and feel comfortable.</p>
                    </div>
                </div>
            </div>
        </section>

      

        <!-- Testimonials -->
        <section class="testimonials">
            <div class="section-container">
                <div class="section-title fade-in">
                    <h2>What Our Customers Say</h2>
                    <p>Hear from people who have experienced the Lunettes difference.</p>
                </div>

                <div class="testimonials-slider">
                    <div class="testimonials-container">
                        <div class="testimonial fade-in">
                            <img src="resources/images/Sarah.jpg" alt="Sarah J." class="testimonial-avatar">
                            <p class="testimonial-text">"I've never worn glasses as comfortable as my Lunettes."</p>
                            <h4 class="testimonial-author">Sarah J.</h4>
                            <p class="testimonial-role">Fashion Designer</p>
                        </div>
                        <div class="testimonial fade-in">
                            <img src="resources/images/arun.jpg" alt="Michael T." class="testimonial-avatar">
                            <p class="testimonial-text">"The clarity of vision with Lunettes is unmatched."</p>
                            <h4 class="testimonial-author">Michael T.</h4>
                            <p class="testimonial-role">Photographer</p>
                        </div>
                        <div class="testimonial fade-in">
                            <img src="resources/images/Jennifer.jpg" alt="Jennifer L." class="testimonial-avatar">
                            <p class="testimonial-text">"Best investment I've made in eyewear."</p>
                            <h4 class="testimonial-author">Jennifer L.</h4>
                            <p class="testimonial-role">Graphic Designer</p>
                        </div>
                    </div>

                    <div class="slider-controls">
                    	<button class="slider-arrow prev">←</button>
                        <div class="slider-dots">
                            <button class="slider-dot active"></button>
                            <button class="slider-dot"></button>
                            <button class="slider-dot"></button>
                        </div>
                        <button class="slider-arrow next">→</button>
                    </div>
                </div>
            </div>
        </section>

        <!-- Newsletter -->
        <section class="newsletter">
            <div class="section-container">
                <div class="section-title fade-in">
                    <h2>Stay Updated</h2>
                    <p>Subscribe to our newsletter for exclusive offers and new arrivals.</p>
                </div>

                <form class="newsletter-form">
                    <input type="email" placeholder="Your email address" class="newsletter-input fade-in" required>
                    <button type="submit" class="newsletter-btn fade-in">Subscribe</button>
                </form>
            </div>
        </section>
        <script>
            // Scroll Animation
            const fadeElements = document.querySelectorAll('.fade-in');

            const appearOptions = {
                threshold: 0.1,
                rootMargin: "0px 0px -50px 0px"
            };

            const appearOnScroll = new IntersectionObserver((entries, appearOnScroll) => {
                entries.forEach(entry => {
                    if (!entry.isIntersecting) {
                        return;
                    } else {
                        entry.target.classList.add('visible');
                        appearOnScroll.unobserve(entry.target);
                    }
                });
            }, appearOptions);

            fadeElements.forEach(fader => {
                appearOnScroll.observe(fader);
            });


            // Testimonial Slider
            let currentSlide = 0;
            const slides = document.querySelectorAll('.testimonial');
            const dots = document.querySelectorAll('.slider-dot');
            const prevBtn = document.querySelector('.slider-arrow.prev');
            const nextBtn = document.querySelector('.slider-arrow.next');
            const sliderContainer = document.querySelector('.testimonials-container');
            
            function showSlide(index) {
                // Wrap around if at ends
                if (index >= slides.length) currentSlide = 0;
                if (index < 0) currentSlide = slides.length - 1;
                
                // Update slider position
                sliderContainer.style.transform = `translateX(-${currentSlide * 100}%)`;
                
                // Update dot indicators
                dots.forEach(dot => dot.classList.remove('active'));
                dots[currentSlide].classList.add('active');
            }
            
            // Navigation functions
            function nextSlide() {
                currentSlide++;
                showSlide(currentSlide);
            }
            
            function prevSlide() {
                currentSlide--;
                showSlide(currentSlide);
            }
            
            // Event listeners
            nextBtn.addEventListener('click', nextSlide);
            prevBtn.addEventListener('click', prevSlide);
            
            // Dot navigation
            dots.forEach((dot, index) => {
                dot.addEventListener('click', () => {
                    currentSlide = index;
                    showSlide(currentSlide);
                });
            });
            
            // Keyboard navigation
            document.addEventListener('keydown', (e) => {
                if (e.key === 'ArrowRight') nextSlide();
                if (e.key === 'ArrowLeft') prevSlide();
            });
            
            // Auto-advance
            let slideInterval = setInterval(nextSlide, 5000);
            
            // Pause on hover
            const sliderWrapper = document.querySelector('.testimonials-slider');
            sliderWrapper.addEventListener('mouseenter', () => {
                clearInterval(slideInterval);
            });
            
            sliderWrapper.addEventListener('mouseleave', () => {
                slideInterval = setInterval(nextSlide, 5000);
            });
            
            // Initialize
            showSlide(currentSlide);
        </script>
        <!-- Include Footer -->
        <jsp:include page="footer.jsp" />

    </body>

    </html>