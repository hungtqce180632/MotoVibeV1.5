<%-- 
    Document   : add_motor
    Created on : Feb 21, 2025
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Add New Motorbike</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 1.5rem;
                position: relative;
            }
            
            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
                letter-spacing: 1px;
            }
            
            .form-control, .form-select {
                background-color: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                color: white;
            }
            
            .form-control:focus, .form-select:focus {
                background-color: var(--rich-black);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
                color: white;
            }
            
            form {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                padding: 2rem;
                border-radius: 10px;
                border: 1px solid var(--primary-gold);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 800px;
                margin: 0 auto;
            }
            
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
            }
            
            .btn-secondary:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            
            #imagePreview {
                border: 2px solid var(--primary-gold);
                border-radius: 5px;
                max-height: 250px;
            }
            
            /* Decoration elements */
            .luxury-icon {
                position: absolute;
                top: 20px;
                right: 20px;
                font-size: 60px;
                opacity: 0.1;
                color: var(--primary-gold);
            }
            
            .form-container {
                position: relative;
            }
            
            .container {
                padding-top: 80px; /* Account for fixed header */
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container mt-5">
            <div class="form-container">
                <h2 class="text-center mb-4"><i class="fas fa-motorcycle me-2"></i>Add New Motorbike</h2>
                <i class="fas fa-cog luxury-icon"></i>
                
                <form action="addMotor" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Motor Name</label>
                        <input type="text" class="form-control" name="motorName" required>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label">Brand</label>
                            <select class="form-select" name="brandId" required>
                                <c:forEach var="brand" items="${brands}">
                                    <option value="${brand.brandId}">${brand.brandName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Model</label>
                            <select class="form-select" name="modelId" required>
                                <c:forEach var="model" items="${models}">
                                    <option value="${model.modelId}">${model.modelName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Fuel Type</label>
                            <select class="form-select" name="fuelId" required>
                                <c:forEach var="fuel" items="${fuels}">
                                    <option value="${fuel.fuelId}">${fuel.fuelName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Color</label>
                            <input type="text" class="form-control" name="color" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Price</label>
                            <div class="input-group">
                                <span class="input-group-text" style="background-color: var(--rich-black); color: var(--primary-gold); border-color: var(--secondary-gold);">$</span>
                                <input type="number" step="0.01" class="form-control" name="price" required>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="3" required></textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Upload Picture</label>
                        <input type="file" class="form-control" name="picture" accept="image/*" required onchange="previewImage(event)">
                        <div class="text-center mt-3">
                            <img id="imagePreview" class="mt-2" style="max-width: 100%; display: none;"/>
                        </div>
                    </div>

                    <div class="text-center">
                        <a href="motorManagement" class="btn btn-secondary me-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Add Motorbike
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function previewImage(event) {
                const imagePreview = document.getElementById('imagePreview');
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        imagePreview.src = e.target.result;
                        imagePreview.style.display = 'block';
                    }
                    reader.readAsDataURL(file);
                } else {
                    imagePreview.style.display = 'none';
                }
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
