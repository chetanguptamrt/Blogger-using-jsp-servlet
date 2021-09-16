/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#otpForm").on("submit", function(event){
        event.preventDefault();
        var f = $(this).serialize();
        $.ajax({
            url: "UserRegistrationOTPServlet",
            data: f,
            method: "post",
            success: function(data) {
                if(data.trim()==="done"){
                    $("#status").show();
                    $("#status").removeClass("text-danger");
                    $("#status").addClass("text-success");
                    $("#status").html("Send OTP on email");
                    $("#bOTP").attr("disabled","");
                    $("#bSave").removeAttr("disabled");
                    $("#rEmail").val($("#email").val());
                    $("#email").attr("disabled","");
                } else if(data.trim()==="already") {
                    $("#status").show();
                    $("#status").removeClass("text-success");
                    $("#status").addClass("text-danger");
                    $("#status").html("Email already exist!");
                } else {
                    $("#status").show();
                    $("#status").removeClass("text-success");
                    $("#status").addClass("text-danger");
                    $("#status").html("Something went wrong!");
                }
            },
            error: function(){
                $("#status").show();
                $("#status").removeClass("text-success");
                $("#status").addClass("text-danger");
                $("#status").html("Something went wrong!");
            }
        });
    });
    $("#registerForm").on("submit", function(event) {
        event.preventDefault();
        var f = $(this).serialize();
        $.ajax({
            url: "UserRegistrationSaveServlet",
            data: f,
            method: "post",
            success: function(data) {
                if(data.trim()==="done") {
                    location.href="./login.jsp";
                } else if(data.trim()==="invalid") {
                    $("#status").show();
                    $("#status").removeClass("text-success");
                    $("#status").addClass("text-danger");
                    $("#status").html("OTP doesn't matched!");
                } else {
                    $("#status").show();
                    $("#status").removeClass("text-success");
                    $("#status").addClass("text-danger");
                    $("#status").html("Something went wrong!");
                }
            },
            error: function(){
                $("#status").show();
                $("#status").removeClass("text-success");
                $("#status").addClass("text-danger");
                $("#status").html("Something went wrong!");
            }
        });
    });
});
