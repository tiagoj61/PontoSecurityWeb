package pontosecurity.exception;

public class LoginExpiradoException extends Exception {

    public LoginExpiradoException() {
        super("Seu acesso expirou por inatividade ou por questões de segurança do sistema. Favor re-faça seu acesso.");
    }
}
