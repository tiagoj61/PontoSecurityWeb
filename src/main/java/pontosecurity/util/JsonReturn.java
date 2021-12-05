package pontosecurity.util;

public class JsonReturn {

    private String mensagem;
    private boolean success;

    public JsonReturn(boolean success) {
        this.success = success;
    }

    public JsonReturn(String mensagem, boolean success) {
        this.mensagem = mensagem;
        this.success = success;
    }

    public JsonReturn() {
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

}
