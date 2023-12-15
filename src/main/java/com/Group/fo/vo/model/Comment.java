package com.Group.fo.vo.model;

public class Comment {
	private int commentIDX;
	private int fk_boardIDX;
	private int fk_memberIDX;
	private String content;
	private String cread_at;
	
	public int getCommentIDX() {
		return commentIDX;
	}
	public void setCommentIDX(int commentIDX) {
		this.commentIDX = commentIDX;
	}
	public int getFk_boardIDX() {
		return fk_boardIDX;
	}
	public void setFk_boardIDX(int fk_boardIDX) {
		this.fk_boardIDX = fk_boardIDX;
	}
	public int getFk_memberIDX() {
		return fk_memberIDX;
	}
	public void setFk_memberIDX(int fk_memberIDX) {
		this.fk_memberIDX = fk_memberIDX;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCread_at() {
		return cread_at;
	}
	public void setCread_at(String cread_at) {
		this.cread_at = cread_at;
	}
}
