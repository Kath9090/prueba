package playwright;

import com.microsoft.playwright.*;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import static org.junit.jupiter.api.Assertions.*;

public class SauceDemoSteps {

    static Playwright playwright = Playwright.create();
    static Browser browser = playwright.chromium().launch(
        new BrowserType.LaunchOptions().setHeadless(false)
    );
    Page page;

    @Before
    public void setup() {
        page = browser.newPage();
    }

    @After
    public void teardown() {
        page.close();
    }

    @Given("el usuario está en la página de login")
    public void usuarioEnPaginaLogin() {
        page.navigate("https://www.saucedemo.com/");
    }

    @When("el usuario ingresa usuario {string} y contraseña {string}")
    public void ingresarCredenciales(String usuario, String password) {
        page.fill("#user-name", usuario);
        page.fill("#password", password);
    }

    @When("hace clic en el botón de login")
    public void hacerClicLogin() {
        page.click("#login-button");
    }

    @Then("el usuario es redirigido a la página de productos")
    public void verificarPaginaProductos() {
        assertTrue(page.url().contains("inventory"));
        System.out.println("✅ Login exitoso");
    }

    @Then("se muestra un mensaje de error de credenciales")
    public void verificarMensajeError() {
        String error = page.locator("[data-test='error']").textContent();
        assertTrue(error.contains("Username and password do not match"));
        System.out.println("✅ Error mostrado correctamente");
    }

    @Given("el usuario ha iniciado sesión correctamente")
    public void loginCorrecto() {
        page.navigate("https://www.saucedemo.com/");
        page.fill("#user-name", "standard_user");
        page.fill("#password", "secret_sauce");
        page.click("#login-button");
    }

    @When("el usuario agrega el producto {string} al carrito")
    public void agregarProducto(String producto) {
        page.click("[data-test='add-to-cart-sauce-labs-backpack']");
    }

    @Then("el carrito muestra {string} producto")
    public void verificarBadgeCarrito(String cantidad) {
        String badge = page.locator(".shopping_cart_badge").textContent();
        assertEquals(cantidad, badge);
        System.out.println("✅ Producto agregado correctamente");
    }

    @When("el usuario va al carrito")
    public void irAlCarrito() {
        page.click(".shopping_cart_link");
    }

    @Then("el carrito contiene el producto {string}")
    public void verificarProductoEnCarrito(String nombreProducto) {
        assertTrue(page.url().contains("cart"));
        String producto = page.locator(".inventory_item_name").textContent();
        assertEquals(nombreProducto, producto);
        System.out.println("✅ Producto visible en el carrito");
    }

    @When("el usuario completa el checkout con nombre {string} apellido {string} y código postal {string}")
    public void completarCheckout(String nombre, String apellido, String cp) {
        page.click("[data-test='checkout']");
        page.fill("[data-test='firstName']", nombre);
        page.fill("[data-test='lastName']", apellido);
        page.fill("[data-test='postalCode']", cp);
        page.click("[data-test='continue']");
        page.click("[data-test='finish']");
    }

    @Then("se muestra el mensaje de confirmación {string}")
    public void verificarConfirmacion(String mensaje) {
        String confirmacion = page.locator(".complete-header").textContent();
        assertEquals(mensaje, confirmacion);
        System.out.println("✅ Compra completada correctamente");
    }
}