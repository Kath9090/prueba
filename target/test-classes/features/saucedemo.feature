Feature: Sauce Demo - Pruebas automatizadas

  Background:
    Given el usuario está en la página de login

  Scenario: Login con credenciales válidas
    When el usuario ingresa usuario "standard_user" y contraseña "secret_sauce"
    And hace clic en el botón de login
    Then el usuario es redirigido a la página de productos

  Scenario: Login con credenciales inválidas
    When el usuario ingresa usuario "usuario_invalido" y contraseña "password_invalido"
    And hace clic en el botón de login
    Then se muestra un mensaje de error de credenciales

  Scenario: Agregar producto al carrito
    Given el usuario ha iniciado sesión correctamente
    When el usuario agrega el producto "Sauce Labs Backpack" al carrito
    Then el carrito muestra "1" producto

  Scenario: Ver productos en el carrito
    Given el usuario ha iniciado sesión correctamente
    And el usuario agrega el producto "Sauce Labs Backpack" al carrito
    When el usuario va al carrito
    Then el carrito contiene el producto "Sauce Labs Backpack"

  Scenario: Completar proceso de compra
    Given el usuario ha iniciado sesión correctamente
    And el usuario agrega el producto "Sauce Labs Backpack" al carrito
    And el usuario va al carrito
    When el usuario completa el checkout con nombre "Kath" apellido "Test" y código postal "12345"
    Then se muestra el mensaje de confirmación "Thank you for your order!"
