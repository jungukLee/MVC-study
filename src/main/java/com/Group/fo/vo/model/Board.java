package com.Group.fo.vo.model;

public class Board {
	private int boardIDX;
	private int fk_groupIDX;
	private int fk_memberIDX;
	private String content;
	private String cread_at;
	private String nickname;
	
	public int getBoardIDX() {
		return boardIDX;
	}
	public void setBoardIDX(int boardIDX) {
		this.boardIDX = boardIDX;
	}
	public int getFk_groupIDX() {
		return fk_groupIDX;
	}
	public void setFk_groupIDX(int fk_groupIDX) {
		this.fk_groupIDX = fk_groupIDX;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
}
