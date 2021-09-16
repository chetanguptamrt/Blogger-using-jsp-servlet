/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.detail;

import java.util.List;

/**
 *
 * @author chetan
 */
public class PublicProfileDetail {

    private int id;
    private String name;
    private List<BlogDetail> list;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<BlogDetail> getList() {
        return list;
    }

    public void setList(List<BlogDetail> list) {
        this.list = list;
    }
    
}
