<%-- 
    Document   : create_warranty
    Created on : Feb 23, 2025, 12:31:34 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Warranty - MotoVibe</title>
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
                left: 0;
                width: 80px;
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
            
            .warranty-card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }
            
            .gold-accent {
                color: var(--primary-gold);
            }
            
            /* Added decoration elements */
            .luxury-icon {
                position: absolute;
                top: 20px;
                right: 20px;
                font-size: 60px;
                opacity: 0.1;
                color: var(--primary-gold);
            }

            .warranty-form {
                background: var(--rich-black);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                max-width: 600px;
            }
            .btn-warranty {
                background: var(--primary-gold);
                border: none;
                color: var(--dark-black);
                margin-top: 1rem;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container mt-5">
            <h2><i class="fas fa-shield-alt gold-accent me-2"></i> Create Warranty</h2>
            
            <div class="warranty-card position-relative">
                <i class="fas fa-certificate luxury-icon"></i>
                <form action="createWarranty" method="post">
                    <div class="mb-3">
                        <label for="orderId" class="form-label">Order</label>
                        <select class="form-select" id="orderId" name="orderId" required>
                            <option value="" selected disabled>-- Select Order --</option>
                            <c:forEach var="order" items="${orders}">
                                <option value="${order.orderId}">Order #${order.orderId} - ${order.motorName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="startDate" class="form-label">Start Date</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                        </div>
                        
                        <div class="col-md-6">
                            <label for="endDate" class="form-label">End Date</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="warrantyType" class="form-label">Warranty Type</label>
                        <select class="form-select" id="warrantyType" name="warrantyType" required>
                            <option value="" selected disabled>-- Select Warranty Type --</option>
                            <option value="Standard">Standard Coverage (1 year)</option>
                            <option value="Extended">Extended Coverage (2 years)</option>
                            <option value="Premium">Premium Coverage (3 years)</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="warrantyTerms" class="form-label">Warranty Terms</label>
                        <textarea class="form-control" id="warrantyTerms" name="warrantyTerms" rows="4" required></textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="note" class="form-label">Additional Notes</label>
                        <textarea class="form-control" id="note" name="note" rows="3"></textarea>
                    </div>
                    
                    <div class="text-end mt-4">
                        <a href="warrantyManagement" class="btn btn-secondary me-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Create Warranty
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"></jsp:include>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a611f8fd5b.js" crossorigin="anonymous"></script>
        <script>
            // Auto-calculate end date based on warranty type selection
            document.getElementById('warrantyType').addEventListener('change', function() {
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                
                if (!startDateInput.value) return;
                
                const startDate = new Date(startDateInput.value);
                let endDate = new Date(startDate);
                
                switch(this.value) {
                    case 'Standard':
                        endDate.setFullYear(endDate.getFullYear() + 1); // 1 year
                        break;
                    case 'Extended':
                        endDate.setFullYear(endDate.getFullYear() + 2); // 2 years
                        break;
                    case 'Premium':
                        endDate.setFullYear(endDate.getFullYear() + 3); // 3 years
                        break;
                }
                
                endDateInput.value = endDate.toISOString().split('T')[0];
            });
            
            // Update end date when start date changes
            document.getElementById('startDate').addEventListener('change', function() {
                const warrantyType = document.getElementById('warrantyType');
                if (warrantyType.value) {
                    // Trigger the warranty type change event
                    const event = new Event('change');
                    warrantyType.dispatchEvent(event);
                }
            });
        </script>
    </body>
</html>
