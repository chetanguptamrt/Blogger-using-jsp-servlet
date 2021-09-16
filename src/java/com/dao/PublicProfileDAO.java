/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.detail.BlogDetail;
import com.detail.PublicProfileDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author chetan
 */
public class PublicProfileDAO {
    
    private final Connection conn;

    public PublicProfileDAO(Connection conn) {
        this.conn = conn;
    }
    
    public PublicProfileDetail getPublicProfile(int id){
        PublicProfileDetail ppd = null;
        try{
            String query = "select * from user where id = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                ppd = new PublicProfileDetail();
                ppd.setId(rs.getInt("id"));
                ppd.setName(rs.getString("name"));
                List<BlogDetail> list = new ArrayList<BlogDetail>();
                BlogDetail bd;
                String query1 = "select * from blog where userId = ?";
                PreparedStatement pt1 = conn.prepareStatement(query1);
                pt1.setInt(1, id);
                ResultSet rs1 = pt1.executeQuery();
                while(rs1.next()){
                    bd = new BlogDetail();
                    bd.setId(rs1.getInt("id"));
                    bd.setTitle(rs1.getString("title"));
                    bd.setPhoto(rs1.getString("photo"));
                    list.add(bd);
                }
                ppd.setList(list);
            }
        } catch (SQLException ex) { 
            Logger.getLogger(PublicProfileDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ppd;
    }
    
}
