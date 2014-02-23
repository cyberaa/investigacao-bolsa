package purificador;

import java.io.File;

/**
 * Created with IntelliJ IDEA. User: jorl17 Date: 22/02/14 Time: 20:30 To change this template use File | Settings |
 * File Templates.
 */
public class Client {
    private File   currentFile;
    private String currentFileTitle;

    public void setCurrentFile(File f, String title) {
        this.currentFile = f;
        this.currentFileTitle = title;
    }
}
