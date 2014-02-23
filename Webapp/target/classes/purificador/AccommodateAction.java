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
    int            accommodationMethod;
    int               method;
    String            resultingImagePNG;
    String            resultingOutputFilePath;
    boolean             useSlidingWindow;


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

    public void setAccommodationMethod(int accommodationMethod) {
        this.accommodationMethod = accommodationMethod;
    }

    public void setMethod(int method) {
        this.method = method;
    }

    public void doAjaxWork() {
        System.out.println(this);

        MatlabInterface.AccommodateDataReturn ret;

        if ( useSlidingWindow ) {
            ret =  client.accomodateData(windowSize,windowSize-1,method,
                                     accommodationMethod,methodArgument);
        } else {
            ret =  client.accomodateData(windowSize,windowOverlap,method,
                                         accommodationMethod,methodArgument);
        }


        if ( ret == null ) {
            ajaxSuccess(); return; //FIXME: testing
            //ajaxFailure(); return;
        }

        String origPath = ret.graphicFilePath;//"/Users/jorl17/Pictures/capa.png";
        String imagesPath = getServletContext().getRealPath("images");
        String targetFileNamePlusSlash = "/" + new File(origPath).getName();
        //Utils.moveFile(origPath, imagesPath + targetFileNamePlusSlash);
        resultingImagePNG = "images"+ targetFileNamePlusSlash;

        origPath = ret.accommodatedFile;
        String filesPath = getServletContext().getRealPath("files");
        targetFileNamePlusSlash = "/" + new File(origPath).getName();
        //Utils.moveFile(origPath, filesPath + targetFileNamePlusSlash);
        resultingOutputFilePath = "files" + targetFileNamePlusSlash;

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
    public void setUseSlidingWindow(boolean useSlidingWindow) {
        this.useSlidingWindow = useSlidingWindow;
    }
}
