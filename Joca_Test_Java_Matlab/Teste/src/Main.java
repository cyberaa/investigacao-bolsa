import com.jamal.*;
import com.jamal.client.MatlabClient;

/**
 * README: Go to http://matlab4java.wordpress.com/instructions/ and follow the instructions! Do not forget to edit
 * Matlab's classpath.txt
 */

public class Main {
    public static void main(String[] args) {
        try {
            //String matlabLocation = "C:\\Program Files\\MATLAB\\R2010a\\bin\\matlab.exe";
            String matlabLocation = "/usr/local/MATLAB/R2013a/bin/matlab";

            //The last argument is the timeout -- Maybe we will need to change it
            MatlabClient matlabClient = new MatlabClient(MatlabCaller.HOST_ADDRESS,matlabLocation,40);

            // First we pass an array of integers and calculate sum in Matlab
            Object[] inArgs = new Object[1];
            inArgs[0] = new int[] { 1, 2, 3, 4 };
            Object[] outputArgs;

            outputArgs = matlabClient.executeMatlabFunction("sum",inArgs, 1);
            double[] result = (double[]) outputArgs[0];
            System.out.println("The sum 1+2+3+4=" + result[0]);

            /**
            * To sum up, when we want to call a Matlab function we just do:
            * "matlabClient.executeMatlabFunction(<function_name>,inputArguments,number_of_output_arguments)"
            */

           //Assuming Matlab has its current folder in the project's main directory -- Check git!
            inArgs[0] = new String("processing");
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

            inArgs[0] = new String("processing/datagen");
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

            inArgs[0] = new String("processing/methods");
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

            //Calling: data = generate_time_series(-1,1,length(t),-5,5);  data = data';
            int[] t = new int[501];
            for (int i=0;i<501;i++)
                t[i] = i;

            inArgs = new Object[5];
            inArgs[0] = -1;
            inArgs[1] = 1;
            inArgs[2] = 501;//t=(0:500)'; --> length(t) = 501
            inArgs[3] = -5;
            inArgs[4] = 5;
            outputArgs = matlabClient.executeMatlabFunction("generate_time_series",inArgs,1);
            double[] data = (double[])outputArgs[0];

            //Lets try a plot now
            inArgs = new Object[1];
            inArgs[0] = "Teste123";
            outputArgs = matlabClient.executeMatlabFunction("untitled",inArgs,1);
            String[] name = (String[])outputArgs;

            System.out.println("The name of the file is " + name);

            matlabClient.shutDownServer();

        } catch (JamalException e) {
            e.printStackTrace();
        }

    }
}
