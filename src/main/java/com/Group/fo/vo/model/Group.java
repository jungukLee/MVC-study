package com.Group.fo.vo.model;

public class Group {
	private int GroupIdx;
	private int fk_memberIdx;
	private String title;
	private String country;
	private String category;
	private String generation;
	private String introduce;
	private String likes;
	private String cread_at;
	private String image_path;
	
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public int getGroupIdx() {
		return GroupIdx;
	}
	public void setGroupIdx(int groupIdx) {
		GroupIdx = groupIdx;
	}
	public int getFk_memberIdx() {
		return fk_memberIdx;
	}
	public void setFk_memberIdx(int fk_memberIdx) {
		this.fk_memberIdx = fk_memberIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getGeneration() {
		return generation;
	}
	public void setGeneration(String generation) {
		this.generation = generation;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getLikes() {
		return likes;
	}
	public void setLikes(String likes) {
		this.likes = likes;
	}
	public String getCread_at() {
		return cread_at;
	}
	public void setCread_at(String cread_at) {
		this.cread_at = cread_at;
	}
	
	
}
