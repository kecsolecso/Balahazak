package hb;

import java.sql.Timestamp;

public class ChangableContent {
	private Integer id;
	private Integer pageId;
	private String content;
	private Timestamp lastModify;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getPageId() {
		return pageId;
	}
	public void setPageId(Integer pageId) {
		this.pageId = pageId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getLastModify() {
		return lastModify;
	}
	public void setLastModify(Timestamp lastModify) {
		this.lastModify = lastModify;
	}
	
}
