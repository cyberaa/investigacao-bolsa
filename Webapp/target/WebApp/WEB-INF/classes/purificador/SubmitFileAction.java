package purificador;


import org.apache.commons.lang.xwork.StringEscapeUtils;

import java.io.File;
public class SubmitFileAction extends AJAXAction {
    File              file;
    String            contentType;
    String            filename;
    boolean           resampleEnabled;
    double            resamplePeriod;
    boolean           fillInMissingValues;
    String            missingValueFillingMethod;
    boolean           preprocessData;
    String            errorMsg;

    String outputFilePath;

    public void setFile(File file1) {
        this.file = file1;
    }

    public void setFileContentType(String temp) {
        this.contentType = temp;
    }

    public void setFilename(String temp) {
        this.filename = temp;
    }

    public void setResamplePeriod(String resamplePeriod) {
        if ( resamplePeriod == null || resamplePeriod.isEmpty() )
            return;
        this.resamplePeriod = Double.valueOf(resamplePeriod);
    }

    public void setFillInMissingValues(boolean fillInMissingValues) {
        this.fillInMissingValues = fillInMissingValues;
    }

    public void setMissingValueFillingMethod(String missingValueFillingMethod) {
        this.missingValueFillingMethod = missingValueFillingMethod;
    }

    public void setResampleEnabled(boolean resampleEnabled) {
        this.resampleEnabled = resampleEnabled;
    }

    public void setPreprocessData(boolean preprocessData) {
        this.preprocessData = preprocessData;
    }

    public void doAjaxWork() {
        System.out.println(this);
        if ( preprocessData ) {
            boolean result = client.addToBePreprocessedFile(file, filename, resampleEnabled, resamplePeriod,
                                                            fillInMissingValues, missingValueFillingMethod);
            setAjaxStatus(result);
            if (! result ) {
                errorMsg = "Pre-Processing error or invalid/corrupt file!";
                this.outputFilePath = "ERROR_TEST_FIXME";
            }
            else
                this.outputFilePath = "files/" + client.getCurrentFile().getName();
        } else {
            boolean result = client.addFile(file, filename);
            setAjaxStatus(result);
            if (! result ) {
                errorMsg = "Invalid or Corrupt file!";
            }

        }
        ajaxSuccess(); //FIXME: For debugging
    }
    public boolean isSuccess() {
        return super.isSuccess();
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public String getOutputFilePath() {
        return outputFilePath;
    }

    @Override
    public String toString() {
        return "SubmitFileAction{" +
                "file=" + file +
                ", contentType='" + contentType + '\'' +
                ", filename='" + filename + '\'' +
                ", resampleEnabled=" + resampleEnabled +
                ", resamplePeriod=" + resamplePeriod +
                ", fillInMissingValues=" + fillInMissingValues +
                ", missingValueFillingMethod='" + missingValueFillingMethod + '\'' +
                ", preprocessData=" + preprocessData +
                '}';
    }
}
