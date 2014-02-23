package purificador;


import org.apache.commons.lang.xwork.StringEscapeUtils;

import java.io.File;
public class SubmitFileAction extends AJAXAction {
    File              file;
    String            contentType;
    String            filename;

    public void setFile(File file1) {
        this.file = file1;
    }

    public void setFileContentType(String temp){
        this.contentType =  temp;
    }

    public void setFilename(String temp){
        this.filename = temp;
    }
    public void doAjaxWork() {

        System.out.println("Submitted file has path: "+ file.getPath() + ", name: "+filename);

        client.setCurrentFile(file, filename);
        ajaxSuccess();

    }
    public boolean isSuccess() {
        return super.isSuccess();
    }
}
