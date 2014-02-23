package purificador;

import java.io.File;

import static org.apache.struts2.ServletActionContext.getServletContext;

/**
 * Created with IntelliJ IDEA. User: jorl17 Date: 22/02/14 Time: 20:30 To change this template use File | Settings |
 * File Templates.
 */
public class Client {
    private File            currentFile;
    private String          currentFileTitle;
    private MatlabInterface matlab;

    Client() {
        matlab = new MatlabInterface();
    }

    public boolean addFile(File f, String title) {
        String finalPath = f.getAbsolutePath() + title;
        Utils.moveFile(f.getAbsolutePath(), f.getAbsolutePath() + title);

        if ( matlab.isValidFile(finalPath) ) {
            this.currentFileTitle = title;
            this.currentFile = f;
            return true;
        }

        return false;
    }

    public boolean addToBePreprocessedFile(File f, String title, boolean resampleEnabled, double resamplePeriod,
            boolean           fillInMissingValues,
            String            missingValueFillingMethod) {
        String origPath = f.getAbsolutePath();
        String filesPath = getServletContext().getRealPath("files");
        String targetFileNamePlusSlash = "/" + new File(origPath).getName();
        String finalPath = filesPath + targetFileNamePlusSlash;
        //Utils.moveFile(origPath, filesPath + targetFileNamePlusSlash); FIXME
        String result;
        if ( resampleEnabled )
            result = matlab.doPreprocessing(finalPath, missingValueFillingMethod);
        else
            result = matlab.doPreprocessing(finalPath, missingValueFillingMethod, resamplePeriod);

        if (result == null)
            return false;

        // Move the file to a valid location
        currentFileTitle = new File(result).getName();
        finalPath = filesPath + "/" + currentFileTitle;
        //Utils.moveFile(result, finalPath); FIXME
        currentFile = new File(finalPath);

        return true;
    }

    public MatlabInterface.AccommodateDataReturn accomodateData(int windowSize, int windowOverlap, int model,
                                                                int accomodationType, double param1) {
        if ( currentFile == null ) return null;
        return matlab.accommodateData(currentFile.getAbsolutePath(), windowSize, windowOverlap, model,
                                      accomodationType, param1);
    }

    public File getCurrentFile() {
        return currentFile;
    }

}
