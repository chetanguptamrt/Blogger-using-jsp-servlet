/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#updateName").on("submit",function(event){
        event.preventDefault();
        var f = $(this).serialize();
        $.ajax({
            url : "./ProfileNameUpdateServlet",
            method: "get",
            data: f,
            success: function(data){
                if(data.trim()==="done"){
                    location.reload();
                } else{
                    alert("Something went wrong!");
                }
            },
            error: function(){
                alert("Something went wrong!");
            }
        });
    });
    
    $("#changePassword").on("submit",function(event){
        event.preventDefault();
        if($("#nPassword").val()===$("#cPassword").val() & $("#nPassword").val().trim()!=="") {
            var f = $(this).serialize();
            $.ajax({
                url: "ProfileChangePasswordServlet",
                data: f,
                method: "post",
                success: function(data){
                    if(data.trim()==="done") {
                        $("#status").show();
                        $("#status").removeClass("text-danger");
                        $("#status").addClass("text-success");
                        $("#status").html("Change Password Successfully");
                        $("#nPassword").val("");
                        $("#oPassword").val("");
                        $("#cPassword").val("");
                    } else if(data.trim()==="invalid") {
                        $("#status").show();
                        $("#status").removeClass("text-success");
                        $("#status").addClass("text-danger");
                        $("#status").html("Old Password not Matched!");
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
        } else{
            $("#status").show();
            $("#status").removeClass("text-success");
            $("#status").addClass("text-danger");
            $("#status").html("New Password and Confirm Password are not Matched!");
        }
    });
    
    $("#deleteButton").click(function(){
        if(confirm("Do you want to delete your account?")){
            $.ajax({
               url: "ProfileDeleteAccountServlet",
               method: "post",
               success: function(data){
                   if(data.trim()==="done"){
                       location.href = "./login.jsp";
                   } else{
                       alert("Something went wrong!");
                   }
               },
               error: function(){
                    alert("Something went wrong!");
               }
            });
        }
    });
});
