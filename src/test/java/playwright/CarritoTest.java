package playwright;

import com.microsoft.playwright.*;
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CarritoTest {

    static Playwright playwright;
    static Browser browser;
    BrowserContext context;
    Page page;

    @BeforeAll
    static void launchBrowser() {
        playwright = Playwright.create();
        browser = playwright.chromium().launch(
            new BrowserType.LaunchOptions().setHeadless(false)
        );
    }

    @AfterAll
    static void closeBrowser() {
        playwright.close();
    }

    @BeforeEach
    void login() {
        context = browser.newContext();
        page = context.newPage();
        page.navigate("https://www.saucedemo.com/");
        page.fill("#user-name", "standard_user");
        page.fill("#password", "secret_sauce");
        page.click("#login-button");
    }

    @AfterEach
    void closeContext() {
        context.close();
    }

    @Test
    @Order(3)
    void agregarProductoAlCarrito() {
        page.click("[data-test='add-to-cart-sauce-labs-backpack']");

        String badge = page.locator(".shopping_cart_badge").textContent();
        assertEquals("1", badge);
        System.out.println("✅ Producto agregado al carrito correctamente");
    }

    @Test
    @Order(4)
    void verProductosEnElCarrito() {
        page.click("[data-test='add-to-cart-sauce-labs-backpack']");
        page.click(".shopping_cart_link");

        assertTrue(page.url().contains("cart"));
        String producto = page.locator(".inventory_item_name").textContent();
        assertEquals("Sauce Labs Backpack", producto);
        System.out.println("✅ Producto visible en el carrito correctamente");
    }
}