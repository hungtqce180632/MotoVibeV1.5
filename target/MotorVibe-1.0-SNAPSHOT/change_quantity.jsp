<%-- 
    Document   : change_quantity
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
        <title>Change Quantity</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                text-align: center;
                margin-bottom: 1.5rem;
            }
            
            .card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }
            
            .card-title {
                color: var(--primary-gold);
                font-weight: 600;
            }
            
            .text-muted {
                color: var(--text-gold) !important;
                opacity: 0.7;
            }
            
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
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
            
            .btn-success {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                transition: all 0.3s ease;
            }
            
            .btn-success:hover {
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
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4"><i class="fas fa-boxes me-2"></i>Change Quantity</h2>

            <div class="card mx-auto" style="max-width: 600px;">
                <div class="card-body">
                    <h4 class="card-title text-center mb-3">${motor.motorName}</h4>
                    <p class="text-muted text-center">Motor ID: <strong>${motor.motorId}</strong></p>
                    <p class="text-muted text-center">Current Quantity: <strong>${motor.quantity}</strong></p>

                    <form action="changeQuantity" method="post">
                        <input type="hidden" name="motorId" value="${motor.motorId}">

                        <div class="mb-3">
                            <label class="form-label">Quantity Change</label>
                            <input type="number" name="changeAmount" class="form-control" required min="1">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Action</label>
                            <select name="action" class="form-control form-select">
                                <option value="increase">Increase</option>
                                <option value="decrease">Decrease</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Note</label>
                            <textarea name="note" class="form-control" rows="3" required></textarea>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <a href="motorManagement" class="btn btn-secondary me-2">
                                <i class="fas fa-times me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-1"></i> Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a611f8fd5b.js" crossorigin="anonymous"></script>
        <script>
            // Add validation to prevent decreasing more than current quantity
            document.querySelector('form').addEventListener('submit', function(event) {
                const action = document.querySelector('select[name="action"]').value;
                const amount = parseInt(document.querySelector('input[name="changeAmount"]').value);
                const currentQuantity = ${motor.quantity};
                
                if (action === 'decrease' && amount > currentQuantity) {
                    event.preventDefault();
                    alert('Cannot decrease more than the current quantity');
                }
            });
        </script>
    </body>
</html>
