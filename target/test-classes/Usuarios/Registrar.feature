@registrar
Feature: POST /usuarios - Registrar usuario en ServeRest
  Como usuario del sistema
  Quiero registrar un usuario nuevo
  Para guardar en el sistema

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  @happy @smoke
  Scenario: Registro exitoso devuelve 201
    * def email = 'usuario_' + java.lang.System.currentTimeMillis() + '@qa.com'
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "Usuario Test",
        "email":         "#(email)",
        "password":      "teste123",
        "administrador": "true"
      }
      """
    When method POST
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response._id     == '#string'

  @validacion
  Scenario: Registrar con email ya existente devuelve 400
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "Fulano da Silva",
        "email":         "fulano@qa.com",
        "password":      "teste",
        "administrador": "true"
      }
      """
    When method POST
    Then status 400
    And match response.message == "Este email já está sendo usado"

   







 
