package no.example.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tire")
public class Tire {

	private int id;
	private String name;

	public void setId(int id) {
		this.id = id;
	}

	@Id
	@Column(name = "id")
	public int getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

}
