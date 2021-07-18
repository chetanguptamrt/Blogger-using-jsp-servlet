/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
    $("#createBlog").on("submit",function(event){
        event.preventDefault();
        var f = $(this).serialize();
        $.ajax({
            url: "./EditBlogServlet",
            type: "POST",
            data: f,
            success: function(data){
                console.log(data);
                if(data.trim()==="done"){
                    $("#status").show();
                    $("#status").removeClass("text-danger");
                    $("#status").addClass("text-success");
                    $("#status").html("Blog successfully update.");
                } else{
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
                $("#status").html("Something went wrong, please try again later!");
            }
        });
    });
});
