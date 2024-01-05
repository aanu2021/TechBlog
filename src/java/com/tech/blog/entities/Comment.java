package com.tech.blog.entities;

public class Comment {
    private int cid;
    private int pid;
    private int uid;
    private String content;

    public Comment(int cid, int pid, int uid, String content) {
        this.cid = cid;
        this.pid = pid;
        this.uid = uid;
        this.content = content;
    }

    public Comment(int pid, int uid, String content) {
        this.pid = pid;
        this.uid = uid;
        this.content = content;
    }

    public Comment() {
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
    
}
