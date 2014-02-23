package purificador;

import java.io.File;

import static org.apache.struts2.ServletActionContext.getServletContext;

/**
 * Created with IntelliJ IDEA. User: jorl17 Date: 23/02/14 Time: 03:58 To change this template use File | Settings |
 * File Templates.
 */
public class AccommodateAction  extends AJAXAction {
    int               windowSize;
    int               windowOverlap;
    double            methodArgument;
    String            accommodationMethod;
    int               method;
    String            resultingImagePNG;
    String            resultingOutputFilePath;


    public void setWindowSize(int windowSize) {
        this.windowSize = windowSize;
    }

    public void setWindowOverlap(String windowOverlap) {
        if ( windowOverlap.isEmpty() ) return;
        this.windowOverlap = Integer.valueOf(windowOverlap);
    }

    public void setMethodArgument(double methodArgument) {
        this.methodArgument = methodArgument;
    }

    public void setAccommodationMethod(String accommodationMethod) {
        this.accommodationMethod = accommodationMethod;
    }

    public void setMethod(int method) {
        this.method = method;
    }

    public void doAjaxWork() {
        System.out.println(this);
        String origPath = "/Users/jorl17/Pictures/capa.png";
        String imagesPath = getServletContext().getRealPath("images");
        String targetFileNamePlusSlash = "/" + new File(origPath).getName();
        //Utils.moveFile(origPath, imagesPath + targetFileNamePlusSlash);

        resultingImagePNG = "images"+ targetFileNamePlusSlash;
        resultingOutputFilePath = "Hakuna Matata";
        ajaxSuccess();

    }
    public boolean isSuccess() {
        return super.isSuccess();
    }

    @Override
    public String toString() {
        return "AccommodateAction{" +
                "windowSize=" + windowSize +
                ", windowOverlap=" + windowOverlap +
                ", methodArgument=" + methodArgument +
                ", accommodationMethod='" + accommodationMethod + '\'' +
                ", method='" + method + '\'' +
                '}';
    }

    public String getResultingImagePNG() {
        return resultingImagePNG;
    }

    public String getResultingOutputFilePath() {
        return resultingOutputFilePath;
    }
}
