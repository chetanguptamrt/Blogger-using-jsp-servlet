/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#loginForm").on("submit", function(event){
        event.preventDefault();
        var f = $(this).serialize();
        $.ajax({
            url: "UserLoginServlet",
            data: f,
            method: "post",
            success: function(data) {
                if(data.trim()==="done"){
                    location.href = "home.jsp";
                } else{
                    $("#status").show();
                    $("#status").html("Invalid email or password!");
                }
            },
            error: function(){
                $("#status").show();
                $("#status").html("Something went wrong!");
            }
        });
    });
});
