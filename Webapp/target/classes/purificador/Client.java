package purificador;

import java.io.File;

/**
 * Created with IntelliJ IDEA. User: jorl17 Date: 22/02/14 Time: 20:30 To change this template use File | Settings |
 * File Templates.
 */
public class Client {
    private File   currentFile;
    private String currentFileTitle;
    private MatlabInterface matlab;

    Client() {
        matlab = new MatlabInterface();
    }

    public boolean addFile(File f, String title) {
        String finalPath =f.getAbsolutePath() + title;
        Utils.moveFile(f.getAbsolutePath(), f.getAbsolutePath() + title );

        if ( matlab.isValidFile(finalPath) ) {
            this.currentFileTitle = title;
            this.currentFile = f;
            return true;
        }

        return false;
    }

    public MatlabInterface.AccommodateDataReturn accomodateData(int windowSize, int windowOverlap, int model,
                                                                int accomodationType, double param1) {
        if ( currentFile == null ) return null;
        return matlab.accommodateData(currentFile.getAbsolutePath(), windowSize, windowOverlap, model,
                                      accomodationType, param1);
    }
}
