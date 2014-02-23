package purificador;
import com.jamal.MatlabCaller;
import com.jamal.client.MatlabClient;
import com.opensymphony.xwork2.ActionSupport;

public class HelloWorld extends ActionSupport {

    public static final String MESSAGE = "Struts is up and running ...";

    public String execute() throws Exception {
        System.setProperty("java.rmi.server.hostname", "25.215.167.69");
        System.out.println("Woohoo!\n");
        //String matlabLocation = "C:\\Program Files\\MATLAB\\R2008a\\bin\\matlab.exe";
        //String matlabLocation = "/usr/local/MATLAB/R2013a/bin/matlab";
        String matlabLocation = "/Applications/MATLAB_R2012b.app/bin/matlab";
//The last argument is the timeout -- Maybe we will need to change it
        MatlabClient matlabClient = new MatlabClient(MatlabCaller.HOST_ADDRESS,matlabLocation,5);
        //MatlabClient matlabClient = new MatlabClient("25.217.0.144", matlabLocation, 100);
        Object[] inArgs = new Object[1];
        inArgs[0] = new int[] { 1, 2, 3, 4 };
        Object[] outputArgs;
        outputArgs = matlabClient.executeMatlabFunction("sum",inArgs, 1);
        double[] result = (double[]) outputArgs[0];
        System.out.println("The sum 1+2+3+4=" + result[0]);
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