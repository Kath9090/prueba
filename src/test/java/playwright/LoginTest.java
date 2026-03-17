package playwright;

import com.microsoft.playwright.*;
import com.microsoft.playwright.options.AriaRole;
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class LoginTest {

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
    void createContextAndPage() {
        context = browser.newContext();
        page = context.newPage();
        page.navigate("https://www.saucedemo.com/");
    }

    @AfterEach
    void closeContext() {
        context.close();
    }

    @Test
    @Order(1)
    void loginConCredencialesValidas() {
        page.fill("#user-name", "standard_user");
        page.fill("#password", "secret_sauce");
        page.click("#login-button");

        assertTrue(page.url().contains("inventory"));
        System.out.println("✅ Login exitoso con credenciales válidas");
    }

    @Test
    @Order(2)
    void loginConCredencialesInvalidas() {
        page.fill("#user-name", "usuario_invalido");
        page.fill("#password", "password_invalido");
        page.click("#login-button");

        String error = page.locator("[data-test='error']").textContent();
        assertTrue(error.contains("Username and password do not match"));
        System.out.println("✅ Error mostrado correctamente con credenciales inválidas");
    }
}