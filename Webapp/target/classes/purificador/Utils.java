package purificador;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 * Created with IntelliJ IDEA. User: jorl17 Date: 23/02/14 Time: 04:51 To change this template use File | Settings |
 * File Templates.
 */
public class Utils {
    public static void moveFile(String src, String out) {
        Path original = Paths.get(src);
        Path destination = Paths.get(out);
        try {
            Files.move(original, destination,
                       StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
}
