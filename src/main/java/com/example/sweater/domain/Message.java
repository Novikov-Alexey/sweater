package com.example.sweater.domain;

import javax.persistence.*;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    private String text;
    private String tag;
    private String filename;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dsid_user")
    private User author;

    public Message() {
    }

    public Message(String tag, String text, User user) {
        this.tag = tag;
        this.text = text;
        this.author = user;
    }

    public User getAuthor() {
        return author;
    }

    public String getAuthorName() {
        return author != null ? author.getUsername() : "<none>";
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
}
