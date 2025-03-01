<%-- 
    Document   : register
    Created on : Feb 25, 2025, 1:44:14 PM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Register</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,300" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Oswald:500,400" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            /* colors and layout from login.jsp (no changes needed for register.jsp) */
            html {
                width: 100%;
                height: 100%;
            }
            body {
                background-color: #eff3f4;
                position: relative;
                width: 100%;
                height: 100%;
                font-size: 16px;
                font-family: 'Source Sans Pro', sans-serif;
                font-weight: 400;
                -webkit-font-smoothing: antialiased;
            }
            form {
                position: relative;
                display: block;
                width: 100%;
                max-width: 400px;
                background-color: #fff;
                margin: 0;
                padding: 2.25em;
                box-sizing: border-box;
                border: solid 1px #ddd;
                border-radius: 0.5em;
                font-family: 'Source Sans Pro', sans-serif;
                top: 0;
                left: 0;
                transform: none; /* Override centering transform for register page */
            }
            form .svgContainer {
                position: relative;
                width: 200px;
                height: 200px;
                margin: 0 auto 1em;
                border-radius: 50%;
                background: none;
                border: solid 2.5px #3a5e77;
                overflow: hidden;
                pointer-events: none;
            }
            form .svgContainer div {
                position: relative;
                width: 100%;
                height: 0;
                overflow: hidden;
                padding-bottom: 100%;
            }
            form .svgContainer .mySVG {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
            }
            form .inputGroup {
                margin: 0 0 2em;
                padding: 0;
                position: relative;
            }
            form .inputGroup:last-of-type {
                margin-bottom: 0;
            }
            form label {
                margin: 0 0 12px;
                display: block;
                font-size: 1.25em;
                color: #217093;
                font-weight: 700;
                font-family: inherit;
            }
            form input[type='email'], form input[type="text"], form input[type='password'] {
                display: block;
                margin: 0;
                padding: 0 1em 0;
                background-color: #f3fafd;
                border: solid 2px #217093;
                border-radius: 4px;
                -webkit-appearance: none;
                box-sizing: border-box;
                width: 100%;
                height: 65px;
                font-size: 1.55em;
                color: #353538;
                font-weight: 600;
                font-family: inherit;
                transition: box-shadow 0.2s linear, border-color 0.25s ease-out;
            }
            form input[type='email']:focus, form input[type="text"]:focus, form input[type='password']:focus {
                outline: none;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, .1);
                border: solid 2px #4eb8dd;
            }
            form input[type='email'], form input[type="text"] {
                padding: 14px 1em 0px;
            }
            form button {
                display: block;
                margin: 0;
                padding: 0.65em 1em 1em;
                background-color: #4eb8dd;
                border: none;
                border-radius: 4px;
                box-sizing: border-box;
                box-shadow: none;
                width: 100%;
                height: 65px;
                font-size: 1.55em;
                color: #fff;
                font-weight: 600;
                font-family: inherit;
                transition: background-color 0.2s ease-out;
            }
            form button:hover, form button:active {
                background-color: #217093;
            }
            form .inputGroup1 .helper {
                position: absolute;
                z-index: 1;
                font-family: inherit;
            }
            form .inputGroup1 .helper1 {
                top: 0;
                left: 0;
                transform: translate(1.4em, 2.6em) scale(1);
                transform-origin: 0 0;
                color: #217093;
                font-size: 1.25em;
                font-weight: 400;
                opacity: 0.65;
                pointer-events: none;
                transition: transform 0.2s ease-out, opacity 0.2s linear;
            }
            form .inputGroup1.focusWithText .helper {
                /*input[type='email']:focus + .helper {*/
                transform: translate(1.4em, 2em) scale(0.65);
                opacity: 1;
            }

            /* boostrap layout  (no changes needed for register.jsp) */
            .logo {
                font-family: "Oswald", sans-serif;
                font-weight: 500;
                color: #050B20;
            }
            a:hover {
                color: inherit; /* Keep original color on hover */
            }
            .btn-dark {
                background-color: #050B20;
            }
            .container-fluid {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                padding: 0;
            }

            .row {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
            }

            .col-lg-6 {
                max-width: 400px; /* Set a max width to the form */
                width: 100%;
                margin: 0 auto; /* Center the form horizontally */
            }
        </style>
    </head>
    <body>
        <div class="container-fluid vh-100">
            <div class="row h-100">
                <div class="col-lg-6 d-flex justify-content-center align-items-center">
                    <div class="w-100" style="max-width: 400px;">
                        <a class="logo text-decoration-none" href="/"><h1 class="mb-5">MotoVibe</h1></a>
                        <h2 class="fw-bold">Create Account</h2> <%-- Changed heading to "Create Account" --%>
                        <%-- Display error if any --%>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form action="register" method="post"> <%-- Changed form action to "register" --%>
                            <div class="svgContainer">
                                <div>
                                    <svg class="mySVG" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 200 200">
                                    <defs>
                                    <circle id="armMaskPath" cx="100" cy="100" r="100"/>
                                    </defs>
                                    <clipPath id="armMask">
                                        <use xlink:href="#armMaskPath" overflow="visible"/>
                                    </clipPath>
                                    <circle cx="100" cy="100" r="100" fill="#a9ddf3"/>
                                    <g class="body">
                                    <path fill="#FFFFFF" d="M193.3,135.9c-5.8-8.4-15.5-13.9-26.5-13.9H151V72c0-27.6-22.4-50-50-50S51,44.4,51,72v50H32.1 c-10.6,0-20,5.1-25.8,13l0,78h187L193.3,135.9z"/>
                                    <path fill="none" stroke="#3A5E77" stroke-width="2.5" stroke-linecap="round" stroke-linejoinn="round" d="M193.3,135.9 c-5.8-8.4-15.5-13.9-26.5-13.9H151V72c0-27.6-22.4-50-50-50S51,44.4,51,72v50H32.1c-10.6,0-20,5.1-25.8,13"/>
                                    <path fill="#DDF1FA" d="M100,156.4c-22.9,0-43,11.1-54.1,27.7c15.6,10,34.2,15.9,54.1,15.9s38.5-5.8,54.1-15.9 C143,167.5,122.9,156.4,100,156.4z"/>
                                    </g>
                                    <g class="earL">
                                    <g class="outerEar" fill="#ddf1fa" stroke="#3a5e77" stroke-width="2.5">
                                    <circle cx="47" cy="83" r="11.5"/>
                                    <path d="M46.3 78.9c-2.3 0-4.1 1.9-4.1 4.1 0 2.3 1.9 4.1 4.1 4.1" stroke-linecap="round" stroke-linejoin="round"/>
                                    </g>
                                    <g class="earHair">
                                    <rect x="51" y="64" fill="#FFFFFF" width="15" height="35"/>
                                    <path d="M53.4 62.8C48.5 67.4 45 72.2 42.8 77c3.4-.1 6.8-.1 10.1.1-4 3.7-6.8 7.6-8.2 11.6 2.1 0 4.2 0 6.3.2-2.6 4.1-3.8 8.3-3.7 12.5 1.2-.7 3.4-1.4 5.2-1.9" fill="#fff" stroke="#3a5e77" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </g>
                                    </g>
                                    <g class="earR">
                                    <g class="outerEar" fill="#ddf1fa" stroke="#3a5e77" stroke-width="2.5">
                                    <circle cx="155" cy="83" r="11.5"/>
                                    <path d="M155.7 78.9c2.3 0 4.1 1.9 4.1 4.1 0 2.3-1.9 4.1-4.1 4.1" stroke-linecap="round" stroke-linejoin="round"/>
                                    </g>
                                    <g class="earHair">
                                    <rect x="131" y="64" fill="#FFFFFF" width="20" height="35"/>
                                    <path d="M148.6 62.8c4.9 4.6 8.4 9.4 10.6 14.2-3.4-.1-6.8-.1-10.1.1 4 3.7 6.8 7.6 8.2 11.6-2.1 0-4.2 0-6.3.2 2.6 4.1-3.8 8.3-3.7 12.5-1.2-.7-3.4-1.4 5.2-1.9" fill="#fff" stroke="#3a5e77" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </g>
                                    </g>
                                    <path class="chin" d="M84.1 121.6c2.7 2.9 6.1 5.4 9.8 7.5l.9-4.5c2.9 2.5 6.3 4.8 10.2 6.5 0-1.9-.1-3.9-.2-5.8 3 1.2 6.2 2 9.7 2.5-.3-2.1-.7-4.1-1.2-6.1" fill="none" stroke="#3a5e77" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path class="face" fill="#DDF1FA" d="M134.5,46v35.5c0,21.815-15.446,39.5-34.5,39.5s-34.5-17.685-34.5-39.5V46"/>
                                    <path class="hair" fill="#FFFFFF" stroke="#3A5E77" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" d="M81.457,27.929 c1.755-4.084,5.51-8.262,11.253-11.77c0.979,2.565,1.883,5.14,2.712,7.723c3.162-4.265,8.626-8.27,16.272-11.235 c-0.737,3.293-1.588,6.573-2.554,9.837c4.857-2.116,11.049-3.64,18.428-4.156c-2.403,3.23-5.021,6.391-7.852,9.474"/>
                                    <g class="eyebrow">
                                    <path fill="#FFFFFF" d="M138.142,55.064c-4.93,1.259-9.874,2.118-14.787,2.599c-0.336,3.341-0.776,6.689-1.322,10.037 c-4.569-1.465-8.909-3.222-12.996-5.226c-0.98,3.075-2.07,6.137-3.267,9.179c-5.514-3.067-10.559-6.545-15.097-10.329 c-1.806,2.889-3.745,5.73-5.816,8.515c-7.916-4.124-15.053-9.114-21.296-14.738l1.107-11.768h73.475V55.064z"/>
                                    <path fill="#FFFFFF" stroke="#3A5E77" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" d="M63.56,55.102 c6.243,5.624,13.38,10.614,21.296,14.738c2.071-2.785,4.01-5.626,5.816-8.515c4.537,3.785,9.583,7.263,15.097,10.329 c1.197-3.043,2.287-6.104,3.267-9.179c4.087,2.004,8.427,3.761,12.996,5.226c0.545-3.348,0.986-6.696,1.322-10.037 c4.913-0.481,9.857-1.34,14.787-2.599"/>
                                    </g>
                                    <g class="eyeL">
                                    <circle cx="85.5" cy="78.5" r="3.5" fill="#3a5e77"/>
                                    <circle cx="84" cy="76" r="1" fill="#fff"/>
                                    </g>
                                    <g class="eyeR">
                                    <circle cx="114.5" cy="78.5" r="3.5" fill="#3a5e77"/>
                                    <circle cx="113" cy="76" r="1" fill="#fff"/>
                                    </g>
                                    <g class="mouth">
                                    <path class="mouthBG" fill="#617E92" d="M100.2,101c-0.4,0-1.4,0-1.8,0c-2.7-0.3-5.3-1.1-8-2.5c-0.7-0.3-0.9-1.2-0.6-1.8 c0.2-0.5,0.7-0.7,1.2-0.7c0.2,0,0.5,0.1,0.6,0.2c3,1.5,5.8,2.3,8.6,2.3s5.7-0.7,8.6-2.3c0.2-0.1,0.4-0.2,0.6-0.2 c0.5,0,1,0.3,1.2,0.7c0.4,0.7,0.1,1.5-0.6,1.9c-2.6,1.4-5.3,2.2-7.9,2.5C101.7,101,100.5,101,100.2,101z"/>
                                    <path style="display: none;" class="mouthSmallBG" fill="#617E92" d="M100.2,101c-0.4,0-1.4,0-1.8,0c-2.7-0.3-5.3-1.1-8-2.5c-0.7-0.3-0.9-1.2-0.6-1.8 c0.2-0.5,0.7-0.7,1.2-0.7c0.2,0,0.5,0.1,0.6,0.2c3,1.5,5.8,2.3,8.6,2.3s5.7-0.7,8.6-2.3c0.2-0.1,0.4-0.2,0.6-0.2 c0.5,0,1,0.3,1.2,0.7c0.4,0.7,0.1,1.5-0.6,1.9c-2.6,1.4-5.3,2.2-7.9,2.5C101.7,101,100.5,101,100.2,101z"/>
                                    <path style="display: none;" class="mouthMediumBG" d="M95,104.2c-4.5,0-8.2-3.7-8.2-8.2v-2c0-1.2,1-2.2,2.2-2.2h22c1.2,0,2.2,1,2.2,2.2v2 c0,4.5-3.7,8.2-8.2,8.2H95z"/>
                                    <path style="display: none;" class="mouthLargeBG" d="M100 110.2c-9 0-16.2-7.3-16.2-16.2 0-2.3 1.9-4.2 4.2-4.2h24c2.3 0 4.2 1.9 4.2 4.2 0 9-7.2 16.2-16.2 16.2z" fill="#617e92" stroke="#3a5e77" stroke-linejoin="round" stroke-width="2.5"/>
                                    <defs>
                                    <path id="mouthMaskPath" d="M100.2,101c-0.4,0-1.4,0-1.8,0c-2.7-0.3-5.3-1.1-8-2.5c-0.7-0.3-0.9-1.2-0.6-1.8 c0.2-0.5,0.7-0.7,1.2-0.7c0.2,0,0.5,0.1,0.6,0.2c3,1.5,5.8,2.3,8.6,2.3s5.7-0.7,8.6-2.3c0.2-0.1,0.4-0.2,0.6-0.2 c0.5,0,1,0.3,1.2,0.7c0.4,0.7,0.1,1.5-0.6,1.9c-2.6,1.4-5.3,2.2-7.9,2.5C101.7,101,100.5,101,100.2,101z"/>
                                    </defs>
                                    <clipPath id="mouthMask">
                                        <use xlink:href="#mouthMaskPath" overflow="visible"/>
                                    </clipPath>
                                    <g clip-path="url(#mouthMask)">
                                    <g class="tongue">
                                    <circle cx="100" cy="107" r="8" fill="#cc4a6c"/>
                                    <ellipse class="tongueHighlight" cx="100" cy="100.5" rx="3" ry="1.5" opacity=".1" fill="#fff"/>
                                    </g>
                                    </g>
                                    <path clip-path="url(#mouthMask)" class="tooth" style="fill:#FFFFFF;" d="M106,97h-4c-1.1,0-2-0.9-2-2v-2h8v2C108,96.1,107.1,97,106,97z"/>
                                    <path class="mouthOutline" fill="none" stroke="#3A5E77" stroke-width="2.5" stroke-linejoin="round" d="M100.2,101c-0.4,0-1.4,0-1.8,0c-2.7-0.3-5.3-1.1-8-2.5c-0.7-0.3-0.9-1.2-0.6-1.8 c0.2-0.5,0.7-0.7,1.2-0.7c0.2,0,0.5,0.1,0.6,0.2c3,1.5,5.8,2.3,8.6,2.3s5.7-0.7,8.6-2.3c0.2-0.1,0.4-0.2,0.6-0.2 c0.5,0,1,0.3,1.2,0.7c0.4,0.7,0.1,1.5-0.6,1.9c-2.6,1.4-5.3,2.2-7.9,2.5C101.7,101,100.5,101,100.2,101z"/>
                                    </g>
                                    <path class="nose" d="M97.7 79.9h4.7c1.9 0 3 2.2 1.9 3.7l-2.3 3.3c-.9 1.3-2.9 1.3-3.8 0l-2.3-3.3c-1.3-1.6-.2-3.7 1.8-3.7z" fill="#3a5e77"/>
                                    <g class="arms" clip-path="url(#armMask)">
                                    <g class="armL">
                                    <path fill="#ddf1fa" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2.5" d="M121.3 97.4L111 58.7l38.8-10.4 20 36.1z"/>
                                    <path fill="#ddf1fa" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2.5" d="M134.4 52.5l19.3-5.2c2.7-.7 5.4.9 6.1 3.5.7 2.7-.9 5.4-3.5 6.1L146 59.7M160.8 76.5l19.4-5.2c2.7-.7 5.4.9 6.1 3.5.7 2.7-.9 5.4-3.5 6.1l-18.3 4.9M158.3 66.8l23.1-6.2c2.7-.7 5.4.9 6.1 3.5.7 2.7-.9 5.4-3.5 6.1l-23.1 6.2M150.9 58.4l26-7c2.7-.7 5.4.9 6.1 3.5.7 2.7-.9 5.4-3.5 6.1l-21.3 5.7"/>
                                    <path fill="#a9ddf3" d="M178.8 74.7l2.2-.6c1.1-.3 2.2.3 2.4 1.4.3 1.1-.3 2.2-1.4 2.4l-2.2.6-1-3.8zM180.1 64l2.2-.6c1.1-.3 2.2.3 2.4 1.4.3 1.1-.3 2.2-1.4 2.4l-2.2.6-1-3.8zM175.5 54.9l2.2-.6c1.1-.3 2.2.3 2.4 1.4.3 1.1-.3 2.2-1.4 2.4l-2.2.6-1-3.8zM152.1 49.4l2.2-.6c1.1-.3 2.2.3 2.4 1.4.3 1.1-.3 2.2-1.4 2.4l-2.2.6-1-3.8z"/>
                                    <path fill="#fff" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M123.5 96.8c-41.4 14.9-84.1 30.7-108.2 35.5L1.2 80c33.5-9.9 71.9-16.5 111.9-21.8"/>
                                    <path fill="#fff" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M108.5 59.4c7.7-5.3 14.3-8.4 22.8-13.2-2.4 5.3-4.7 10.3-6.7 15.1 4.3.3 8.4.7 12.3 1.3-4.2 5-8.1 9.6-11.5 13.9 3.1 1.1 6 2.4 8.7 3.8-1.4 2.9-2.7 5.8-3.9 8.5 2.5 3.5 4.6 7.2 6.3 11-4.9-.8-9-.7-16.2-2.7M94.5 102.8c-.6 4-3.8 8.9-9.4 14.7-2.6-1.8-5-3.7-7.2-5.7-2.5 4.1-6.6 8.8-12.2 14-1.9-2.2-3.4-4.5-4.5-6.9-4.4 3.3-9.5 6.9-15.4 10.8-.2-3.4.1-7.1 1.1-10.9M97.5 62.9c-1.7-2.4-5.9-4.1-12.4-5.2-.9 2.2-1.8 4.3-2.5 6.5-3.8-1.8-9.4-3.1-17-3.8.5 2.3 1.2 4.5 1.9 6.8-5-.6-11.2-.9-18.4-1 2 2.9.9 3.5 3.9 6.2"/>
                                    </g>
                                    <g class="armR">
                                    <path fill="#ddf1fa" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2.5" d="M265.4 97.3l10.4-38.6-38.9-10.5-20 36.1z"/>
                                    <path fill="#ddf1fa" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2.5" d="M252.4 52.4L233 47.2c-2.7-.7-5.4.9-6.1 3.5-.7 2.7.9 5.4 3.5 6.1l10.3 2.8M226 76.4l-19.4-5.2c-2.7-.7-5.4.9-6.1 3.5-.7 2.7.9 5.4 3.5 6.1l18.3 4.9M228.4 66.7l-23.1-6.2c-2.7-.7-5.4.9-6.1 3.5-.7 2.7.9 5.4 3.5 6.1l23.1 6.2M235.8 58.3l-26-7c-2.7-.7-5.4.9-6.1 3.5-.7 2.7.9 5.4 3.5 6.1l21.3 5.7"/>
                                    <path fill="#a9ddf3" d="M207.9 74.7l-2.2-.6c-1.1-.3-2.2.3-2.4 1.4-.3 1.1.3 2.2 1.4 2.4l2.2.6 1-3.8zM206.7 64l-2.2-.6c-1.1-.3-2.2.3-2.4 1.4-.3 1.1.3 2.2-1.4 2.4l-2.2.6 1-3.8zM211.2 54.8l-2.2-.6c-1.1-.3-2.2.3-2.4 1.4-.3 1.1.3 2.2-1.4 2.4l-2.2.6 1-3.8zM234.6 49.4l-2.2-.6c-1.1-.3-2.2.3-2.4 1.4-.3 1.1.3 2.2-1.4 2.4l2.2.6 1-3.8z"/>
                                    <path fill="#fff" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M263.3 96.7c41.4 14.9 84.1 30.7 108.2 35.5l14-52.3C352 70 313.6 63.5 273.6 58.1"/>
                                    <path fill="#fff" stroke="#3a5e77" stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M278.2 59.3l-18.6-10 2.5 11.9-10.7 6.5 9.9 8.7-13.9 6.4 9.1 5.9-13.2 9.2 23.1-.9M284.5 100.1c-.4 4 1.8 8.9 6.7 14.8 3.5-1.8 6.7-3.6 9.7-5.5 1.8 4.2 5.1 8.9 10.1 14.1 2.7-2.1 5.1-4.4 7.1-6.8 4.1 3.4 9 7 14.7 11 1.2-3.4 1.8-7 1.7-10.9M314 66.7s5.4-5.7 12.6-7.4c1.7 2.9 3.3 5.7 4.9 8.6 3.8-2.5 9.8-4.4 18.2-5.7.1 3.1.1 6.1 0 9.2 5.5-1 12.5-1.6 20.8-1.9-1.4 3.9-2.5 8.4-2.5 8.4"/>
                                    </g>
                                    </g>
                                    </svg>
                                </div>
                            </div>

                            <div class="inputGroup inputGroup1">
                                <label class="form-label" for="email">Email</label> <%-- Changed label --%>
                                <input type="email" id="email" class="email form-control" maxlength="256" name="email" required>
                                <p class="helper helper1">email@domain.com</p>
                                <span class="indicator"></span>
                            </div>
                            <div class="inputGroup inputGroup2">
                                <label class="form-label" for="password">Password</label> <%-- Changed label --%>
                                <input type="password" id="password" class="password form-control" name="password" required/>
                            </div>
                            <div class="inputGroup inputGroup2"> <%-- Added Confirm Password field --%>
                                <label class="form-label" for="confirmPassword">Confirm Password</label>
                                <input type="password" id="confirmPassword" class="password form-control" name="confirmPassword" required/>
                            </div>
                                <div class="inputGroup">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" required />
                            </div>

                            <div class="inputGroup">
                                <label for="phone_number" class="form-label">Phone Number</label>
                                <input type="text" name="phone_number" class="form-control" required />
                            </div>

                            <div class="inputGroup">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" name="address" class="form-control" required />
                            </div>
                            <div class="inputGroup inputGroup3">
                                <button id="login" type="submit" class="btn btn-primary w-100">Register</button> <%-- Changed button text to "Register" --%>
                            </div>
                            <div class="text-center mt-3">
                                <a href="/MotoVibe/login.jsp">Already have an account? Log in</a> <%-- Changed link to "Already have an account? Log in" --%>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/plugins/MorphSVGPlugin.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Javascript code from login.jsp (no changes needed for register.jsp)
            var email = document.querySelector('#email'), password = document.querySelector('#password'), mySVG = document.querySelector('.svgContainer'), armL = document.querySelector('.armL'), armR = document.querySelector('.armR'), eyeL = document.querySelector('.eyeL'), eyeR = document.querySelector('.eyeR'), nose = document.querySelector('.nose'), mouth = document.querySelector('.mouth'), mouthBG = document.querySelector('.mouthBG'), mouthSmallBG = document.querySelector('.mouthSmallBG'), mouthMediumBG = document.querySelector('.mouthMediumBG'), mouthLargeBG = document.querySelector('.mouthLargeBG'), mouthMaskPath = document.querySelector('#mouthMaskPath'), mouthOutline = document.querySelector('.mouthOutline'), tooth = document.querySelector('.tooth'), tongue = document.querySelector('.tongue'), chin = document.querySelector('.chin'), face = document.querySelector('.face'), eyebrow = document.querySelector('.eyebrow'), outerEarL = document.querySelector('.earL .outerEar'), outerEarR = document.querySelector('.earR .outerEar'), earHairL = document.querySelector('.earL .earHair'), earHairR = document.querySelector('.earR .earHair'), hair = document.querySelector('.hair');
            var caretPos, curEmailIndex, screenCenter, svgCoords, eyeMaxHorizD = 20, eyeMaxVertD = 10, noseMaxHorizD = 23, noseMaxVertD = 10, dFromC, eyeDistH, eyeLDistV, eyeRDistV, eyeDistR, mouthStatus = "small";
            function getCoord(e) {
            var carPos = email.selectionEnd,
                    div = document.createElement('div'),
                    span = document.createElement('span'),
                    copyStyle = getComputedStyle(email),
                    emailCoords = {}, caretCoords = {}, centerCoords = {}
            ;
            [].forEach.call(copyStyle, function (prop) {
            div.style[prop] = copyStyle[prop];
            });
            div.style.position = 'absolute';
            document.body.appendChild(div);
            div.textContent = email.value.substr(0, carPos);
            span.textContent = email.value.substr(carPos) || '.';
            div.appendChild(span);
            emailCoords = getPosition(email); //console.log("emailCoords.x: " + emailCoords.x + ", emailCoords.y: " + emailCoords.y);
            caretCoords = getPosition(span); //console.log("caretCoords.x " + caretCoords.x + ", caretCoords.y: " + caretCoords.y);
            centerCoords = getPosition(mySVG); //console.log("centerCoords.x: " + centerCoords.x);
            svgCoords = getPosition(mySVG);
            screenCenter = centerCoords.x + (mySVG.offsetWidth / 2); //console.log("screenCenter: " + screenCenter);
            caretPos = caretCoords.x + emailCoords.x; //console.log("caretPos: " + caretPos);

            dFromC = screenCenter - caretPos; //console.log("dFromC: " + dFromC);
            var pFromC = Math.round((caretPos / screenCenter) * 100) / 100;
            if (pFromC < 1) {

            } else if (pFromC > 1) {
            pFromC -= 2;
            pFromC = Math.abs(pFromC);
            }

            eyeDistH = - dFromC * .05;
            if (eyeDistH > eyeMaxHorizD) {
            eyeDistH = eyeMaxHorizD;
            } else if (eyeDistH < - eyeMaxHorizD) {
            eyeDistH = - eyeMaxHorizD;
            }

            var eyeLCoords = {x: svgCoords.x + 84, y: svgCoords.y + 76};
            var eyeRCoords = {x: svgCoords.x + 113, y: svgCoords.y + 76};
            var noseCoords = {x: svgCoords.x + 97, y: svgCoords.y + 81};
            var mouthCoords = {x: svgCoords.x + 100, y: svgCoords.y + 100};
            var eyeLAngle = getAngle(eyeLCoords.x, eyeLCoords.y, emailCoords.x + caretCoords.x, emailCoords.y + 25);
            var eyeLX = Math.cos(eyeLAngle) * eyeMaxHorizD;
            var eyeLY = Math.sin(eyeLAngle) * eyeMaxVertD;
            var eyeRAngle = getAngle(eyeRCoords.x, eyeRCoords.y, emailCoords.x + caretCoords.x, emailCoords.y + 25);
            var eyeRX = Math.cos(eyeRAngle) * eyeMaxHorizD;
            var eyeRY = Math.sin(eyeRAngle) * eyeMaxVertD;
            var noseAngle = getAngle(noseCoords.x, noseCoords.y, emailCoords.x + caretCoords.x, emailCoords.y + 25);
            var noseX = Math.cos(noseAngle) * noseMaxHorizD;
            var noseY = Math.sin(noseAngle) * noseMaxVertD;
            var mouthAngle = getAngle(mouthCoords.x, mouthCoords.y, emailCoords.x + caretCoords.x, emailCoords.y + 25);
            var mouthX = Math.cos(mouthAngle) * noseMaxHorizD;
            var mouthY = Math.sin(mouthAngle) * noseMaxVertD;
            var mouthR = Math.cos(mouthAngle) * 6;
            var chinX = mouthX * .8;
            var chinY = mouthY * .5;
            var chinS = 1 - ((dFromC * .15) / 100);
            if (chinS > 1) {
            chinS = 1 - (chinS - 1);
            }
            var faceX = mouthX * .3;
            var faceY = mouthY * .4;
            var faceSkew = Math.cos(mouthAngle) * 5;
            var eyebrowSkew = Math.cos(mouthAngle) * 25;
            var outerEarX = Math.cos(mouthAngle) * 4;
            var outerEarY = Math.cos(mouthAngle) * 5;
            var hairX = Math.cos(mouthAngle) * 6;
            var hairS = 1.2;
            TweenMax.to(eyeL, 1, {x: - eyeLX, y: - eyeLY, ease: Expo.easeOut});
            TweenMax.to(eyeR, 1, {x: - eyeRX, y: - eyeRY, ease: Expo.easeOut});
            TweenMax.to(nose, 1, {x: - noseX, y: - noseY, rotation: mouthR, transformOrigin: "center center", ease: Expo.easeOut});
            TweenMax.to(mouth, 1, {x: - mouthX, y: - mouthY, rotation: mouthR, transformOrigin: "center center", ease: Expo.easeOut});
            TweenMax.to(chin, 1, {x: - chinX, y: - chinY, scaleY: chinS, ease: Expo.easeOut});
            TweenMax.to(face, 1, {x: - faceX, y: - faceY, skewX: - faceSkew, transformOrigin: "center top", ease: Expo.easeOut});
            TweenMax.to(eyebrow, 1, {x: - faceX, y: - faceY, skewX: - eyebrowSkew, transformOrigin: "center top", ease: Expo.easeOut});
            TweenMax.to(outerEarL, 1, {x: outerEarX, y: - outerEarY, ease: Expo.easeOut});
            TweenMax.to(outerEarR, 1, {x: outerEarX, y: outerEarY, ease: Expo.easeOut});
            TweenMax.to(earHairL, 1, {x: - outerEarX, y: - outerEarY, ease: Expo.easeOut});
            TweenMax.to(earHairR, 1, {x: - outerEarX, y: outerEarY, ease: Expo.easeOut});
            TweenMax.to(hair, 1, {x: hairX, scaleY: hairS, transformOrigin: "center bottom", ease: Expo.easeOut});
            document.body.removeChild(div);
            }
            ;
            function onEmailInput(e) {
            getCoord(e);
            var value = e.target.value;
            curEmailIndex = value.length;
            // very crude email validation for now to trigger effects
            if (curEmailIndex > 0) {
            if (mouthStatus == "small") {
            mouthStatus = "medium";
            TweenMax.to([mouthBG, mouthOutline, mouthMaskPath], 1, {morphSVG: mouthMediumBG, shapeIndex: 8, ease: Expo.easeOut});
            TweenMax.to(tooth, 1, {x: 0, y: 0, ease: Expo.easeOut});
            TweenMax.to(tongue, 1, {x: 0, y: 1, ease: Expo.easeOut});
            TweenMax.to([eyeL, eyeR], 1, {scaleX: .85, scaleY: .85, ease: Expo.easeOut});
            }
            if (value.includes("@")) {
            mouthStatus = "large";
            TweenMax.to([mouthBG, mouthOutline, mouthMaskPath], 1, {morphSVG: mouthLargeBG, ease: Expo.easeOut});
            TweenMax.to(tooth, 1, {x: 3, y: - 2, ease: Expo.easeOut});
            TweenMax.to(tongue, 1, {y: 2, ease: Expo.easeOut});
            TweenMax.to([eyeL, eyeR], 1, {scaleX: .65, scaleY: .65, ease: Expo.easeOut, transformOrigin: "center center"});
            } else {
            mouthStatus = "medium";
            TweenMax.to([mouthBG, mouthOutline, mouthMaskPath], 1, {morphSVG: mouthMediumBG, ease: Expo.easeOut});
            TweenMax.to(tooth, 1, {x: 0, y: 0, ease: Expo.easeOut});
            TweenMax.to(tongue, 1, {x: 0, y: 1, ease: Expo.easeOut});
            TweenMax.to([eyeL, eyeR], 1, {scaleX: .85, scaleY: .85, ease: Expo.easeOut});
            }
            } else {
            mouthStatus = "small";
            TweenMax.to([mouthBG, mouthOutline, mouthMaskPath], 1, {morphSVG: mouthSmallBG, shapeIndex: 9, ease: Expo.easeOut});
            TweenMax.to(tooth, 1, {x: 0, y: 0, ease: Expo.easeOut});
            TweenMax.to(tongue, 1, {y: 0, ease: Expo.easeOut});
            TweenMax.to([eyeL, eyeR], 1, {scaleX: 1, scaleY: 1, ease: Expo.easeOut});
            }
            }

            function onEmailFocus(e) {
            e.target.parentElement.classList.add("focusWithText");
            getCoord();
            }

            function onEmailBlur(e) {
            if (e.target.value == "") {
            e.target.parentElement.classList.remove("focusWithText");
            }
            resetFace();
            }

            function onPasswordFocus(e) {
            coverEyes();
            }

            function onPasswordBlur(e) {
            uncoverEyes();
            }

            function coverEyes() {
            TweenMax.to(armL, .45, {x: - 93, y: 2, rotation: 0, ease: Quad.easeOut});
            TweenMax.to(armR, .45, {x: - 93, y: 2, rotation: 0, ease: Quad.easeOut, delay: .1});
            }

            function uncoverEyes() {
            TweenMax.to(armL, 1.35, {y: 220, ease: Quad.easeOut});
            TweenMax.to(armL, 1.35, {rotation: 105, ease: Quad.easeOut, delay: .1});
            TweenMax.to(armR, 1.35, {y: 220, ease: Quad.easeOut});
            TweenMax.to(armR, 1.35, {rotation: - 105, ease: Quad.easeOut, delay: .1});
            }

            function resetFace() {
            TweenMax.to([eyeL, eyeR], 1, {x: 0, y: 0, ease: Expo.easeOut});
            TweenMax.to(nose, 1, {x: 0, y: 0, scaleX: 1, scaleY: 1, ease: Expo.easeOut});
            TweenMax.to(mouth, 1, {x: 0, y: 0, rotation: 0, ease: Expo.easeOut});
            TweenMax.to(chin, 1, {x: 0, y: 0, scaleY: 1, ease: Expo.easeOut});
            TweenMax.to([face, eyebrow], 1, {x: 0, y: 0, skewX: 0, ease: Expo.easeOut});
            TweenMax.to([outerEarL, outerEarR, earHairL, earHairR, hair], 1, {x: 0, y: 0, scaleY: 1, ease: Expo.easeOut});
            }

            function getAngle(x1, y1, x2, y2) {
            var angle = Math.atan2(y1 - y2, x1 - x2);
            return angle;
            }

            function getPosition(el) {
            var xPos = 0;
            var yPos = 0;
            while (el) {
            if (el.tagName == "BODY") {
            // deal with browser quirks with body/window/document and page scroll
            var xScroll = el.scrollLeft || document.documentElement.scrollLeft;
            var yScroll = el.scrollTop || document.documentElement.scrollTop;
            xPos += (el.offsetLeft - xScroll + el.clientLeft);
            yPos += (el.offsetTop - yScroll + el.clientTop);
            } else {
            // for all other non-BODY elements
            xPos += (el.offsetLeft - el.scrollLeft + el.clientLeft);
            yPos += (el.offsetTop - el.scrollTop + el.clientTop);
            }

            el = el.offsetParent;
            }
            return {
            x: xPos,
                    y: yPos
            };
            }

            email.addEventListener('focus', onEmailFocus);
            email.addEventListener('blur', onEmailBlur);
            email.addEventListener('input', onEmailInput);
            password.addEventListener('focus', onPasswordFocus);
            password.addEventListener('blur', onPasswordBlur);
            TweenMax.set(armL, {x: - 93, y: 220, rotation: 105, transformOrigin: "top left"});
            TweenMax.set(armR, {x: - 93, y: 220, rotation: - 105, transformOrigin: "top right"});
        </script>
    </body>
</html>