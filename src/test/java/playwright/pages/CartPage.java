package playwright.pages;

import com.microsoft.playwright.Page;

public class CartPage {

    private final Page page;

    // Locators
    private static final String CART_ITEM = ".cart_item";
    private static final String ITEM_NAME = ".inventory_item_name";
    private static final String ITEM_PRICE = ".inventory_item_price";
    private static final String CHECKOUT_BUTTON = "[data-test='checkout']";
    private static final String CONTINUE_SHOPPING = "[data-test='continue-shopping']";
    private static final String REMOVE_BACKPACK = "[data-test='remove-sauce-labs-backpack']";

    public CartPage(Page page) {
        this.page = page;
    }

    public boolean isOnCartPage() {
        return page.url().contains("cart");
    }

    public int getCartItemCount() {
        return page.locator(CART_ITEM).count();
    }

    public String getProductName() {
        return page.locator(ITEM_NAME).first().textContent();
    }

    public String getProductPrice() {
        return page.locator(ITEM_PRICE).first().textContent();
    }

    public boolean isProductInCart(String productName) {
        return page.locator(ITEM_NAME).allTextContents()
                .stream()
                .anyMatch(name -> name.equals(productName));
    }

    public void removeProduct() {
        page.click(REMOVE_BACKPACK);
    }

    public void clickCheckout() {
        page.click(CHECKOUT_BUTTON);
    }

    public void continueShopping() {
        page.click(CONTINUE_SHOPPING);
    }
}