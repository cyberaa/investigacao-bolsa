package purificador;

import com.jamal.JamalException;
import com.jamal.MatlabCaller;
import com.jamal.client.MatlabClient;

public class MatlabInterface {

    //private String MATLAB_LOCATION = "/usr/local/MATLAB/R2013a/bin/matlab";
    private String MATLAB_LOCATION = "C:\\Program Files\\MATLAB\\R2008a\\bin\\matlab.exe";
    private MatlabClient matlabClient;


    public class AccommodateDataReturn {
        public String accommodatedFile;
        public String graphicFilePath;
        public int    numberOutliers;
    }

    MatlabInterface() {
        init();
    }

    public void init() {
        Object[] inArgs;
        try {
            matlabClient = new MatlabClient(MatlabCaller.HOST_ADDRESS, MATLAB_LOCATION, 40);
            inArgs = new Object[1];

            inArgs[0] = "processing";
            matlabClient.executeMatlabFunction("addpath", inArgs, 0);

            inArgs[0] = "processing/datagen";
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

            inArgs[0] = "processing/methods";
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

            inArgs[0] = "GUI";
            matlabClient.executeMatlabFunction("addpath",inArgs,0);
        }catch(JamalException e){
            e.printStackTrace();
        }
    }

    public void destroyConnection(){
        try {
            if ( this.matlabClient != null )
                this.matlabClient.shutDownServer();
        } catch (JamalException e) {
            e.printStackTrace();
        }
    }

    public AccommodateDataReturn accommodateData(String filePath, int w_size, int w_overlap, int model,
                                                 int accommodation_type, double param1){
        if ( matlabClient == null ) {
            init();
            if ( matlabClient == null)
                return null;
        }
        Object[] inArgs;
        Object[] output;
        try {
            inArgs = new Object[6];
            inArgs[0] = filePath;
            inArgs[1] = w_size;
            inArgs[2] = w_overlap;
            inArgs[3] = model;
            inArgs[4] = accommodation_type;
            inArgs[5] = param1;

            output = matlabClient.executeMatlabFunction("remote_accommodate_data",inArgs,3);
            AccommodateDataReturn temp = new AccommodateDataReturn();

            temp.accommodatedFile = (String)output[0];
            temp.graphicFilePath = (String)output[1];
            String temp1 = (String)output[2];

            temp.numberOutliers = Integer.parseInt(temp1);

            return temp;

        } catch (JamalException e) {
            return null;
        }
    }

    public String doPreprocessing(String filePath, String method){
        if ( matlabClient == null ) {
            init();
            if ( matlabClient == null)
                return null;
        }
        return doPreprocessing(filePath, method,-1);
    }

    public String doPreprocessing(String filePath, String method, double ts){
        if ( matlabClient == null ) {
            init();
            if ( matlabClient == null)
                return null;
        }
        Object[] inArgs;
        Object[] output;
        try {
            if (ts>0){
                inArgs = new Object[3];
                inArgs[2] = ts;
            }
            else
                inArgs = new Object[2];
            inArgs[0] = filePath;
            inArgs[1] = method;
            output = matlabClient.executeMatlabFunction("preprocessing",inArgs,1);
            return (String)output[0];
        } catch (JamalException e) {
            return null;
        }
    }

    public boolean isValidFile(String filePath){
        if ( matlabClient == null ) {
            init();
            if ( matlabClient == null)
                return false;
        }
        Object[] inArgs;
        Object[] output;
        try {
            inArgs = new Object[1];
            inArgs[0] = filePath;
            output = matlabClient.executeMatlabFunction("get_data_from_file",inArgs,3);
            double[] status = (double[])output[0];
            return status[0] == 1.0;
        } catch (JamalException e) {
            return false;
        }
    }
}
