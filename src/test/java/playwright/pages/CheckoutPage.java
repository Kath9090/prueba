package playwright.pages;

import com.microsoft.playwright.Page;

public class CheckoutPage {

    private final Page page;

    // Locators
    private static final String FIRST_NAME = "[data-test='firstName']";
    private static final String LAST_NAME = "[data-test='lastName']";
    private static final String POSTAL_CODE = "[data-test='postalCode']";
    private static final String CONTINUE_BUTTON = "[data-test='continue']";
    private static final String FINISH_BUTTON = "[data-test='finish']";
    private static final String CONFIRMATION_HEADER = ".complete-header";
    private static final String CONFIRMATION_TEXT = ".complete-text";
    private static final String ERROR_MESSAGE = "[data-test='error']";
    private static final String SUMMARY_TOTAL = ".summary_total_label";

    public CheckoutPage(Page page) {
        this.page = page;
    }

    public boolean isOnCheckoutPage() {
        return page.url().contains("checkout-step-one");
    }

    public boolean isOnOverviewPage() {
        return page.url().contains("checkout-step-two");
    }

    public boolean isOnConfirmationPage() {
        return page.url().contains("checkout-complete");
    }

    public void enterFirstName(String firstName) {
        page.fill(FIRST_NAME, firstName);
    }

    public void enterLastName(String lastName) {
        page.fill(LAST_NAME, lastName);
    }

    public void enterPostalCode(String postalCode) {
        page.fill(POSTAL_CODE, postalCode);
    }

    public void fillCheckoutInfo(String firstName, String lastName, String postalCode) {
        enterFirstName(firstName);
        enterLastName(lastName);
        enterPostalCode(postalCode);
    }

    public void clickContinue() {
        page.click(CONTINUE_BUTTON);
    }

    public void clickFinish() {
        page.click(FINISH_BUTTON);
    }

    public String getConfirmationHeader() {
        return page.locator(CONFIRMATION_HEADER).textContent();
    }

    public String getConfirmationText() {
        return page.locator(CONFIRMATION_TEXT).textContent();
    }

    public String getOrderTotal() {
        return page.locator(SUMMARY_TOTAL).textContent();
    }

    public String getErrorMessage() {
        return page.locator(ERROR_MESSAGE).textContent();
    }
}