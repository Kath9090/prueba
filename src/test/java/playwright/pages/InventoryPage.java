package playwright.pages;

import com.microsoft.playwright.Page;

public class InventoryPage {

    private final Page page;

    // Locators
    private static final String CART_BADGE = ".shopping_cart_badge";
    private static final String CART_LINK = ".shopping_cart_link";
    private static final String ADD_BACKPACK = "[data-test='add-to-cart-sauce-labs-backpack']";
    private static final String ADD_BIKE_LIGHT = "[data-test='add-to-cart-sauce-labs-bike-light']";
    private static final String ADD_BOLT_SHIRT = "[data-test='add-to-cart-sauce-labs-bolt-t-shirt']";
    private static final String PRODUCT_LIST = ".inventory_item";

    public InventoryPage(Page page) {
        this.page = page;
    }

    public boolean isOnInventoryPage() {
        return page.url().contains("inventory");
    }

    public void addProductToCart(String productName) {
        switch (productName) {
            case "Sauce Labs Backpack":
                page.click(ADD_BACKPACK);
                break;
            case "Sauce Labs Bike Light":
                page.click(ADD_BIKE_LIGHT);
                break;
            case "Sauce Labs Bolt T-Shirt":
                page.click(ADD_BOLT_SHIRT);
                break;
            default:
                throw new IllegalArgumentException("Producto no encontrado: " + productName);
        }
    }

    public String getCartBadgeCount() {
        return page.locator(CART_BADGE).textContent();
    }

    public boolean isCartBadgeVisible() {
        return page.locator(CART_BADGE).isVisible();
    }

    public void goToCart() {
        page.click(CART_LINK);
    }

    public int getProductCount() {
        return page.locator(PRODUCT_LIST).count();
    }
}