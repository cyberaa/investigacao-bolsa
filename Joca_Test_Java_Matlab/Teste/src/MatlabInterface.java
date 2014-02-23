import com.jamal.JamalException;
import com.jamal.MatlabCaller;
import com.jamal.client.MatlabClient;

public class MatlabInterface {

    private String matlabLocation = "/usr/local/MATLAB/R2013a/bin/matlab";
    private MatlabClient matlabClient;
    private Object[] inArgs;
    private Object[] output;

    public class accommodateDataReturn{
        public String accommodatedFile;
        public String graphicFileName;
        public int numberOutliers;
    }

    MatlabInterface(){
        try{
            matlabClient = new MatlabClient(MatlabCaller.HOST_ADDRESS,matlabLocation,40);
            inArgs = new Object[1];

            inArgs[0] = "processing";
            matlabClient.executeMatlabFunction("addpath",inArgs,0);

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
            this.matlabClient.shutDownServer();
        } catch (JamalException e) {
            e.printStackTrace();
        }
    }

    public accommodateDataReturn accommodateData(String filePath, int w_size, int w_overlap, int model,
                                  int accommodation_type, double param1){
        try {
            inArgs = new Object[6];
            inArgs[0] = filePath;
            inArgs[1] = w_size;
            inArgs[2] = w_overlap;
            inArgs[3] = model;
            inArgs[4] = accommodation_type;
            inArgs[5] = param1;

            output = matlabClient.executeMatlabFunction("remote_accommodate_data",inArgs,3);
            accommodateDataReturn temp = new accommodateDataReturn();

            temp.accommodatedFile = (String)output[0];
            temp.graphicFileName = (String)output[1];
            String temp1 = (String)output[2];

            temp.numberOutliers = Integer.parseInt(temp1);

            return temp;

        } catch (JamalException e) {
            return null;
        }
    }

    public boolean isValidFile(String filePath){
        try {
            inArgs[0] = filePath;
            output = matlabClient.executeMatlabFunction("get_data_from_file",inArgs,3);
            double[] status = (double[])output[0];
            return status[0] == 1.0;
        } catch (JamalException e) {
            return false;
        }
    }
}
