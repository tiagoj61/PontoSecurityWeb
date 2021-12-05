package pontosecurity.commons;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.json.annotations.JSON;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import pontosecurity.util.JsonReturn;

@ParentPackage("json-default")
public abstract class GenericAction extends ActionSupport implements Preparable, ServletRequestAware, ServletResponseAware {

    public JsonReturn jsonReturn;
    private String redirectURL;
    private String logger;
    public static HttpServletRequest request;
    public static HttpServletResponse response;

    private String userMenu;


    public GenericAction() {
    }


    protected String testarCookie() {
        String hash = "";

        Cookie uid = null;
        Cookie biscoitos[] = request.getCookies();
        if (biscoitos != null) {
            for (Cookie biscoito : biscoitos) {
                if (biscoito.getName().equals("uid")) {
                    uid = biscoito;
                    break;
                }
            }
        }

        try {
            if (uid != null) {
                hash = uid.getValue();
            }
        } catch (Exception e) {
        }
        return hash;
    }



    @JSON(serialize = false)
    public String getRedirectURL() {
        return redirectURL;
    }

    public void setRedirectURL(String redirectURL) {
        this.redirectURL = redirectURL;
    }

    @JSON(serialize = false)
    public Date getCurrentDate() {
        return new Date();
    }

    @JSON(serialize = false)
    public String getUserMenu() {
        return userMenu;
    }

    public void setUserMenu(String userMenu) {
        this.userMenu = userMenu;
    }


    public JsonReturn getJsonReturn() {
        return jsonReturn;
    }

    @JSON(serialize = false)
    public String getLogger() {
        return logger;
    }

    public void setLogger(String logger) {
        this.logger = logger;
    }

}
