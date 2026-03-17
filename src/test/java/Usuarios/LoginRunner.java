
package Usuarios;

import com.intuit.karate.junit5.Karate;

public class LoginRunner {

    @Karate.Test
    Karate testTodosLosUsuarios() {
        return Karate.run("Login", "Usuarios", "Registrar", "BuscarUsuario")
                .relativeTo(getClass())
                .outputHtmlReport(true)
                .outputCucumberJson(true);
    }
}