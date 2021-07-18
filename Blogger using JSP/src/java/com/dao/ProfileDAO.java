/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import com.javaclass.PasswordEncrypt;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author chetan
 */
public class ProfileDAO {
    
    private final Connection conn;

    public ProfileDAO(Connection conn) {
        this.conn = conn;
    }
    
    public String updateName(String name, int userId){
        try{
            String query = "update user set name = ? where id = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, name);
            pt.setInt(2, userId);
            int i = pt.executeUpdate();
            if(i==1){
                return "done";
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return "no";
    }
    
    public String changePassword(String oPassword, String nPassword, int userId) {
        try{
            String eoPassword = PasswordEncrypt.hashPassword(oPassword);
            String enPassword = PasswordEncrypt.hashPassword(nPassword);
            String query = "select * from user where id = ? and password = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, userId);
            pt.setString(2, eoPassword);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                String query1 = "update user set password = ? where id = ?";
                PreparedStatement pt1 = conn.prepareStatement(query1);
                pt1.setString(1, enPassword);
                pt1.setInt(2, userId);
                int i = pt1.executeUpdate();
                if(i==1) {
                    return "done";
                }
            } else {
                return "invalid";
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return "no";
    }

    public String deleteProfile(int userId, String path) {
        try{
            String query1 = "select * from blog where userId = ?";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setInt(1, userId);
            ResultSet rs = pt1.executeQuery();
            while(rs.next()){
                File file = new File(path+rs.getString("photo"));
                file.delete();
            }
            String query = "delete from user where id = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, userId);
            int i = pt.executeUpdate();
            if(i==1){
                return "done";
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        
        return "no";
    }
    
}
