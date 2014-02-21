package tutorial;
import com.opensymphony.xwork2.ActionSupport;

public class HelloWorld extends ActionSupport {

    public static final String MESSAGE = "Struts is up and running ...";

    public String execute() throws Exception {
        System.out.println("Woohoo!\n");
        setMessage(MESSAGE);
        return SUCCESS;
    }

    private String message;

    public void setMessage(String message){
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}