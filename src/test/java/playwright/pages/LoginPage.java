package playwright.pages;

import com.microsoft.playwright.Page;

public class LoginPage {

    private final Page page;

    // Locators
    private static final String USERNAME_INPUT = "#user-name";
    private static final String PASSWORD_INPUT = "#password";
    private static final String LOGIN_BUTTON = "#login-button";
    private static final String ERROR_MESSAGE = "[data-test='error']";

    public LoginPage(Page page) {
        this.page = page;
    }

    public void navigate() {
        page.navigate("https://www.saucedemo.com/");
    }

    public void enterUsername(String username) {
        page.fill(USERNAME_INPUT, username);
    }

    public void enterPassword(String password) {
        page.fill(PASSWORD_INPUT, password);
    }

    public void clickLoginButton() {
        page.click(LOGIN_BUTTON);
    }

    public void login(String username, String password) {
        enterUsername(username);
        enterPassword(password);
        clickLoginButton();
    }

    public String getErrorMessage() {
        return page.locator(ERROR_MESSAGE).textContent();
    }

    public boolean isErrorDisplayed() {
        return page.locator(ERROR_MESSAGE).isVisible();
    }

    public String getCurrentUrl() {
        return page.url();
    }
}