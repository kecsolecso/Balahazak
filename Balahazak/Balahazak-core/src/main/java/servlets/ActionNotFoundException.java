package servlets;

/**
 *
 * @author kecso
 */
public class ActionNotFoundException extends RuntimeException {

    public ActionNotFoundException(String actionName) {
        super("Action not found: " + actionName);
    }
}
