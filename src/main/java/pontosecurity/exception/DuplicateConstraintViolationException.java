/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pontosecurity.exception;

/**
 *
 * @author links
 */
public class DuplicateConstraintViolationException extends Exception {

    public DuplicateConstraintViolationException(String duplicacao) {
        super("O registro informado já encontra-se cadastrado no sistema.<br/><strong>" + duplicacao + "</strong>");
    }

}
