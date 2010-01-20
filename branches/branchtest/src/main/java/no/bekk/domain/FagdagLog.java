package no.bekk.domain;

import javax.persistence.*;

@Entity
public class FagdagLog {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "LogSeq")
    @SequenceGenerator(name = "LogSeq", sequenceName = "LOG_SEQU", allocationSize = 1)
    private Long id;
    private Long code;
    private String message;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCode() {
        return code;
    }

    public void setCode(Long code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
