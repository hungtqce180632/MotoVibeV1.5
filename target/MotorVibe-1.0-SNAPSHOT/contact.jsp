<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <style>
            :root {
                --longthinh-web-mau-nut: #FFC107;   /* Màu vàng cho nút */
                --longthinh-web-mau-text: #ff5722;  /* Màu nền text */
                --longthinh-web-trai: 35px; /* Bên trái nhập trái 35px; phải auto */
                --longthinh-web-phai: auto; /* Bên phải nhập trái auto; phải 35px */
                --longthinh-web-duoi: 35px;
            }

            /* Container của nút liên hệ */
            .dv-social-button {
                display: inline-grid;
                position: fixed;
                bottom: var(--longthinh-web-duoi);
                left: var(--longthinh-web-trai);
                right: var(--longthinh-web-phai);
                min-width: 45px;
                text-align: center;
                z-index: 99999;
            }

            /* Danh sách các tùy chọn liên hệ (ẩn mặc định) */
            .dv-social-button-content {
                display: none;
            }

            /* Các nút tròn */
            .dv-social-button a {
                margin: 8px 0;
                cursor: pointer;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                border-radius: 100%;
                text-decoration: none;
                background: var(--longthinh-web-mau-nut); /* Màu vàng */
            }

            /* Biểu tượng trong nút */
            .dv-social-button i {
                color: #fff;
                font-size: 20px;
                display: block;
                position: relative;
                z-index: 1;
            }

            /* Hiệu ứng rung động */
            .alo-circle, .alo-circle-fill {
                animation-iteration-count: infinite;
                animation-duration: 1s;
                animation-fill-mode: both;
                width: 50px;
                height: 50px;
                top: -5px;
                right: -5px;
                position: absolute;
                border-radius: 100%;
                border: 2px solid rgba(30, 30, 30, 0.1);
                opacity: 0.5;
                background: var(--longthinh-web-mau-nut);
            }

            .alo-circle-fill {
                width: 60px;
                height: 60px;
                top: -10px;
                right: -10px;
                opacity: 0.2;
            }

            /* Nút chính (user-support) */
            .user-support {
                background: var(--longthinh-web-mau-nut) !important; /* Đổi màu vàng */
                color: white;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                cursor: pointer;
                font-size: 22px;
                z-index: 1000;
                transition: all 0.3s ease;
            }

            /* Hiệu ứng hover */
            .user-support:hover {
                background: #FFB300; /* Màu vàng đậm hơn */
                transform: scale(1.1);
            }

            /* Khi di chuột vào, hiển thị tooltip */
            .dv-social-button a:hover > span {
                display: block;
            }

            /* Hiển thị nội dung tooltip */
            .dv-social-button a span {
                border-radius: 7px;
                text-align: center;
                background: var(--longthinh-web-mau-text);
                padding: 7px 15px;
                display: none;
                width: auto;
                margin-left: 10px;
                position: absolute;
                color: #ffffff;
                z-index: 999;
                top: 2px;
                left: 45px;
                transition: all 0.2s ease-in-out;
                white-space: nowrap;
                line-height: 1.3;
            }

            .dv-social-button a span:before {
                content: "";
                width: 0;
                height: 0;
                border-style: solid;
                border-width: 8px 8px 8px 0;
                border-color: transparent var(--longthinh-web-mau-text) transparent transparent;
                position: absolute;
                left: -7px;
                top: 9px;
            }
        </style>
    </head>
    <body>
        <!-- Contact Floating Button -->
        <div class="dv-social-button">
            <div class="dv-social-button-content">
                <a href="tel:0817 771 184" class="call-icon" target="_blank" rel="nofollow">
                    <i class="fa fa-phone"></i>
                    <div class="animated alo-circle"></div>
                    <div class="animated alo-circle-fill"></div>
                    <span>Hotline: 0817 771 184</span>
                </a>
                <a href="sms:0817 771 184" target="_blank" class="sms">
                    <i class="fa fa-weixin"></i>
                    <span>SMS: 0817 771 184</span>
                </a>
                <a href="https://www.facebook.com/hung.dps.2024" target="_blank" class="mes">
                    <i class="fa fa-facebook-square"></i>
                    <span>Facebook</span>
                </a>
                <a href="http://zalo.me/0817771184" target="_blank" class="zalo">
                    <i class="fa fa-commenting-o"></i>
                    <span>Zalo: 0817 771 184</span>
                </a>
            </div>

            <!-- Nút chính màu vàng -->
            <a class="user-support">
                <i class="fa fa-user-circle-o"></i>
                <div class="animated alo-circle"></div>
                <div class="animated alo-circle-fill"></div>
            </a>
        </div>

        <!-- JavaScript Toggle -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var userSupport = document.querySelector('.user-support');
                var socialButtonContent = document.querySelector('.dv-social-button-content');

                userSupport.addEventListener("click", function (event) {
                    if (window.getComputedStyle(socialButtonContent).display === "none") {
                        socialButtonContent.style.display = "block";
                    } else {
                        socialButtonContent.style.display = "none";
                    }
                });
            });
        </script>
    </body>
</html>
