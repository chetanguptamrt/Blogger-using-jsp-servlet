/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import com.detail.BlogDetail;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author chetan
 */
public class BlogDAO {
    
    private final Connection conn;

    public BlogDAO(Connection conn) {
        this.conn = conn;
    }
    
    public synchronized String insertBlog(BlogDetail bd, String lastName) {
        try{
            StringBuilder thumbnail;
            String query0 = "select * from blog where photo = ? and userId = ?";
            PreparedStatement pt0;
            while(true) {
                thumbnail = new StringBuilder("");
                thumbnail.append("thumbnail_").append(bd.getUserId()).append("_").append(getRandom()).append(".").append(lastName);
                pt0= conn.prepareStatement(query0);
                pt0.setString(1, new String(thumbnail));
                pt0.setInt(2, bd.getUserId());
                ResultSet rs0 = pt0.executeQuery();
                if(!rs0.next()){
                    break;
                }
            }
            String query1 = "insert into blog (title, photo, content, userId) values (?,?,?,?)";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setString(1, bd.getTitle());
            pt1.setString(2, new String(thumbnail));
            pt1.setString(3, bd.getContent());
            pt1.setInt(4, bd.getUserId());
            int i = pt1.executeUpdate();
            if(i==1){
                return new String(thumbnail);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "no";
    }
    
    private int getRandom(){
       return (int)(Math.random()*(999999999-111111111+1)+111111111);
    }
    
    public String editBlog(BlogDetail bd){
        try{
            String query = "update blog set edit = true, title = ?, content = ? where id = ? and userId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setString(1, bd.getTitle());
            pt.setString(2, bd.getContent());
            pt.setInt(3, bd.getId());
            pt.setInt(4, bd.getUserId());
            int i = pt.executeUpdate();
            System.out.println(bd.getId()+" "+bd.getTitle()+" "+bd.getUserId());
            System.out.println("update blog set title = "+bd.getTitle()+", content = "+bd.getContent()+" where id = "+bd.getId()+" and userId = "+bd.getUserId());
            if(i==1){
                return "done";
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "no";
    }
    
    public BlogDetail getEditBlogDetail(int id, int userId) {
        try {
            String query = "select * from blog where id = ? and userId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            pt.setInt(2, userId);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                BlogDetail bd = new BlogDetail();
                bd.setId(rs.getInt("id"));
                bd.setTitle(rs.getString("title"));
                bd.setContent(rs.getString("content"));
                return bd;
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public BlogDetail getBlogDetail(int id) {
        try {
            String query = "select * from blog where id = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                BlogDetail bd = new BlogDetail();
                bd.setId(rs.getInt("id"));
                bd.setTitle(rs.getString("title"));
                bd.setContent(rs.getString("content"));
                bd.setEdit(rs.getBoolean("edit"));
                bd.setPhoto(rs.getString("photo"));
                bd.setUserId(rs.getInt("userId"));
                return bd;
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }
    
    public String deleteBlog(int id, int userId, String path) {
        try {
            String query1 = "select * from blog where id = ? and userId = ?";
            PreparedStatement pt1 = conn.prepareStatement(query1);
            pt1.setInt(1, id);
            pt1.setInt(2, userId);
            ResultSet rs = pt1.executeQuery();
            if(rs.next()){
                File file = new File(path+rs.getString("photo"));
                file.delete();
            }
            String query = "delete from blog where id = ? and userId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, id);
            pt.setInt(2, userId);
            int i = pt.executeUpdate();
            if(i==1) {
                return "done";
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return "no";
    }
    
    public List<BlogDetail> getShowBlog(int userId){
        List<BlogDetail> list = new ArrayList<BlogDetail>();
        BlogDetail bd;
        try {
            String query = "select * from blog where userId = ?";
            PreparedStatement pt = conn.prepareStatement(query);
            pt.setInt(1, userId);
            ResultSet rs = pt.executeQuery();
            while(rs.next()){
                bd = new BlogDetail();
                bd.setId(rs.getInt("id"));
                bd.setTitle(rs.getString("title"));
                bd.setEdit(rs.getBoolean("edit"));
                bd.setPhoto(rs.getString("photo"));
                bd.setTime(rs.getTimestamp("time").toString());
                list.add(bd);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return list;
    }
    
}
