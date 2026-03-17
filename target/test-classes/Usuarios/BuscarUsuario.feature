@buscarUsuario
Feature: GET /usuarios/{_id} - Buscar usuario por ID en ServeRest
  Como administrador del sistema
  Quiero buscar un usuario por su ID
  Para consultar su informacion por ID

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  # HAPPY PATH
  @happy @smoke
  Scenario: Buscar usuario existente por ID devuelve 200
    
    * def email = 'buscar_' + java.lang.System.currentTimeMillis() + '@qa.com'
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "Usuario Buscar",
        "email":         "#(email)",
        "password":      "teste123",
        "administrador": "true"
      }
      """
    When method POST
    Then status 201
    * def usuarioId = response._id

    # Ahora buscamos por el ID obtenido
    Given path '/usuarios/' + usuarioId
    When method GET
    Then status 200
    And match response ==
      """
      {
        nome:          '#string',
        email:         '#string',
        password:      '#string',
        administrador: '#string',
        _id:           '#string'
      }
      """
    And match response._id == usuarioId

  # VALIDACION — ID inexistente
  @validacion
  Scenario: Buscar usuario con ID inexistente devuelve 400
    Given path '/usuarios/idquonoexiste123'
    When method GET
    Then status 400
    And match response.message == "Usuário não encontrado"
