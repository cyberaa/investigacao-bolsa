
public class Main {
    public static void main(String[] args) {

        MatlabInterface matlab = new MatlabInterface();
        String filePath = "/home/joaquim/Documents/Investigacao/Outliers/investigacao-bolsa/processing/datagen/out.csv";

        boolean temp = matlab.isValidFile(filePath);

        MatlabInterface.accommodateDataReturn file = matlab.accommodateData(filePath,10,2,1,1,2.5);

        String banana = matlab.doPreprocessing(filePath,"linear",2.5);
        String banana2 = matlab.doPreprocessing(filePath,"linear");

        matlab.destroyConnection();

        System.out.println("AQUI " + temp + " DDDD " + file.numberOutliers + " DDDD " + banana + " EEE " + banana2);
    }
}
