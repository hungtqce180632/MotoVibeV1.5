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
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Change Quantity</h2>

            <div class="card mx-auto" style="max-width: 600px;">
                <div class="card-body">
                    <h4 class="card-title text-center">${motor.motorName}</h4>
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
                            <select name="action" class="form-control">
                                <option value="increase">Increase</option>
                                <option value="decrease">Decrease</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Note</label>
                            <textarea name="note" class="form-control" required></textarea>
                        </div>

                        <button type="submit" class="btn btn-success">Save</button>
                        <a href="motorManagement" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
