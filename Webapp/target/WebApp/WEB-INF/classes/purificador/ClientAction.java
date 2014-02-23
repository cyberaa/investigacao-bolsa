package purificador;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.interceptor.SessionAware;
import java.util.Map;

public abstract class ClientAction extends ActionSupport implements SessionAware {
    protected Map<String, Object> session;
    protected Client              client;
    /**
     * Needed by SessionAware
     * @param session Used by struts to set the session
     */
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    /**
     * Synchronizes this.client and the current session, either creating it if session doesn't have it,
     * or loading it from the session if it exists.
     */
    private void getClientSession() {
        if ( !session.containsKey("client") ) {
            this.client = new Client();
            session.put("client", client);
        } else
            this.client = (Client) session.get("client");
    }

    public final String execute() throws Exception {
        getClientSession();

        return doWork();
    }

    public abstract String doWork();
}