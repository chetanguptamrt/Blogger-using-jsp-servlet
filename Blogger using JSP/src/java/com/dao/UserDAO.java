/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.detail.UserDetail;
import com.javaclass.Email;
import com.javaclass.PasswordEncrypt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author chetan
 */
public class UserDAO {
    
    private final Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }
    
    public String sendRegistrationOTP(String email){
        try{
            String query1 = "select * from user where email = ?";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setString(1, email);
            ResultSet rs = pt1.executeQuery();
            if(rs.next()){
                return "already";
            } else{
                String query2 = "delete from userverification where email = ?";
                PreparedStatement pt2 = conn.prepareStatement(query2);
                pt2.setString(1, email);
                pt2.executeUpdate();
                int otp = getOTP();
                String query3 = "insert into userverification (email,otp) values(?,?)";
                PreparedStatement pt3 = conn.prepareStatement(query3);
                pt3.setString(1, email);
                pt3.setInt(2, otp);
                int i = pt3.executeUpdate();
                if(i==1){
                    String subject = "OTP Verification";
                    String body = "Hii,\n\n"
                                + "Your verification code is "+otp+"\n\n"
                                + "If you are having any issue with your account, please don't hesitate to contact us.\n\n"
                                + "Thanks!\n"
                                + "Blog India";
                    Thread td = new Thread(new Email(email, subject, body));
                    td.start();
                    return "done";
                }
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return "no";
    }
    
    public String insertUserRegistration(UserDetail ud, int otp) {
        try {
            String query4 = "select * from user where email = ?";
            PreparedStatement pt4 = conn.prepareStatement(query4);
            pt4.setString(1, ud.getEmail());
            ResultSet rs4 = pt4.executeQuery();
            if(rs4.next()){
                return "no";
            } else {
                String query1 = "select * from userverification where email = ? and otp = ?";
                PreparedStatement pt1 = conn.prepareStatement(query1);
                pt1.setString(1, ud.getEmail());
                pt1.setInt(2, otp);
                ResultSet rs1 = pt1.executeQuery();
                if(rs1.next()){
                    String query3 = "delete from userverification where email = ?";
                    PreparedStatement pt3 = conn.prepareStatement(query3);
                    pt3.setString(1, ud.getEmail());
                    pt3.executeUpdate();
                    String ePassword = PasswordEncrypt.hashPassword(ud.getPassword());
                    String query2 = "insert into user (name, email, password) values(?,?,?)";
                    PreparedStatement pt2 = conn.prepareStatement(query2);
                    pt2.setString(1, ud.getName());
                    pt2.setString(2, ud.getEmail());
                    pt2.setString(3, ePassword);
                    int i = pt2.executeUpdate();
                    if(i==1){
                        return "done";
                    }
                } else {
                    return "invalid";
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "no";
    }
    
    private int getOTP(){
       return (int)(Math.random()*(999999-111111+1)+111111);
    }
    
    public UserDetail userLogin(UserDetail ud){
        try{
            String ePassword = PasswordEncrypt.hashPassword(ud.getPassword());
            String query1 = "select * from user where email = ? and password = ?";
            PreparedStatement pt = conn.prepareStatement(query1);
            pt.setString(1, ud.getEmail());
            pt.setString(2, ePassword);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                UserDetail ud1 = new UserDetail();
                ud1.setId(rs.getInt("id"));
                ud1.setName(rs.getString("name"));
                ud1.setEmail(rs.getString("email"));
                return ud1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public UserDetail userInfo(int id){
        try{
            String query1 = "select * from user where id = ?";
            PreparedStatement pt = conn.prepareStatement(query1);
            pt.setInt(1, id);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                UserDetail ud1 = new UserDetail();
                ud1.setId(rs.getInt("id"));
                ud1.setName(rs.getString("name"));
                ud1.setEmail(rs.getString("email"));
                return ud1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
